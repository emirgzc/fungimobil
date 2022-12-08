import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      HandleExceptions.handle(
                          exception: snapshot.error, context: context);
                    }
                    List<Map<String, dynamic>>? dataList = snapshot.data?.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: dataList?.length ?? 5,
                      scrollDirection: Axis.vertical,
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
      return await Provider.of<TableViewModel>(context, listen: false)
          .fetchTable(
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
    return GestureDetector(
      onTap: () => openDetail(context, data),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerLoading(
              isLoading: data == null,
              child: Container(
                height: 160,
                width: 160,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: CustomNetworkImageWidget(
                  imageUrl: data?['image'] == null
                      ? null
                      : Util.imageConvertUrl(imageName: data!['image']),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      isLoading: data == null,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Text(
                          data?["name"] ?? '*' * 20,
                          style: TextStyle(
                            fontSize: 42.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ShimmerLoading(
                        isLoading: data == null,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: HtmlTextWidget(
                            content: ((data?["description"].toString().length ??
                                        0) >
                                    200)
                                ? ("${data?["description"].toString().substring(0, 200) ?? ""}...")
                                : data?["description"],
                            isLoading: data == null,
                            loadingText: '*' * Random().nextInt(200),
                            fontSize: 32.sp,
                            color: Style.textGreyColor,
                          ),
                        ),
                      ),
                    ),
                    ((data?["description"].toString().length ?? 0) > 200)
                        ? GestureDetector(
                            onTap: () => openDetail(context, data),
                            child: const Text(
                              "Devamını Oku",
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        : Container()
                  ],
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
        ),
      ),
    );
  }

  openDetail(BuildContext context, Map<String, dynamic>? data) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(data?["name"] ?? ""),
          content: RawScrollbar(
            thumbColor: Style.secondaryColor,
            thumbVisibility: true,
            thickness: 3,
            child: SizedBox(
              height: (((data?["description"].toString().length ?? 0) > 1000)
                  ? 400
                  : 250),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HtmlTextWidget(
                      content: data?["description"],
                      isLoading: data == null,
                      loadingText: '*' * Random().nextInt(200),
                      fontSize: 40.sp,
                      color: Style.textGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
