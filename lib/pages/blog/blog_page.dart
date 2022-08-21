import 'package:flutter/material.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/widgets/appbar.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Blog Sayfası"),
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.defaultPagePadding,
          child: Column(
            children: [
              ...List.generate(
                4,
                (index) {
                  return blogCard(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget blogCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.blogDetailPage);
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Style.defaultRadiusSize,
                  ),
                  child: Image.asset(
                    "assets/images/abc.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: Style.defautlVerticalPadding / 2,
                  right: Style.defautlVerticalPadding / 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Style.defautlVerticalPadding / 6,
                      horizontal: Style.defautlHorizontalPadding / 4,
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
                        color: Colors.black,
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
              "Mantar Avcılığı İçin Gerekli Ekipmanlar",
              style: TextStyle(
                fontSize: Style.bigTitleTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            "Mantar avcılığı yapabilmemiz için ekipmanlara ihtiyacımız vardır. Bu ekipmanların olmazsa olmazı sepet, çakı ve fırçadır. Diğer ekleyeceğimiz ekipmanlar ise bizim konforumuz ve güvenliğimiz açısından önem taşımaktadır.",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Style.textGreyColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Style.defautlVerticalPadding / 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: Style.defautlHorizontalPadding / 4),
                  child: Icon(
                    Icons.person_outline_sharp,
                    color: Style.textGreyColor,
                    size: Style.defautlVerticalPadding,
                  ),
                ),
                Text(
                  "Ömer Üngör",
                  style: TextStyle(color: Style.textGreyColor),
                ),
                const Text(
                  " . ",
                  style: TextStyle(),
                ),
                const Text(
                  "12 Ağustos 2022",
                  style: TextStyle(
                    color: Style.succesColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
