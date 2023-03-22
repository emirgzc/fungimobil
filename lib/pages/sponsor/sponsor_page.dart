import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/table_view_model.dart';
import '../../widgets/custom_network_image_widget.dart';

class SponsorPage extends StatelessWidget {
  const SponsorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Sponsorlarımız"),
      body: sponsorBody(context),
    );
  }

  Widget sponsorBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: FutureBuilder(
          future: context.read<TableViewModel>().fetchTable(
            tableName: TableName.Sponsor.name,
            page: 1,
            limit: 10,
            filter: {
              'status': 1
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
              var datas = (snapshot.data as tableModel.TableModel).data;
              debugPrint(datas?.length.toString());
              return Column(
                children: [
                  ...List.generate(
                    datas?.length ?? 0,
                    (index) {
                      return sponsorCard(datas, index);
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
    );
  }

  Widget sponsorCard(List<Map<String, dynamic>>? datas, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      child: Column(
        children: [
          SizedBox(
            height: 550.h,
            width: double.infinity,
            child: CustomNetworkImageWidget(imageUrl: Util.imageConvertUrl(imageName: datas![index]["image"])),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Style.defautlVerticalPadding / 2,
            ),
            child: Text(
              datas[index]["title"],
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            datas[index]["web_site"],
            style: TextStyle(
              color: Colors.blue.withOpacity(0.7),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Style.defaultPadding),
            height: 1,
            width: double.infinity,
            color: Style.secondaryColor.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
