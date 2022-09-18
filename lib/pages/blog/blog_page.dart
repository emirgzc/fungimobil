import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Blog Sayfası"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: FutureBuilder(
            future:
                Provider.of<TableViewModel>(context, listen: false).fetchTable(
              tableName: TableName.Blog.name,
              page: 1,
              limit: 100,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                var datas = (snapshot.data as tableModel.TableModel).data;
                debugPrint(datas?.length.toString());
                return Column(
                  children: [
                    ...List.generate(
                      datas?.length ?? 0,
                      (index) {
                        return blogCard(context, datas, index);
                      },
                    ),
                  ],
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
        ),
      ),
    );
  }

  Widget blogCard(
      BuildContext context, List<Map<String, dynamic>>? datas, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.blogDetailPage,
                  arguments: datas![index]["id"]);
            },
            child: Stack(
              children: [
                SizedBox(
                  height: 700.h,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Style.defaultRadiusSize,
                    ),
                    child: Hero(
                      tag: datas![index]["image"],
                      child: Image.network(
                        Util.imageConvertUrl(imageName: datas[index]["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
              datas[index]["title"],
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            datas[index]["content"],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Style.textGreyColor),
          ),
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
                  datas[index]["added_date"]
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
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: Style.defaultPadding / 3),
            height: 1,
            width: double.infinity,
            color: Style.secondaryColor.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
