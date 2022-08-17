import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: AppBar(
        title: const Text("Blog Sayfası"),
        centerTitle: true,
        backgroundColor: const Color(0xffF9F9F9),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(48.r),
          child: Column(
            children: [
              ...List.generate(4, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/abc.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white.withOpacity(0.9),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Mantar Avcılığı İçin Gerekli Ekipmanlar",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "Mantar avcılığı yapabilmemiz için ekipmanlara ihtiyacımız vardır. Bu ekipmanların olmazsa olmazı sepet, çakı ve fırçadır. Diğer ekleyeceğimiz ekipmanlar ise bizim konforumuz ve güvenliğimiz açısından önem taşımaktadır.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.person_outline_sharp,
                                color: Colors.black.withOpacity(0.4),
                                size: 16,
                              ),
                            ),
                            Text(
                              "Ömer Üngör",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                            const Text(
                              " . ",
                              style: TextStyle(),
                            ),
                            Text(
                              "12 Ağustos 2022",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
