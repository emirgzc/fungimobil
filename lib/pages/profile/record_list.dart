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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/osmanli.jpg",
            fit: BoxFit.cover,
            height: 155,
            width: 150,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Yılın Son Mantar Etkinliği(Fungi ID)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Kayıt Tarihi : 29/12/2022",
                      style: TextStyle(
                        fontSize: 11,
                        color: Style.textColor.withOpacity(
                          0.5,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Onaylandı",
                      style: TextStyle(
                        fontSize: 14,
                        color: Style.succesColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Ödeme Alınmadı",
                      style: TextStyle(
                        fontSize: 14,
                        color: Style.dangerColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child: Text(
                      "Toplam : 800 TL(2 Bilet)",
                      style: TextStyle(
                        fontSize: 13,
                        color: Style.secondaryColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ontapForItem(
                        "Güncelle",
                        Colors.blue,
                      ),
                      ontapForItem(
                        "Sil",
                        Style.secondaryColor,
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
