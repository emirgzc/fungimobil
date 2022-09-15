import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';
import '../../model/table_model.dart' as table;
import '../../viewmodel/table_view_model.dart';
import '../custom_text_field.dart';
import '../shimmer/shimmer.dart';
import 'comment_item_widget.dart';

class AllCommentWidget extends StatelessWidget {
  AllCommentWidget({Key? key, required this.tableName, required this.filter, required this.backgroundColor}) : super(key: key);

  String tableName;
  table.TableModel? recordTable;
  List<Map<String, dynamic>>? allCommentList;
  Map<String, dynamic> filter;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<table.TableModel>(
        future:
            Provider.of<TableViewModel>(context, listen: false).fetchTable(tableName: tableName, page: 1, limit: 10, filter: filter),
        builder: (context, snapshot) {
          recordTable = snapshot.data;
          allCommentList = snapshot.data?.data;
          if (snapshot.hasError && snapshot.error != null) {
            HandleExceptions.handle(exception: snapshot.error, context: context);
          }

          return Shimmer(
            linearGradient: Style.shimmerGradient,
            child: DraggableScrollableSheet(
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
                              left: Style.defautlHorizontalPadding, top: Style.defautlVerticalPadding * 2),
                          child: Row(
                            children: [
                              ShimmerLoading(
                                isLoading: recordTable == null,
                                child: Text(
                                  "${recordTable?.count ?? '**'} Yorum",
                                  style: TextStyle(
                                    fontSize: Style.bigTitleTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: allCommentList?.length ?? 10,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CommentItemWidget(
                              data: allCommentList?[index],
                              backgroundColor: backgroundColor,
                            ); //_buildListItem(allCommentList?[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

// ListTile _buildListItem(Map<String, dynamic>? data) {
//   return ListTile(
//     minLeadingWidth: 0,
//     dense: true,
//     leading: const Icon(Icons.supervised_user_circle_outlined),
//     title: Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(right: Style.defautlHorizontalPadding / 2),
//           child: Text(
//             data?['name'] ?? 'Kullanıcı ad soyad',
//             style: TextStyle(
//               fontSize: Style.bigTitleTextSize,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Text(
//           data?['added_date'].toString().toDateTime().toFormattedString() ?? 'Yorum eklenme tarihi',
//           style: TextStyle(
//             fontSize: 40.sp,
//           ),
//         ),
//       ],
//     ),
//     subtitle: const Text(
//       "Lorem Ipsum has been the industry's stand",
//     ),
//     trailing: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.favorite_border,
//           size: 64.r,
//         ),
//         const Text("15"),
//       ],
//     ),
//   );
// }
}
