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
import 'package:fungimobil/widgets/shimmer/shimmer.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';

import '../../widgets/custom_network_image_widget.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: Style.shimmerGradient,
      child: Scaffold(
        appBar: getAppBar("Etkinlikler"),
        body: PaginableList(
            tableName: TableName.Activity.name,
            useShimmerEffectFormat: true,
            itemBuilder: (context, data) {
              return activityCard(data, context);
            }),
      ),
    );
  }

  Widget activityCard(Map<String, dynamic>? data, BuildContext context) {
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
                context,
                data == null
                    ? null
                    : Util.imageConvertUrl(imageName: data['image']),
                data),
            title(data?['title'], context),
            desc(data?['content'], context),
            detailDateandDirector(
                data?['director'],
                data?['last_record_date']
                    .toString()
                    .toDateTime()
                    .toFormattedString(),
                context),
          ],
        ),
      ),
    );
  }

  Widget desc(String? content, BuildContext context) {
    return ShimmerLoading(
      isLoading: content == null,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: HtmlTextWidget(
          content: content,
          isLoading: content == null,
          loadingText: '*' * 170,
          maxContentLength: 120,
          color: Style.textGreyColor,
          fontSize: Style.defaultTextSize * 0.9,
        ),
      ),
    );
    // return Text(
    //   content,
    //   maxLines: 3,
    //   overflow: TextOverflow.ellipsis,
    //   style: TextStyle(
    //     color: Style.textGreyColor,
    //   ),
    // );
  }

  Widget title(String? title, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
      child: ShimmerLoading(
        isLoading: title == null,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Text(
            title ?? '*' * 20,
            style: TextStyle(
              fontSize: (title?.length ?? 0) > 30 ? 54.sp : 80.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget imageForActivity(
      BuildContext context, String? imageUrl, Map<String, dynamic>? data) {
    return ShimmerLoading(
      isLoading: data == null,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            SizedBox(
              height: 550.h,
              width: double.infinity,
              child: CustomNetworkImageWidget(
                  imageUrl: imageUrl ??
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png'),
            ),
            buttonForContinue(context, data),
          ],
        ),
      ),
    );
  }

  Widget buttonForContinue(BuildContext context, Map<String, dynamic>? data) {
    return Positioned(
      bottom: Style.defautlVerticalPadding / 2,
      right: Style.defautlHorizontalPadding / 2,
      child: GestureDetector(
        onTap: data == null
            ? null
            : () {
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

  Widget detailDateandDirector(
      String? creatorName, String? lastRecordDate, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.people_alt_outlined,
            size: Style.defautlVerticalPadding * 0.75,
            color: Style.textGreyColor,
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: Style.defautlHorizontalPadding / 4),
              child: ShimmerLoading(
                isLoading: creatorName == null,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    creatorName ?? '*' * 20,
                    style: TextStyle(
                      color: Style.textGreyColor,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ShimmerLoading(
            isLoading: lastRecordDate == null,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                "Son Kayıt : ${lastRecordDate ?? '*' * 15}",
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Style.dangerColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
