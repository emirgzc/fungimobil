import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as table;
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/table_util.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Takımımız"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              FutureBuilder<table.TableModel>(
                future: Provider.of<TableViewModel>(context, listen: false)
                    .fetchTable(
                  tableName: TableName.Team.name,
                  page: 1,
                  limit: 100,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // snapshot.data!.data
                    List<Map<String, dynamic>> dataList = snapshot.data!
                        .data!; //(snapshot.data as List).map((e) => e as Map<String, dynamic>).toList();
                    return MasonryGridView.count(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: dataList.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: Style.defautlVerticalPadding,
                      crossAxisSpacing: Style.defautlHorizontalPadding,
                      itemBuilder: (context, index) {
                        return teamCard(index, dataList);
                      },
                    );
                  } else if (snapshot.hasError && snapshot.error != null) {
                    HandleExceptions.handle(
                        exception: snapshot.error, context: context);
                  }

                  return const LoadingWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget teamCard(int index, List<Map<String, dynamic>> dataList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          child: SizedBox(
            height: 500.h,
            child: Image.network(
              Util.imageConvertUrl(imageName: dataList[index]['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
          child: Text(
            dataList[index]["name"],
            style: TextStyle(
              fontSize: 56.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          dataList[index]["description"],
          style: TextStyle(
            fontSize: 40.sp,
            color: Style.textGreyColor,
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
