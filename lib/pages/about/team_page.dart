import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as table;
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_network_image_widget.dart';
import 'package:fungimobil/widgets/html_text_widget.dart';
import 'package:fungimobil/widgets/shimmer/shimmer.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:provider/provider.dart';

import '../../constants/table_util.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Takımımız"),
      body: Shimmer(
        linearGradient: Style.shimmerGradient,
        child: SingleChildScrollView(
          child: Padding(
            padding: Style.defaultPagePadding,
            child: Column(
              children: [
                FutureBuilder<table.TableModel?>(
                  future: _fetchData(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError && snapshot.error != null) {
                      HandleExceptions.handle(exception: snapshot.error, context: context);
                    }
                    List<Map<String, dynamic>>? dataList = snapshot.data?.data;
                    return MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: dataList?.length ?? 5,
                      crossAxisCount: 2,
                      mainAxisSpacing: Style.defautlVerticalPadding,
                      crossAxisSpacing: Style.defautlHorizontalPadding,
                      itemBuilder: (context, index) {
                        return teamCard(dataList?[index], context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<table.TableModel?>? _fetchData(BuildContext context) async {
    try {
      await Future.delayed(Duration(seconds: 5));
      return await Provider.of<TableViewModel>(context, listen: false).fetchTable(
        tableName: TableName.Team.name,
        page: 1,
        limit: 100,
      );
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
    return null;
  }

  Widget teamCard(Map<String, dynamic>? data, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLoading(
          isLoading: data == null,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: CustomNetworkImageWidget(
              imageUrl: data?['image'] == null ? null : Util.imageConvertUrl(imageName: data!['image']),
              height: 500.h,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
          child: ShimmerLoading(
            isLoading: data == null,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                data?["name"] ?? '*' * 20,
                style: TextStyle(
                  fontSize: 56.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        ShimmerLoading(
          isLoading: data == null,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: HtmlTextWidget(
              content: data?["description"],
              isLoading: data == null,
              loadingText: '*' * Random().nextInt(200),
              fontSize: 40.sp,
              color: Style.textGreyColor,
            ),
          ),
        ),
        // Padding(
        //   padding:
        //       EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
        //   child: Text(
        //     dataList[index]["description"],
        //     style: TextStyle(
        //       fontSize: Style.defaultTextSize,
        //       color: Style.secondaryColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
