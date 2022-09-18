import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_network_image_widget.dart';

class GaleryPage extends StatelessWidget {
  const GaleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Galeri"),
      body: galeryBody(),
    );
  }

  Widget galeryBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: FutureBuilder(
          future: ApiClient().fetchTable(
            tableName: TableName.Galery.name,
            token: "",
            page: 1,
            limit: 20,
            filter: {},
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
              var datas = (snapshot.data as tableModel.TableModel).data;
              debugPrint(datas?.length.toString());
              return MasonryGridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: datas?.length ?? 0,
                crossAxisCount: 2,
                mainAxisSpacing: Style.defautlVerticalPadding,
                crossAxisSpacing: Style.defautlHorizontalPadding,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => detailPop(context, datas, index),
                    child: Tooltip(
                      message: datas?[index]["title"] ?? "null",
                      child: CustomNetworkImageWidget(imageUrl: Util.imageConvertUrl(imageName: datas![index]["image"])),
                    ),
                  );
                },
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

  Future detailPop(BuildContext context, List<Map<String, dynamic>>? datas, int index) {
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
          padding:
              EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding, horizontal: Style.defautlHorizontalPadding),
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
                  vertical: Style.defautlVerticalPadding,
                ),
                child: Text(
                  datas?[index]["title"] ?? "null",
                  style: TextStyle(
                    fontSize: Style.bigTitleTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomNetworkImageWidget(imageUrl: Util.imageConvertUrl(imageName: datas![index]["image"]))
            ],
          ),
        );
      },
    );
  }
}
