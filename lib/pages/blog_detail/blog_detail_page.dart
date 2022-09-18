import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/model/single_record_model.dart' as tableModel;
import 'package:fungimobil/model/table_model.dart' as tableModelss;
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/card_for_social_media.dart';
import 'package:fungimobil/widgets/comment/comment_list_widget.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  List<Map<String, dynamic>>? commentlist;
  late Map<String, dynamic> commentFilter;

  @override
  void initState() {
    super.initState();
    commentFilter = {'blog_id': widget.id};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: ApiClient().fetchRecord(
              tableName: TableName.Blog.name,
              id: int.parse(widget.id),
              token: ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              var datas = (snapshot.data as tableModel.SingleRecordModel).data;
              debugPrint("asdasasdadasds ----${datas!.length}");
              return Column(
                children: [
                  blogBody(context, datas),
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

  Widget blogBody(BuildContext context, Map<String, dynamic>? data) {
    return Stack(
      children: [
        SizedBox(
          height: 900.h,
          width: double.infinity,
          child: Hero(
            tag: data!["image"],
            child: Image.network(
              Util.imageConvertUrl(imageName: data["image"]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        arrowBack(context),

        headerDateandUser(context, data),
        // buttonForRecord(),
        Container(
          padding: Style.defaultPagePadding,
          margin: EdgeInsets.only(top: 900.h),
          color: Style.primaryColor,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bigTitle(data["title"] ?? ""),
              Padding(
                padding: EdgeInsets.only(top: Style.defautlVerticalPadding),
                child: Row(
                  children: const [
                    CardForSocialMedia(
                      iconSvg: "assets/icons/twitter.svg",
                    ),
                    CardForSocialMedia(
                      iconSvg: "assets/icons/instagram.svg",
                    ),
                    CardForSocialMedia(
                      iconSvg: "assets/icons/facebook.svg",
                    ),
                    CardForSocialMedia(
                      iconSvg: "assets/icons/whatsapp.svg",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Style.defautlVerticalPadding),
                child: desc(data["content"] ?? ""),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Style.defautlVerticalPadding,
                ),
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
    );
  }

  Widget commentTitle(BuildContext context) {
    return FutureBuilder(
        future: _fetchComment(),
        builder: (context, snapshot) {
          if (snapshot.hasError && snapshot.error != null) {
            HandleExceptions.handle(
                exception: snapshot.error, context: context);
          }
          return CommentListWidget(
            tableName: TableName.BlogComment.name,
            defaultItems: commentlist,
            filter: commentFilter,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          );
        });
  }

  Future _fetchComment() async {
    try {
      var commentTable =
          await Provider.of<TableViewModel>(context, listen: false).fetchTable(
        tableName: TableName.BlogComment.name,
        page: 1,
        limit: 5,
        filter: commentFilter,
      );
      commentlist = commentTable.data!;
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
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

  Widget desc(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: Style.defaultTextSize,
        color: Style.textGreyColor,
      ),
    );
  }

  Widget bigTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget commentForActivity() {
    return Row(
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
          width: 800.w,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Yorum Yap",
              hintStyle: TextStyle(
                color: Style.textColor.withOpacity(0.3),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: Style.defautlHorizontalPadding,
              ),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Style.textColor.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(24.r),
            decoration: const BoxDecoration(
              color: Style.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ],
    );
  }

  Widget headerDateandUser(BuildContext context, Map<String, dynamic>? data) {
    debugPrint(widget.id.toString());
    return Positioned(
      top: 130.h,
      right: 48.w,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 2,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              data!["added_date"].toString().toDateTime().toFormattedString(),
              style: TextStyle(
                color: const Color(0xffF4A261),
                fontSize: 40.sp,
              ),
            ),
            FutureBuilder<tableModel.SingleRecordModel>(
              future: Provider.of<TableViewModel>(context, listen: false)
                  .fetchRecord(
                tableName: TableName.users.name,
                id: int.parse(data["own_id"]),
                isUserDb: true,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  var datas = snapshot.data!.data;
                  debugPrint(datas?.length.toString());
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      (datas?["name"] ?? "asdasd") +
                          " " +
                          (datas?["surname"] ?? "asdasd"),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.sp,
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }

  Widget arrowBack(BuildContext context) {
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

  Future commentMenu(BuildContext context) {
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
                    horizontal: Style.defautlHorizontalPadding / 2),
                child: FutureBuilder(
                  future: ApiClient().fetchTable(
                    tableName: TableName.BlogComment.name,
                    token: "",
                    page: 1,
                    limit: 10,
                    filter: {
                      "blog_id": widget.id,
                      "status": 1,
                    },
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data != null) {
                      var datas =
                          (snapshot.data as tableModelss.TableModel).data;
                      debugPrint(datas?.length.toString());
                      return Column(
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
                                        style: TextStyle(
                                            color: Style.primaryColor),
                                      ),
                                    ),
                                  ],
                                  title: const Text("Etkinlik Yorum"),
                                  contentPadding: EdgeInsets.all(60.r),
                                  content: CustomTextField(
                                    hintText: "Blog Yorumunuzu Giriniz",
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
                                  "${datas?.length.toString()} Yorum",
                                  style: TextStyle(
                                    fontSize: Style.bigTitleTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            itemCount: datas?.length ?? 0,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                minLeadingWidth: 0,
                                dense: true,
                                leading: const Icon(
                                    Icons.supervised_user_circle_outlined),
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right:
                                              Style.defautlHorizontalPadding /
                                                  2),
                                      child: Text(
                                        (datas?[index]["name"] ?? "") +
                                            " " +
                                            (datas?[index]["surname"] ?? ""),
                                        style: TextStyle(
                                          fontSize: Style.defaultTextSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      datas?[index]["added_date"].toString() ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 40.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  datas?[index]["comment"],
                                ),
                              );
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
          },
        );
      },
    );
  }
}
