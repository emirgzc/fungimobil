import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/comment/all_comment_widget.dart';
import 'package:fungimobil/widgets/comment/comment_item_widget.dart';
import 'package:fungimobil/widgets/shimmer/shimmer.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';

class CommentListWidget extends StatelessWidget {
  CommentListWidget({
    Key? key,
    required this.tableName,
    required this.defaultItems,
    required this.filter,
    required this.backgroundColor,
  }) : super(key: key);

  String tableName;
  Map<String, dynamic> filter;
  final Color backgroundColor;

  final List<Map<String, dynamic>>? defaultItems;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: Style.shimmerGradient,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(context),
          const SizedBox(
            height: Style.defaultPadding,
          ),
          _buildListView(),
        ],
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: defaultItems == null ? 5 : min(5, defaultItems!.length),
        itemBuilder: (context, index) {
          return _buildItem(defaultItems?[index], context);
        });
  }

  Widget _buildItem(Map<String, dynamic>? data, BuildContext context) {
    return CommentItemWidget(data: data, backgroundColor: backgroundColor,);
  }

  GestureDetector _buildTitle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAllComments(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Yorumlar',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Tüm yorumlar',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future showAllComments(BuildContext context) async {
    var backgroundColor = Colors.white;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Style.defaultRadiusSize),
          topRight: Radius.circular(Style.defaultRadiusSize),
        ),
      ),
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => TableViewModel(),
          child: AllCommentWidget(
            tableName: tableName,
            filter: filter,
            backgroundColor: backgroundColor,
          ),
        );
      },
    );
  }
}
