import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class SponsorPage extends StatelessWidget {
  const SponsorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Sponsorlarımız"),
      body: sponsorBody(),
    );
  }

  Widget sponsorBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          children: [
            ...List.generate(
              4,
              (index) {
                return sponsorCard();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sponsorCard() {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding * (3 / 2)),
      child: Column(
        children: [
          SizedBox(
            height: 550.h,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              child: Image.asset(
                "assets/images/abc.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: Style.defautlVerticalPadding / 2,
            ),
            child: Text(
              "MANTAR AVCILIĞI EĞİTİMLERİ",
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "www.fungiturkey.org",
            style: TextStyle(
              color: Colors.blue.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
