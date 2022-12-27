import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_network_image_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/html_text_widget.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Organizasyon"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: FutureBuilder(
            future:
                Provider.of<TableViewModel>(context, listen: false).fetchTable(
              tableName: TableName.Services.name,
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
                        return serviceCard(context, datas, index);
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

  Widget serviceCard(
      BuildContext context, List<Map<String, dynamic>>? datas, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap:
                datas == null ? null : () => detailPop(context, datas, index),
            child: Stack(
              children: [
                CustomNetworkImageWidget(
                    imageUrl: Util.imageConvertUrl(
                        imageName: datas![index]["image"])),
                Positioned(
                  bottom: Style.defautlVerticalPadding / 2,
                  right: Style.defautlHorizontalPadding / 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding / 4,
                      horizontal: Style.defautlHorizontalPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: Style.secondaryColor.withOpacity(0.9),
                      borderRadius:
                          BorderRadius.circular(Style.defaultRadiusSize),
                    ),
                    child: Text(
                      "Devamını Oku...",
                      style: TextStyle(
                        color: Style.textColor,
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Style.defautlVerticalPadding / 2),
            child: HtmlTextWidget(
                content: datas[index]["content"],
                maxContentLength: 120,
                color: Style.textGreyColor,
                fontSize: Style.defaultTextSize * 0.8),

            /*Text(
              datas[index]["content"],
              maxLines: 4,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Style.textGreyColor,
              ),
            ),*/
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

  Future detailPop(
      BuildContext context, List<Map<String, dynamic>> datas, int index) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Style.defaultRadiusSize),
          topRight: Radius.circular(Style.defaultRadiusSize),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: Style.defautlVerticalPadding,
            horizontal: Style.defautlHorizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 8.h,
                    width: 300.w,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Style.defautlVerticalPadding),
                child: Text(
                  datas[index]["title"] ?? "",
                  style: TextStyle(
                    fontSize: Style.bigTitleTextSize,
                    fontWeight: FontWeight.bold,
                    color: Style.secondaryColor,
                  ),
                ),
              ),
              HtmlTextWidget(
                content: datas[index]["content"],
                color: Style.textGreyColor,
                fontSize: Style.defaultTextSize * 0.8,
              ),
              SizedBox(
                height: 120.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
