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
          itemComment("Kayıt Tarihi : ", "21 Ağustos 2022 13:20"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: itemComment("Etkinlik Tarihi : ", "25 Eylül 2021 - 14:00"),
          ),
          itemComment(
            "Kişi Sayısı : ",
            "2",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
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
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                ontapForItem("Onay Bekliyor", Colors.red),
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
