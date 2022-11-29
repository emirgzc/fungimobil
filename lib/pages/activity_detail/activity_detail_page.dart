import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/single_record_model.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/custom_network_image_widget.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';
import 'package:fungimobil/widgets/html_text_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/comment/comment_list_widget.dart';
import '../../widgets/shimmer/shimmer.dart';
import '../../widgets/shimmer/shimmer_loading.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage>
    with TickerProviderStateMixin {
  AnimationController? controller;
  SingleRecordModel? recordModel;
  List<Map<String, dynamic>>? commentlist;
  late Map<String, dynamic> commentFilter;

  @override
  void initState() {
    super.initState();
    commentFilter = {'activity_id': widget.data['id']};
  }

  List<String> activityData = [
    "Bitiş Tarihi",
    "Yapımcı",
    "Kontenjan",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
          linearGradient: Style.shimmerDarkGradient,
          child: activityDetailBody(context)),
    );
  }

  Widget activityDetailBody(BuildContext context) {
    double sizeWidht = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 900.h,
                width: double.infinity,
                child: Hero(
                  tag: widget.data['image'],
                  child: CustomNetworkImageWidget(
                      imageUrl: Util.imageConvertUrl(
                          imageName: widget.data['image'])),
                ),
              ),
              arrowBack(),

              // buttonForRecord(),
              Container(
                padding: Style.defaultPagePadding,
                margin: EdgeInsets.only(top: 900.h),
                color: Style.primaryColor,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleAndDate(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Style.defaultPadding * (3 / 2),
                      ),
                      child: socialCardandPrice(),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Style.defautlVerticalPadding / 2),
                      child: titleForActivity("Etkinlik Bilgisi"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Style.defautlVerticalPadding / 2),
                      child: FutureBuilder(
                          future: recordModel == null ? _fetchRecord() : null,
                          builder: (context, snapshot) {
                            return desc(recordModel?.data?['content']);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        children: [
                          activityDataItem(
                            activityData[0],
                            widget.data['start_date']
                                .toString()
                                .toDateTime()
                                .toFormattedString(),
                          ),
                          activityDataItem(activityData[1],
                              widget.data['director'].toString()),
                          activityDataItem(
                            activityData[2],
                            "${widget.data['quota']} Kişilik",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Style.defautlVerticalPadding),
                      child: commentTitle(context),
                    ),
                    // commentForActivity(),
                    SizedBox(
                      height: 300.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: () => recordPop(context),
            child: Container(
              height: 64,
              width: sizeWidht,
              decoration: BoxDecoration(
                color: Style.primaryColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 6,
                    offset: const Offset(5, 5),
                    color: Colors.black.withOpacity(0.2),
                  )
                ],
                borderRadius: BorderRadius.circular(
                  Style.defaultRadiusSize,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 64,
                    width: sizeWidht * 0.55,
                    decoration: BoxDecoration(
                      color: Style.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 6,
                          offset: const Offset(5, 5),
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Kayıt Ol",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 64,
                    width: sizeWidht * 0.45,
                    decoration: BoxDecoration(
                      color: Style.primaryColor.withOpacity(0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Son kayıt Tarihi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Style.dangerColor,
                          ),
                        ),
                        Text(
                          widget.data['last_record_date']
                              .toString()
                              .toDateTime()
                              .toFormattedString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Style.dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget activityDataItem(String title, String item) {
    return Container(
      margin: const EdgeInsets.only(right: 8, top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Style.primaryColor,
        borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
        boxShadow: [
          Style.defaultShadow,
        ],
        border: Border.all(
          width: 1,
          color: Style.secondaryColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            item,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // TODO: Yorumlar yapılacak
  Widget commentTitle(BuildContext context) {
    return FutureBuilder(
        future: _fetchComment(),
        builder: (context, snapshot) {
          if (snapshot.hasError && snapshot.error != null) {
            HandleExceptions.handle(
                exception: snapshot.error, context: context);
          }
          return CommentListWidget(
            tableName: TableName.ActivityComment.name,
            defaultItems: commentlist,
            filter: commentFilter,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          );
        });
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     titleForActivity("Yorumlar :"),
    //     Padding(
    //       padding: EdgeInsets.only(left: Style.defautlHorizontalPadding / 2),
    //       child: Text(
    //         "Toplam 12 Yorum",
    //         style: TextStyle(
    //           fontSize: 56.sp,
    //           fontWeight: FontWeight.w400,
    //         ),
    //       ),
    //     ),
    //     const Spacer(),
    //     GestureDetector(
    //       onTap: () async {
    //         menuPop(context);
    //       },
    //       child: Text(
    //         "Tüm Yorumlar",
    //         style: TextStyle(
    //           decoration: TextDecoration.underline,
    //           fontSize: Style.defaultTextSize * (3 / 4),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget map() {
    return Image.asset("assets/images/osmanli.jpg");
  }

  Widget infoActivity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 136.h,
          margin: EdgeInsets.only(
            // right: Style.defautlHorizontalPadding / 2,
            bottom: Style.defautlVerticalPadding / 2,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Style.defautlHorizontalPadding / 2,
            vertical: Style.defautlVerticalPadding / 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Style.secondaryColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bitiş Tarihi : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Style.defaultTextSize,
                ),
              ),
              Expanded(
                child: Text(widget.data['finish_date']
                    .toString()
                    .toDateTime()
                    .toFormattedString()),
              ),
            ],
          ),
        ),
        Container(
          height: 136.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Style.defautlHorizontalPadding / 2,
            vertical: Style.defautlVerticalPadding / 4,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Style.secondaryColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Yapımcı : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Style.defaultTextSize,
                ),
              ),
              Expanded(
                child: Text(widget.data['director']),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget titleForActivity(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget desc(String? content) {
    String text;
    if (content != null) {
      text = content;
    } else {
      String minimalContent = widget.data['content'].toString();
      text = minimalContent.endsWith('...')
          ? minimalContent.substring(0, minimalContent.length - 3)
          : minimalContent;
    }

    return Column(
      children: [
        /*ShimmerLoading(
          isLoading: content == null,
          child: Text.rich(TextSpan(
              style: TextStyle(
                fontSize: Style.defaultTextSize,
                color: Style.textColor.withOpacity(0.6),
              ),
              children: [
                TextSpan(text: text),
              ]
          )),
        ),*/
        HtmlTextWidget(content: text, color: Style.textColor.withOpacity(0.6)),
        // Text(
        //   text,
        //   style: TextStyle(
        //     fontSize: Style.defaultTextSize,
        //     color: Style.textColor.withOpacity(0.6),
        //   ),
        // ),
        /*if (content == null) SizedBox(width: 0.4.sw, child: const LinearProgressIndicator(color: Style.secondaryColor, backgroundColor: Colors.transparent,)),*/
        // if (content == null) const CircularProgressIndicator(color: Style.secondaryColor,),
        if (content == null)
          ShimmerLoading(
            isLoading: content == null,
            child: Text(
              '...',
              style: TextStyle(
                fontSize: Style.defaultTextSize * 3,
                color: Style.textColor.withOpacity(0.6),
              ),
            ),
          ),
      ],
    );
  }

  // Widget bigTitle() {
  //   return Text(
  //     "One of best destinations in Turkey",
  //     style: TextStyle(
  //       fontSize: Style.bigTitleTextSize,
  //       fontWeight: FontWeight.w500,
  //     ),
  //   );
  // }

  Widget socialCardandPrice() {
    String formattedPrice = widget.data['price'].toString().toNumberFormat();
    String priceIntegerSection = formattedPrice.split(',')[0];
    String priceDecimalSection = formattedPrice.split(',')[1];
    String location = widget.data['location'];
    double size = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Style.secondaryColor,
                  size: 56.r,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: Style.defautlHorizontalPadding / 3),
                  child: Text(
                    changeForStringFormat(location, size, 15),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: location.length > 20 ? 40.sp : 48.sp,
                      color: Style.textColor.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_sharp,
                    color: Style.secondaryColor,
                    size: 56.r,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Style.defautlHorizontalPadding / 3),
                    child: Text(
                      widget.data['start_date']
                          .toString()
                          .toDateTime()
                          .toFormattedStringWithTime(),
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Style.textColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ), /* 
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    color: Style.secondaryColor,
                    size: 56.r,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Style.defautlHorizontalPadding / 3),
                    child: Text(
                      "Kontenjan : ${widget.data['quota']} ",
                      style: TextStyle(
                        fontSize: 40.sp,
                        color: Style.textColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ), */
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  priceIntegerSection,
                  style: TextStyle(
                    fontSize: priceIntegerSection.length > 3 ? 64.sp : 72.sp,
                    fontWeight: FontWeight.w500,
                    color: Style.secondaryColor,
                  ),
                ),
                Text(
                  ",$priceDecimalSection ₺",
                  style: TextStyle(
                    fontSize: 56.sp,
                    fontWeight: FontWeight.w500,
                    color: Style.secondaryColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                "/1 Kişi için",
                style: TextStyle(
                  fontSize: Style.defaultTextSize * 0.7,
                  color: Style.textColor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String changeForStringFormat(String title, double size, int limit) {
    if (title.length > (size ~/ limit)) {
      return "${title.substring(0, (size ~/ limit))}...";
    } else {
      return title;
    }
  }

  Widget titleAndDate() {
    // String titleAct = "Fungi Turkey Mantar Avcılığı Kampı Bolu";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            widget.data['title'],
            style: TextStyle(
              fontSize: widget.data['title'].length > 30 ? 48.sp : 80.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Widget commentForActivity() {
  //   return Row(
  //     children: [
  //       Container(
  //           margin: EdgeInsets.symmetric(
  //             vertical: Style.defautlVerticalPadding / 2,
  //           ),
  //           width: 800.w,
  //           child: CustomTextField(hintText: "Yorum Yap"),),
  //       Expanded(
  //         child: Container(
  //           padding: EdgeInsets.all(24.r),
  //           decoration: const BoxDecoration(
  //             color: Style.secondaryColor,
  //             shape: BoxShape.circle,
  //           ),
  //           child: const Icon(Icons.keyboard_arrow_right),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget arrowBack() {
    return Positioned(
      top: 130.h,
      left: 48.w,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: EdgeInsets.all(30.r),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }

  Future menuPop(BuildContext context) {
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
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Style.defautlVerticalPadding / 2,
                  horizontal: Style.defautlHorizontalPadding / 2,
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Style.secondaryColor,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "İptal",
                                  style: TextStyle(color: Style.primaryColor),
                                ),
                              ),
                            ],
                            title: const Text("Etkinlik Yorum"),
                            contentPadding: EdgeInsets.all(60.r),
                            content: CustomTextField(
                              hintText: "Etkinlik Yorumunuzu Giriniz",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: Style.defautlVerticalPadding / 2,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: Style.defautlVerticalPadding / 2,
                          horizontal: Style.defautlHorizontalPadding,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [Style.defaultShadow],
                          borderRadius: BorderRadius.circular(
                            Style.defaultRadiusSize,
                          ),
                          color: Style.secondaryColor,
                        ),
                        child: const Text("Yorum Yap"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Style.defautlHorizontalPadding,
                          top: Style.defautlVerticalPadding * 2),
                      child: Row(
                        children: [
                          Text(
                            "12 Yorum",
                            style: TextStyle(
                              fontSize: Style.bigTitleTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: 12,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minLeadingWidth: 0,
                          dense: true,
                          leading:
                              const Icon(Icons.supervised_user_circle_outlined),
                          title: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: Style.defautlHorizontalPadding / 2),
                                child: Text(
                                  "Emir Gözcü",
                                  style: TextStyle(
                                    fontSize: Style.bigTitleTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "2 saat önce",
                                style: TextStyle(
                                  fontSize: 40.sp,
                                ),
                              ),
                            ],
                          ),
                          subtitle: const Text(
                            "Lorem Ipsum has been the industry's stand",
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 56.r,
                              ),
                              const Text("15"),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //  TODO: Kayıt yapılacak
  Future recordPop(BuildContext context) {
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
              horizontal: Style.defautlHorizontalPadding),
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
                  "Etkinlik Kayıt",
                  style:
                      TextStyle(fontSize: 62.sp, fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(hintText: "Kişi Sayısı"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 0,
                    groupValue: 1,
                    onChanged: (value) {},
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Anladım"),
                            ),
                          ],
                          title: const Text("Açık Rıza Metni"),
                          contentPadding: EdgeInsets.all(60.r),
                          content: Text(
                            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s," *
                                5,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Açık Rıza Metnini ",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const Text("Okudum ve Kabul Ediyorum."),
                ],
              ),
              const ButtonForLogin(title: "Kayıt Ol"),
            ],
          ),
        );
      },
    );
  }

  Future _fetchRecord() async {
    try {
      int id = int.parse(widget.data['id'].toString());
      recordModel = await Provider.of<TableViewModel>(context, listen: false)
          .fetchRecord(tableName: TableName.Activity.name, id: id);
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }

  Future _fetchComment() async {
    try {
      var commentTable =
          await Provider.of<TableViewModel>(context, listen: false).fetchTable(
        tableName: TableName.ActivityComment.name,
        page: 1,
        limit: 5,
        filter: commentFilter,
      );
      commentlist = commentTable.data!;
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }
}
