import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/constants/validator.dart';
import 'package:fungimobil/helper/ui_helper.dart';
import 'package:fungimobil/widgets/custom_network_image_widget.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:provider/provider.dart';

import '../constants/style.dart';
import '../pages/login_register/components/button_login.dart';
import '../viewmodel/table_view_model.dart';
import 'custom_text_field.dart';

class CommentPageListItemWidget extends StatefulWidget {
  CommentPageListItemWidget({Key? key, required this.data, required this.isBlog}) : super(key: key);

  Map<String, dynamic>? data;
  bool isBlog;

  @override
  State<CommentPageListItemWidget> createState() => _CommentPageListItemWidgetState();
}

class _CommentPageListItemWidgetState extends State<CommentPageListItemWidget> {
  Map<String, dynamic>? topData;
  String? imageUrl;
  String? title;

  String updateText = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.data != null) {
        _fetchTopData();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CommentPageListItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.data != null) {
        _fetchTopData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color cardBgColor = Theme.of(context).cardColor;
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding / 2),
      padding: EdgeInsets.only(
        bottom: Style.defautlVerticalPadding / 2,
        top: Style.defautlVerticalPadding / 2,
        left: Style.defautlHorizontalPadding / 2,
        right: Style.defautlHorizontalPadding / 2,
      ),
      decoration: BoxDecoration(
        boxShadow: [Style.defaultShadow],
        color: cardBgColor,
        border: Border.all(
          width: 1,
          color: Style.textColor.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading(
            isLoading: imageUrl == null,
            fillBackgroundColor: cardBgColor,
            child: SizedBox(
              height: 155,
              width: 150,
              child: imageUrl == null
                  ? null
                  : CustomNetworkImageWidget(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      height: 155,
                      width: 150,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(
                    isLoading: title == null,
                    fillBackgroundColor: cardBgColor,
                    child: Text(
                      title ?? ('*' * 25),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ShimmerLoading(
                      isLoading: widget.data?['comment'] == null,
                      fillBackgroundColor: cardBgColor,
                      child: Text(
                        widget.data?['comment'] ?? ("*" * 25),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  ShimmerLoading(
                    isLoading: widget.data?['added_date'] == null,
                    fillBackgroundColor: cardBgColor,
                    child: Text(
                      widget.data?['added_date'] ?? ("*" * 15),
                      style: TextStyle(
                        fontSize: 11,
                        color: Style.textColor.withOpacity(
                          0.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 4),
                    child: ShimmerLoading(
                      isLoading: widget.data?['status'] == null,
                      fillBackgroundColor: cardBgColor,
                      child: Text(
                        ((widget.data?['status'] ?? '0') == '1') ? 'Onaylı' : "Onay Bekliyor",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Style.dangerColor,
                        ),
                      ),
                    ),
                  ),
                  if (widget.data != null)
                    Row(
                      children: [
                        ontapForItem(
                          "Güncelle",
                          Colors.blue,
                          () => editPop(context),
                        ),
                        ontapForItem(
                          "Sil",
                          Style.secondaryColor,
                          () {},
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ontapForItem(String title, Color color, void Function()? onTap) {
    return GestureDetector(
      onTap: widget.data == null ? null : onTap,
      child: Container(
        margin: EdgeInsets.only(right: Style.defautlHorizontalPadding / 2),
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 4,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: widget.data != null ? color : Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize / 2),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  editPop(BuildContext context) {
    showDialog(context: context, builder: (dialogContext) {
      return Dialog(
        alignment: Alignment.bottomCenter,
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Style.defautlVerticalPadding,
                  horizontal: Style.defautlHorizontalPadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.isBlog ? 'Blog' : 'Etkinlik'} Yorum Güncelleme",
                            style: TextStyle(
                              fontSize: Style.bigTitleTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(dialogContext),
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    CustomTextField(
                      hintText: "Yorum",
                      validator: Validator.requiredTextValidator,
                      initialValue: widget.data?['comment'] ?? '',
                      onChanged: (s) => updateText = (s ?? ''),
                    ),
                    ButtonForLogin(title: "Güncelle", onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (updateText.trim().isEmpty){
                        UIHelper.showSnackBar(message: 'Lütfen bir yorum metni giriniz.', type: UIType.warning, context: dialogContext, useDialog: true,);
                        return;
                      }
                      if (widget.data?['id'] == null) {
                        UIHelper.showSnackBar(message: 'Yorum verisi alınamadı. Lütfen daha sonra tekrar deneyin.', type: UIType.negative, context: dialogContext, useDialog: true,);
                        Navigator.maybePop(dialogContext);
                        return;
                      }
                      _updateComment(newComment: updateText, commentId: int.parse(widget.data!['id']), dialogContext: dialogContext);
                    },),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
    /*return showModalBottomSheet(
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
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Style.defautlVerticalPadding,
              horizontal: Style.defautlHorizontalPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.isBlog ? 'Blog' : 'Etkinlik'} Yorum Güncelleme",
                        style: TextStyle(
                          fontSize: Style.bigTitleTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  hintText: "Yorum",
                  validator: Validator.requiredTextValidator,
                  initialValue: widget.data?['comment'] ?? '',
                  onChanged: (s) => updateText = (s ?? ''),
                ),
                ButtonForLogin(title: "Güncelle", onTap: () {
                  if (updateText.trim().isEmpty){
                    UIHelper.showSnackBar(message: 'Lütfen bir yorum metni giriniz.', type: UIType.warning, context: context);
                    return;
                  }
                  if (widget.data?['id'] == null) {
                    UIHelper.showSnackBar(message: 'Yorum verisi alınamadı. Lütfen daha sonra tekrar deneyin.', type: UIType.negative, context: context);
                    Navigator.maybePop(context);
                    return;
                  }
                  _updateComment(newComment: updateText, commentId: int.parse(widget.data!['id']));
                },),
              ],
            ),
          ),
        );
      },
    );*/
  }

  _updateComment({required String newComment, required int commentId, required BuildContext dialogContext}) async {
    try {
      await context.read<TableViewModel>().tableUpdate(tableName: widget.isBlog ? TableName.BlogComment.name : TableName.ActivityComment.name, id: commentId, data: {
        'comment': newComment,
        'status': '0',
      });
      if (!mounted) return;
      Navigator.maybePop(dialogContext);
      UIHelper.showSnackBar(message: 'Yorum başarıyla onaya gönderildi.', type: UIType.positive, context: dialogContext);
      Navigator.pushReplacementNamed(context, widget.isBlog ? Routes.blogCommentPage : Routes.activityCommentPage);
    } catch(e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }

  _fetchTopData() async {
    if (widget.data == null) return;
    try {
      var record = await context.read<TableViewModel>().fetchRecord(
          tableName: widget.isBlog ? TableName.Blog.name : TableName.Activity.name,
          id: int.parse(widget.data![widget.isBlog ? 'blog_id' : 'activity_id']));
      topData = record.data;
      title = record.data?['title'] ?? '';
      imageUrl = record.data == null ? null : Util.imageConvertUrl(imageName: record.data?['image']);
      setState(() {});
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }
}
