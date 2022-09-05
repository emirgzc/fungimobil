import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Organizasyon"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              ...List.generate(
                8,
                (index) {
                  return serviceCard(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => detailPop(context),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                  child: Image.asset(
                    "assets/images/fungi2.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: Style.defautlVerticalPadding / 2,
                  right: Style.defautlHorizontalPadding / 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding / 4,
                      horizontal: Style.defautlHorizontalPadding / 2,
                    ),
                    decoration: BoxDecoration(
                      color: Style.secondaryColor.withOpacity(0.9),
                      borderRadius:
                          BorderRadius.circular(Style.defaultRadiusSize),
                    ),
                    child: Text(
                      "Devamını Oku...",
                      style: TextStyle(
                        color: Style.textColor,
                        fontSize: Style.defaultTextSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: Text(
              "MANTAR AVCILIĞI EĞİTİMLERİ",
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Style.defautlVerticalPadding / 2),
            child: Text(
              "Lorem Ipsum has been the industry's standard dummy text the 1500s" *
                  4,
              maxLines: 2,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Style.textGreyColor,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: Style.defaultPadding / 3),
            height: 1,
            width: double.infinity,
            color: Style.secondaryColor.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Future detailPop(BuildContext context) {
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
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: Style.defautlVerticalPadding,
            horizontal: Style.defautlHorizontalPadding,
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
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Style.defautlVerticalPadding),
                child: Text(
                  "Organizasyon",
                  style: TextStyle(
                    fontSize: Style.bigTitleTextSize,
                    fontWeight: FontWeight.bold,
                    color: Style.secondaryColor,
                  ),
                ),
              ),
              Text(
                "Lorem Ipsum has been the industry's standard dummy text the 1500s" *
                    4,
              ),
            ],
          ),
        );
      },
    );
  }
}
