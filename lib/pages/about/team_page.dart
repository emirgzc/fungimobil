import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Takımımız"),
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
              MasonryGridView.count(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 8,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 160,
                          child: Image.asset(
                            "assets/images/abc.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Ömer Üngör",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s" *
                            (index + 1),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Kurucu/Ortak",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF4A261),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
