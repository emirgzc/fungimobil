import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/card_for_social_media.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("İletişim"),
      body: FutureBuilder(
        future: ApiClient().fetchTable(
          tableName: TableName.Contact.name,
          token: "",
          page: 1,
          limit: 10,
          filter: {},
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            var datas = (snapshot.data as tableModel.TableModel).data;
            debugPrint(datas?.length.toString());
            return Column(
              children: [
                ...List.generate(
                  datas?.length ?? 0,
                  (index) {
                    return contactBody(datas, index);
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
    );
  }

  Widget contactBody(List<Map<String, dynamic>>? datas, int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigTitle(title: "İletişim Bilgileri", size: 72.sp),
            contactInfoTitle(
                "Adres", datas?[index]["adress"] ?? "", Icons.home),
            contactInfoTitle(
                "Telefon", datas?[index]["phone"], Icons.phone_android),
            contactInfoTitle(
              "Mail Adresi",
              datas?[index]["mail"],
              Icons.mail_outline_rounded,
            ),
            contactInfoTitle(
              "Yönetici",
              datas?[index]["director"],
              Icons.people_alt_outlined,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
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
            CustomTextField(hintText: "İsim Soyisim"),
            CustomTextField(hintText: "Mail Adresi"),
            CustomTextField(hintText: "Telefon"),
            CustomTextField(hintText: "Konu"),
            CustomTextField(hintText: "Mesajınız"),
            const ButtonForLogin(title: "Gönder"),
          ],
        ),
      ),
    );
  }

  Widget contactInfoTitle(String title, String data, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: Style.defautlHorizontalPadding / 4),
            child: Icon(icon, size: 60.r),
          ),
          Text(
            "$title: $data",
            style: TextStyle(fontSize: Style.defaultTextSize),
          ),
        ],
      ),
    );
  }
}
