import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.primaryColor,
      appBar: getAppBar("Etkinlikler"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              ...List.generate(
                4,
                (index) {
                  return activityCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget activityCard() {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageForActivity(),
          title(),
          desc(),
          detailDateandDirector(),
        ],
      ),
    );
  }

  Widget desc() {
    return Text(
      "Mantar avcılığı yapabilmemiz için ekipmanlara ihtiyacımız vardır. Bu ekipmanların olmazsa olmazı sepet, çakı ve fırçadır. Diğer ekleyeceğimiz ekipmanlar ise bizim konforumuz ve güvenliğimiz açısından önem taşımaktadır.",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Style.textGreyColor,
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
      child: Text(
        "Mantar Avcılığı İçin Gerekli Ekipmanlar",
        style: TextStyle(
          fontSize: Style.bigTitleTextSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget imageForActivity() {
    return Stack(
      children: [
        SizedBox(
          height: 550.h,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
            child: Image.asset(
              "assets/images/fungi1.jpeg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        buttonForContinue(),
      ],
    );
  }

  Widget buttonForContinue() {
    return Positioned(
      bottom: Style.defautlVerticalPadding / 2,
      right: Style.defautlHorizontalPadding / 2,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 4,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Style.secondaryColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(
            Style.defaultRadiusSize,
          ),
        ),
        child: Text(
          "Devamını Oku...",
          style: TextStyle(
            color: Style.textColor,
            fontSize: Style.defaultTextSize,
          ),
        ),
      ),
    );
  }

  Widget detailDateandDirector() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: Style.defautlHorizontalPadding / 4),
            child: Icon(
              Icons.person_outline_sharp,
              color: Style.textGreyColor,
              size: Style.defaultTextSize,
            ),
          ),
          Text(
            "Ömer Üngör",
            style: TextStyle(
              color: Style.textGreyColor,
            ),
          ),
          const Spacer(),
          const Text(
            "Son Kayıt : 12 Ağustos 2022",
            style: TextStyle(
              color: Style.dangerColor,
            ),
          ),
        ],
      ),
    );
  }
}
