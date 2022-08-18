import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GaleryPage extends StatelessWidget {
  const GaleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galeri"),
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
                  return GestureDetector(
                    onTap: () => detailPop(context),
                    child: Container(
                      height: 170,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/fungi1.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
          topLeft: Radius.circular(48.r),
          topRight: Radius.circular(48.r),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 48.w),
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
                padding: EdgeInsets.symmetric(vertical: 48.h),
                child: Text(
                  "Organizasyon",
                  style: TextStyle(
                    fontSize: 62.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/fungi1.jpeg",
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}
