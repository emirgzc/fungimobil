import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as table;
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/table_view_model.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.primaryColor,
      appBar: getAppBar("Etkinlikler"),
      body: FutureBuilder<table.TableModel>(
          future: Provider.of<TableViewModel>(context, listen: false)
              .fetchTable(
                  tableName: TableName.Activity.name, page: 1, limit: 100),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              // snapshot.data!.data
              List<Map<String, dynamic>> dataList = snapshot.data!
                  .data!; //(snapshot.data as List).map((e) => e as Map<String, dynamic>).toList();
              return ListView.builder(
                  padding: const EdgeInsets.all(Style.defaultPadding),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return activityCard(dataList[index], context);
                  });
            } else if (snapshot.hasError && snapshot.error != null) {
              HandleExceptions.handle(
                  exception: snapshot.error, context: context);
            }

            return const LoadingWidget();
          }),
    );
  }

  Widget activityCard(Map<String, dynamic> data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.activityDetailPage,
            arguments: data);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageForActivity(
                context, Util.imageConvertUrl(imageName: data['image']), data),
            title(data['title']),
            desc(data['content']),
            detailDateandDirector(
                data['director'],
                data['last_record_date']
                    .toString()
                    .toDateTime()
                    .toFormattedString()),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Style.defaultPadding / 3),
              height: 1,
              width: double.infinity,
              color: Style.secondaryColor.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget desc(String content) {
    return Text(
      content,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Style.textGreyColor,
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Style.bigTitleTextSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget imageForActivity(
      BuildContext context, String imageUrl, Map<String, dynamic> data) {
    return Stack(
      children: [
        SizedBox(
          height: 550.h,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        buttonForContinue(context, data),
      ],
    );
  }

  Widget buttonForContinue(BuildContext context, Map<String, dynamic> data) {
    return Positioned(
      bottom: Style.defautlVerticalPadding / 2,
      right: Style.defautlHorizontalPadding / 2,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, Routes.activityDetailPage,
              arguments: data);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Style.defautlVerticalPadding / 4,
            horizontal: Style.defautlHorizontalPadding / 2,
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
              color: Style.textColor,
              fontSize: Style.defaultTextSize,
            ),
          ),
        ),
      ),
    );
  }

  Widget detailDateandDirector(String creatorName, String lastRecordDate) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.people_alt_outlined,
                size: Style.defautlVerticalPadding,
                color: Style.textGreyColor,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: Style.defautlHorizontalPadding / 4),
                child: Text(
                  creatorName,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Style.textGreyColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Son Kayıt : $lastRecordDate",
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Style.dangerColor,
            ),
          ),
        ],
      ),
    );
  }
}
