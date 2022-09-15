import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/viewmodel/comment_viewmodel.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:provider/provider.dart';

import '../../constants/style.dart';
import '../../model/table_model.dart' as table;
import '../../viewmodel/table_view_model.dart';
import '../custom_text_field.dart';
import '../shimmer/shimmer.dart';
import 'comment_item_widget.dart';

class AllCommentWidget extends StatefulWidget {
  AllCommentWidget({Key? key, required this.tableName, required Map<String, dynamic> filter, required this.backgroundColor})
      : super(key: key) {
    filter = Map.of(filter);
    filter.remove('status');
    this.filter = filter;
  }

  String tableName;
  late Map<String, dynamic> filter;
  final Color backgroundColor;

  @override
  State<AllCommentWidget> createState() => _AllCommentWidgetState();
}

class _AllCommentWidgetState extends State<AllCommentWidget> {
  table.TableModel? recordTable;

  List<Map<String, dynamic>>? allCommentList;

  String? newComment;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<table.TableModel>(
        future: Provider.of<TableViewModel>(context, listen: false)
            .fetchTable(tableName: widget.tableName, page: 1, limit: 10, filter: widget.filter),
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
                        _buildAddCommentBtn(context),
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
                              backgroundColor: widget.backgroundColor,
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

  Widget _buildAddCommentBtn(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<AuthViewModel>(context, listen: false).isUserExists(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true){
          return ChangeNotifierProvider(
            create: (_) => CommentViewModel(),
            child: Builder(builder: (context) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context1) => _buildAddCommentDialog(context),
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
              );
            }),
          );
        }
        return const SizedBox();
      }
    );
  }

  AlertDialog _buildAddCommentDialog(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'İptal',
              style: Theme.of(context).textTheme.button!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
            )),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Style.secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            _saveComment(context).then((value) {
              _showCommentStoreSuccessfully(context).then((value) => setState((){}));
            });
          },
          child: Text(
            "Ekle",
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: Style.primaryColor,
                ),
          ),
        ),
      ],
      title: const Text("Etkinlik Yorum"),
      contentPadding: EdgeInsets.all(60.r),
      content: CustomTextField(
        hintText: "Etkinlik Yorumunuzu Giriniz",
        onChanged: (v) {
          if (v != null) newComment = v;
        },
      ),
    );
  }

  Future<dynamic> _showCommentStoreSuccessfully(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.bottomCenter,
            contentPadding: const EdgeInsets.all(Style.defaultPadding),
            title: SizedBox(
              width: double.infinity,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Yorumunuz kaydedildi!',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Style.secondaryColor),
                  )),
            ),
            backgroundColor: Colors.white,

            // child: Container(
            //   height: 100,
            //   padding: const EdgeInsets.all(Style.defaultPadding),
            //   alignment: Alignment.center,
            //   // margin: const EdgeInsets.all(Style.defaultPadding),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
            //     // boxShadow: [BoxShadow()],
            //   ),
            //   child: ,
            // ),
          );
        });
  }

  Future _saveComment(BuildContext context) async {
    try {
      await Provider.of<CommentViewModel>(context, listen: false)
          .storeComment(tableName: widget.tableName, filter: widget.filter, comment: newComment!);
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }
}
