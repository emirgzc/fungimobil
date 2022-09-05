import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class RecordList extends StatelessWidget {
  const RecordList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Etkinlik Kayıtlarım"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () => detailPop(context),
                    child: commentCard(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentCard() {
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
          itemComment("Kayıt Tarihi : ", "21 Ağustos 2022 13:20"),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: itemComment("Etkinlik Tarihi : ", "25 Eylül 2021 - 14:00"),
          ),
          itemComment(
            "Kişi Sayısı : ",
            "2",
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: itemComment(
              "Ücret : ",
              "350,00 ₺",
            ),
          ),
          itemComment(
            "Toplam Ücret : ",
            "700,00 ₺",
          ),
          Padding(
            padding: EdgeInsets.only(top: Style.defautlVerticalPadding / 2),
            child: Row(
              children: [
                ontapForItem("Onay Bekliyor", Style.dangerColor),
                ontapForItem("Ödeme Bekleniyor", Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ontapForItem(String title, Color color) {
    return Container(
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
