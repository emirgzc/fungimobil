import 'package:flutter/material.dart';
import 'package:fungimobil/constants/exceptions.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/comment_page_list_item_widget.dart';
import 'package:provider/provider.dart';

import '../../model/table_model.dart' as table;
import '../../viewmodel/table_view_model.dart';
import '../../widgets/shimmer/shimmer.dart';

class CommentListPageArguments{
  CommentListPageArguments({required this.isBlogPage});

  final bool isBlogPage;
}

class CommentListPage extends StatefulWidget {
  const CommentListPage({Key? key, required this.arguments}) : super(key: key);

  final CommentListPageArguments arguments;

  @override
  State<CommentListPage> createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("${widget.arguments.isBlogPage ? 'Blog' : 'Etkinlik'} Yorumlarım"),
      body: Shimmer(
        linearGradient: Style.shimmerGradient,
        child: FutureBuilder<table.TableModel?>(
            future: _fetchData(context),
            builder: (context, snapshot) {
              if (snapshot.hasError && snapshot.error != null) {
                HandleExceptions.handle(
                  exception: CustomException.fromApiMessage('Veriler yüklenirken bir hata meydana geldi. Lütfen tekrar deneyin.'),
                  context: context,
                );
              }
              table.TableModel? tableModel = snapshot.data;
              return ListView.builder(
                itemCount: tableModel?.data?.length ?? 10,
                physics: const BouncingScrollPhysics(),
                padding: Style.defaultPagePadding,
                itemBuilder: (context, index) {
                  Map<String, dynamic>? data = tableModel?.data?[index];
                  return CommentPageListItemWidget(data: data, isBlog: widget.arguments.isBlogPage);
                },
              );
            }),
      ),
    );
  }

  /*Row itemComment(String title, String item) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(item),
      ],
    );
  }*/

  Future<table.TableModel?> _fetchData(BuildContext context) async {
    try {
      var authProvider = context.read<AuthViewModel>();
      var tableProvider = context.read<TableViewModel>();
      var userInfo = await authProvider.getUserInfoFromLocale();
      if (userInfo == null) throw CustomException.fromApiMessage('Kayıtlı kullanıcı verisi bulunamadı.');
      return await tableProvider.fetchTable(
        tableName: widget.arguments.isBlogPage ? TableName.BlogComment.name : TableName.ActivityComment.name,
        page: null,
        limit: null,
        filter: {
          'own_id': userInfo.id ?? '',
          'status': 0,
        },
      );
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
    return null;
  }
}
