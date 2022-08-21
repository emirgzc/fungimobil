import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/text_field.dart';

class ActivityCommentList extends StatelessWidget {
  const ActivityCommentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Etkinlik Yorumlarım"),
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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(
        bottom: 12,
        top: 8,
        left: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          itemComment("Yorum : ",
              "Çok başarılı bir etkinlikti ellerinize sağlık, kolay gelsin teşekkürler."),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: itemComment("Yorum Tarihi : ", "21.08.2022"),
          ),
          itemComment(
              "Etkinlik : ", "Mantar Avı ve Gastronomisi Etkinliği (Kamplı)"),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                ontapForItem("Onay Bekliyor", Colors.red, () {}),
                ontapForItem("Güncelle", Colors.blue, () => editPop(context)),
                ontapForItem("Sil", Colors.amber, () {}),
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
                        "Etkinlik Yorum Güncelleme",
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
                const CustomTextField(hintText: "İsim Soyisim"),
                const CustomTextField(hintText: "Mail Adresi"),
                const CustomTextField(hintText: "Yorum"),
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
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(item),
        ),
      ],
    );
  }
}
