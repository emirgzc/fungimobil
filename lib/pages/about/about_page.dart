import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Hakkımızda"),
      body: aboutBody(context),
    );
  }

  Widget aboutBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
              child: Image.asset(
                'assets/images/fungi1.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
              child: bigTitle("Misyonumuz"),
            ),
            desc(),
            Padding(
              padding: EdgeInsets.only(top: Style.defautlVerticalPadding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                child: Image.asset(
                  'assets/images/fungi2.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
              child: bigTitle("Vizyonumuz"),
            ),
            desc(),
          ],
        ),
      ),
    );
  }

  Widget desc() {
    return Text(
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
          10,
      style: TextStyle(
        fontSize: Style.defaultTextSize,
        color: Style.textGreyColor,
      ),
    );
  }

  Widget bigTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: Style.bigTitleTextSize,
        fontWeight: FontWeight.w500,
        color: Style.secondaryColor,
      ),
    );
  }
}
