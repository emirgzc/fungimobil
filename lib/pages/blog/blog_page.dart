import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/single_record_model.dart';
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/paginable_list_widget.dart';
import 'package:fungimobil/widgets/shimmer/shimmer.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_network_image_widget.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Blog Sayfası"),
      body: Shimmer(
        linearGradient: Style.shimmerGradient,
        child: PaginableList(
          tableName: TableName.Blog.name,
          useShimmerEffectFormat: true,
          itemBuilder: (context, data) {
            return blogCard(context, data);
          },
        ),
      ),
    );
  }

  Widget blogCard(BuildContext context, Map<String, dynamic>? data) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: data == null
                ? null
                : () {
                    Navigator.pushNamed(context, Routes.blogDetailPage, arguments: data["id"]);
                  },
            child: ShimmerLoading(
              isLoading: data == null,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Stack(
                  children: [
                    CustomNetworkImageWidget(
                      imageUrl: Util.imageConvertUrl(imageName: data?["image"] ?? ''),
                      height: 700.h,
                    ),
                    Positioned(
                      bottom: Style.defautlVerticalPadding / 2,
                      right: Style.defautlVerticalPadding / 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: Style.defautlVerticalPadding / 6,
                          horizontal: Style.defautlHorizontalPadding / 4,
                        ),
                        decoration: BoxDecoration(
                          color: Style.secondaryColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(
                            Style.defaultRadiusSize,
                          ),
                        ),
                        child: Text(
                          "Devamını Oku...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Style.defaultTextSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
            child: ShimmerLoading(
              isLoading: data == null,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Text(
                  data?["title"] ?? '*' * 30,
                  style: TextStyle(
                    fontSize: Style.bigTitleTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          /*ShimmerLoading(
              isLoading: data == null,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: HtmlTextWidget(
                  content: data?['content'],
                  maxContentLength: 120,
                  loadingText: '*' * 170,
                  isLoading: data == null,
                  color: Style.textGreyColor,
                ),
              )),*/
          // Text(
          //   data["content"],
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(color: Style.textGreyColor),
          // ),
          Padding(
            padding: EdgeInsets.only(bottom: Style.defautlVerticalPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Style.defautlHorizontalPadding / 4),
                  child: Icon(
                    Icons.date_range,
                    color: Style.textGreyColor,
                    size: Style.defautlVerticalPadding,
                  ),
                ),
                ShimmerLoading(
                  isLoading: data == null,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (data == null)
                            ? Container()
                            : FutureBuilder<SingleRecordModel>(
                                future: Provider.of<TableViewModel>(context, listen: false).fetchRecord(
                                  tableName: TableName.users.name,
                                  id: int.parse(data["own_id"]),
                                  isUserDb: true,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done &&
                                      snapshot.hasData &&
                                      snapshot.data != null) {
                                    var datas = snapshot.data!.data;
                                    debugPrint(datas?.length.toString());
                                    return Text(
                                      (datas?["name"] ?? "asdasd") + " " + (datas?["surname"] ?? "asdasd") ??
                                          ('*' * 15),
                                      style: TextStyle(color: Style.textGreyColor),
                                    );
                                  } else if (snapshot.hasError && snapshot.error != null) {
                                    HandleExceptions.handle(
                                      exception: snapshot.error,
                                      context: context,
                                    );
                                    return Container();
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                        const Text(
                          " . ",
                          style: TextStyle(),
                        ),
                        Text(
                          data?["added_date"].toString().toDateTime().toFormattedString() ?? ('' * 15),
                          style: const TextStyle(
                            color: Style.succesColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
