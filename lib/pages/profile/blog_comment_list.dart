import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';

class BlogCommentList extends StatelessWidget {
  const BlogCommentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Blog Yorumlarım"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () => detailPop(context),
                    child: commentCard(context),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentCard(BuildContext context) {
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
        color: Colors.white,
        border: Border.all(
          width: 1,
          color: Style.textColor.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemComment("Yorum : ", "Çok başarılı bir yazı teşekkürler."),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: itemComment("Yorum Tarihi : ", "21.08.2022"),
          ),
          itemComment("Blog : ", "Mantar Avcılığı İçin Gerekli Ekipmanlar"),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                ontapForItem(
                  "Onay Bekliyor",
                  Style.dangerColor,
                  () {},
                ),
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
          ),
        ],
      ),
    );
  }

  Future editPop(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Blog Yorum Güncelleme",
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
                CustomTextField(hintText: "İsim Soyisim"),
                CustomTextField(hintText: "Mail Adresi"),
                CustomTextField(hintText: "Yorum"),
                const ButtonForLogin(title: "Güncelle"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget ontapForItem(String title, Color color, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: Style.defautlHorizontalPadding / 2),
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 4,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize / 2),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Row itemComment(String title, String item) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(item),
      ],
    );
  }
}
