import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Takımımız"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              MasonryGridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 8,
                crossAxisCount: 2,
                mainAxisSpacing: Style.defautlVerticalPadding,
                crossAxisSpacing: Style.defautlHorizontalPadding,
                itemBuilder: (context, index) {
                  return teamCard(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget teamCard(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          child: SizedBox(
            height: 500.h,
            child: Image.asset(
              "assets/images/abc.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
          child: Text(
            "Ömer Üngör",
            style: TextStyle(
              fontSize: 56.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
              (index + 1),
          style: TextStyle(
            fontSize: 40.sp,
            color: Style.textGreyColor,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 2),
          child: Text(
            "Kurucu/Ortak",
            style: TextStyle(
              fontSize: Style.defaultTextSize,
              color: Style.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
