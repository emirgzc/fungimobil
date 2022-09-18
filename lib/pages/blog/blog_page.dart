import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/html_text_widget.dart';
import 'package:fungimobil/widgets/paginable_list_widget.dart';

import '../../widgets/custom_network_image_widget.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Blog Sayfası"),
      body: PaginableList(
        tableName: TableName.Blog.name,
        itemBuilder: (context, data) {
          return blogCard(context, data!);
        },
      ),
    );
  }

  Widget blogCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.blogDetailPage,
                  arguments: data["id"]);
            },
            child: Stack(
              children: [
                CustomNetworkImageWidget(
                  imageUrl: Util.imageConvertUrl(imageName: data["image"]),
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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: Text(
              data["title"],
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          HtmlTextWidget(
              content: data['content'],
              maxContentLength: 120,
              color: Style.textGreyColor),
          // Text(
          //   data["content"],
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(color: Style.textGreyColor),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Style.defautlHorizontalPadding / 4),
                  child: Icon(
                    Icons.date_range,
                    color: Style.textGreyColor,
                    size: Style.defautlVerticalPadding,
                  ),
                ),
                Text(
                  data["own_id"],
                  style: TextStyle(color: Style.textGreyColor),
                ),
                const Text(
                  " . ",
                  style: TextStyle(),
                ),
                Text(
                  data["added_date"]
                      .toString()
                      .toDateTime()
                      .toFormattedString(),
                  style: const TextStyle(
                    color: Style.succesColor,
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
