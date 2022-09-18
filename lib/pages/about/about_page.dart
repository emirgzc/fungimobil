import 'package:flutter/material.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_network_image_widget.dart';
import 'package:fungimobil/widgets/html_text_widget.dart';
import 'package:fungimobil/widgets/shimmer/shimmer.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Hakkımızda"),
      body: Shimmer(
        linearGradient: Style.shimmerGradient,
        child: FutureBuilder(
          future:
              Provider.of<TableViewModel>(context, listen: false).fetchTable(
            tableName: TableName.About.name,
            page: 1,
            limit: 100,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
              var datas = (snapshot.data as tableModel.TableModel).data;
              debugPrint(datas?.length.toString());
              return aboutBody(context, datas);
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

  Widget aboutBody(BuildContext context, List<Map<String, dynamic>>? dataMap) {
    debugPrint(dataMap.toString());
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: dataMap?.length ?? 0,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return aboutCard(dataMap, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget aboutCard(List<Map<String, dynamic>>? dataMap, int index) {
    // debugPrint(dataMap![index]["image"].toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLoading(
          isLoading: dataMap == null,
          child: CustomNetworkImageWidget(imageUrl: Util.imageConvertUrl(imageName: dataMap?[index]["image"])),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
          child: ShimmerLoading(
            isLoading: dataMap == null,
            child: bigTitle(dataMap?[index]["title"].toString() ?? ""),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ShimmerLoading(
            isLoading: dataMap == null,
            child: desc(dataMap?[index]["content"].toString() ?? ""),
          ),
        ),
      ],
    );
  }

  Widget desc(String desc) {
    return HtmlTextWidget(
      content: desc,
      color: Style.textGreyColor,
    );

    // return Text(
    //   desc,
    //   style: TextStyle(
    //     fontSize: Style.defaultTextSize,
    //     color: Style.textGreyColor,
    //   ),
    // );
  }

  Widget bigTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
        color: Style.secondaryColor,
      ),
    );
  }
}
