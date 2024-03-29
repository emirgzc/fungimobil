import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/constants/contants.dart';
import 'package:fungimobil/constants/extension.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/constants/util.dart';
import 'package:fungimobil/model/table_model.dart' as tableModel;
import 'package:fungimobil/model/user_model.dart';
import 'package:fungimobil/pages/home/components/home_drawer.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/shimmer/shimmer.dart';
import 'package:fungimobil/widgets/shimmer/shimmer_loading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_network_image_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? activityDataList, blogDataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHomePage(context),
      drawer: HomeDrawer(),
      body: Shimmer(
          linearGradient: Style.shimmerGradient,
          child: Builder(builder: (context) {
            return homePageBody(context);
          })),
    );
  }

  Widget homePageBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Fungi Turkey",
                      style: TextStyle(
                        fontSize: 28,
                        color: Style.textColor,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    Lottie.asset(
                      "assets/lottie/nature.json",
                      repeat: true,
                      height: 100.h,
                      width: 200.w,
                    ),
                  ],
                ),
                FutureBuilder(
                  future: _fetchUserInfo(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
                      var datas = snapshot.data as UserModel;
                      return Padding(
                        padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
                        child: Text(
                          "Hoşgeldin ${datas.name}" " ${datas.surname},",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Style.textColor,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError && snapshot.error != null) {
                      HandleExceptions.handle(
                        exception: snapshot.error,
                        context: context,
                      );
                      return Container();
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: 24.h, bottom: 12.h),
                        child: const Text(
                          "Hoşgeldiniz, Fungi Turkey hakkında detaylı bilgi almak, etkinliklere katılmak, yorum yapmak ve daha fazlası için kayıt olun ve giriş yapın.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Style.textColor,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _buildSlider(context),
            const SizedBox(
              height: Style.defaultPadding / 2,
            ),

            /* Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i <= categoriesItem.length - 1; i++)
                      sliderCardItem(
                        categoriesItem[i].title.toString(),
                        context,
                        categoriesItem[i].routesWay.toString(),
                        categoriesItem[i].icon!,
                      ),
                  ],
                ),
              ),
            ), */
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: titleForRow(
                "Son Kayıtlar!",
                "Tümünü Göster",
                () => Navigator.pushNamed(context, Routes.activityPage),
              ),
            ),
            FutureBuilder(
              future: activityDataList == null ? _fetchActivity(context) : null,
              builder: (context, snapshot) {
                debugPrint(activityDataList?.length.toString());
                // if (activityDataList == null) {
                //   return const SizedBox();
                // }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < min(5, activityDataList?.length ?? 5); i++)
                        actHomeCard(activityDataList == null ? null : activityDataList![i], context),
                    ],
                  ),
                );
              },
            ),
            titleForRow(
              "Bloglar",
              "Tümünü Göster",
              () => Navigator.pushNamed(context, Routes.blogPage),
            ),
            SizedBox(
              height: 48.h,
            ),
            FutureBuilder(
                future: blogDataList == null ? _fetchBlog(context) : null,
                builder: (context, snapshot) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: min(4, blogDataList?.length ?? 4),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return blogCard(blogDataList == null ? null : blogDataList?.reversed.toList()[index], context);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TableViewModel>(context, listen: false).fetchTable(
        tableName: TableName.Slider.name,
        page: 1,
        limit: 100,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError && snapshot.error != null) {
          HandleExceptions.handle(
            exception: snapshot.error,
            context: context,
          );
          return Container();
        }
        var datas = (snapshot.data as tableModel.TableModel?)?.data;
        debugPrint(datas?.length.toString());
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: 160,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: const Duration(
              milliseconds: 600,
            ),
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
            reverse: false,
          ),
          itemCount: datas?.length ?? 3,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 16,
                    right: 6,
                    left: 6,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                      Style.defaultRadiusSize,
                    ),
                  ),
                  child: Opacity(
                    opacity: 0.5,
                    child: CustomNetworkImageWidget(
                      imageUrl: Util.imageConvertUrl(
                        imageName: datas?[index]["image"] ?? Constants.defaultImageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        datas?[index]["title"] ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /*Padding _buildCategories(BuildContext context, List<MenuModel>? menuList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              for (int i = 0; i < (menuList?.length ?? 7); i++)
                sliderCardItem(
                  menuList?[i].displayName ?? '',
                  context,
                  menuList?[i].tableName?.replaceAll('/', '') ?? '',
                  Icons.add,
                ),
            ],
          ),
        ),
      ),
    );
  }*/

  /*Widget sliderCardItem(String title, BuildContext context, String routeName, IconData icon) {
    return GestureDetector(
      onTap: routeName == null
          ? null
          : () {
              Navigator.pushNamed(context, routeName);
            },
      child: ShimmerLoading(
        isLoading: title == null,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8, left: 4, bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Style.secondaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(
                  Style.defaultRadiusSize,
                ),
              ),
              child: Icon(
                icon,
                size: 32,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Style.textColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget blogCard(Map<String, dynamic>? data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.blogDetailPage, arguments: data!["id"]);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 32.h),
        height: 240.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize / 2),
          boxShadow: [Style.defaultShadow],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 24.w),
              child: ShimmerLoading(
                isLoading: data == null,
                child: SizedBox(
                  width: 360.w,
                  height: double.infinity,
                  child: data == null
                      ? Container(
                          color: Colors.white.withOpacity(0.8),
                        )
                      : CustomNetworkImageWidget(
                          imageUrl: Util.imageConvertUrl(
                            imageName: data['image'],
                          ),
                        ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading(
                      isLoading: data == null,
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: Text(
                          data?['title'] ?? 'Blog başlığı',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    /*ShimmerLoading(
                      isLoading: data == null,
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: HtmlTextWidget(
                          content: data?['content'],
                          maxContentLength: 35,
                          isLoading: data == null,
                          loadingText: '*' * 100,
                          fontSize: Style.defaultTextSize * 0.75,
                        ),

                        */ /*HtmlWidget(
                          '${data?['content'].toString().substring(0, min(35, data['content'].toString().length)) ?? '*' * 100}...',
                          textStyle: TextStyle(
                            fontSize: Style.defaultTextSize * 0.75,
                          ),
                        ),*/ /* */ /*Text(
                          data?['content'].toString() ?? '*' * 100,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: Style.defaultTextSize / (4 / 3),
                          ),
                        ),*/ /*
                      ),
                    ),*/
                    ShimmerLoading(
                      isLoading: data == null,
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: Text(
                          "Ömer Üngör!!",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 36.sp,
                          ),
                        ),
                      ),
                    ),
                    ShimmerLoading(
                      isLoading: data == null,
                      child: Container(
                        color: Colors.white.withOpacity(0.8),
                        child: Text(
                          data?['added_date']?.toString().toDateTime().toFormattedString() ?? '1 Ocak 2000',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: Style.textColor.withOpacity(0.65),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actHomeCard(Map<String, dynamic>? data, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.activityDetailPage, arguments: data);
      },
      child: Container(
        margin: EdgeInsets.only(top: 48.h, bottom: 48.h, right: 24.w, left: 12.w),
        width: 660.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize / 2),
          boxShadow: [Style.defaultShadow],
        ),
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ShimmerLoading(
                    isLoading: data == null,
                    child: SizedBox(
                      width: double.infinity,
                      height: 0.2.sh,
                      child: data == null
                          ? Container(
                              color: Colors.white.withOpacity(0.8),
                            )
                          : Hero(
                              tag: data['image'],
                              child: CustomNetworkImageWidget(
                                imageUrl: Util.imageConvertUrl(
                                  imageName: data['image'],
                                ),
                              ),
                            ),
                    ),
                  ),
                  if (data != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 12.w,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 12.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(
                            Style.defaultRadiusSize / 2,
                          ),
                        ),
                        child: Text(
                          "Son Kayıt : ${data['last_record_date']?.toString().toDateTime().toFormattedString() ?? '1 Ocak 2000'}",
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w500,
                            color: Style.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 8),
                child: ShimmerLoading(
                  isLoading: data == null,
                  child: Container(
                    color: Colors.white.withOpacity(0.8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      data?['title']?.toString() ?? '*' * 20,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        overflow: TextOverflow.fade,
                        fontSize: 44.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: SvgPicture.asset(
                        "assets/icons/locations.svg",
                        height: 28.r,
                      ),
                    ),
                    Expanded(
                      child: ShimmerLoading(
                        isLoading: data == null,
                        child: Container(
                          color: Colors.white.withOpacity(0.8),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data?['location']?.toString() ?? '*' * 20,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 34.sp,
                              color: Style.textColor.withOpacity(0.65),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleForRow(String titleOne, String titleTwo, void Function()? onTap) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleOne,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            titleTwo,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  AppBar appBarHomePage(BuildContext context) {
    return AppBar(
      toolbarHeight: 220.h,
      foregroundColor: Style.textColor,
      title: Image.asset(
        "assets/images/black.png",
        fit: BoxFit.cover,
        height: 120.h,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {
            editPop(context);
          },
          child: Container(
            margin: EdgeInsets.only(right: 36.w),
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Style.textColor.withOpacity(0.15),
              ),
            ),
            child: const Icon(Icons.people_alt_outlined),
          ),
        ),
      ],
    );
  }

  Future editPop(BuildContext context) async {
    bool isUserExists = await Provider.of<AuthViewModel>(context, listen: false).isUserExists();
    if (!mounted) return;
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
              if (isUserExists)
                profileMenuCard(
                  context,
                  "Profil",
                  "assets/icons/users.svg",
                  () => Navigator.pushNamed(context, Routes.profilePage),
                ),
              if (!isUserExists)
                profileMenuCard(
                  context,
                  "Giriş Yap",
                  "assets/icons/login.svg",
                  () => Navigator.pushNamed(context, Routes.loginPage),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget profileMenuCard(BuildContext context, String title, String icon, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 12.h),
        margin: EdgeInsets.only(bottom: 28.h),
        decoration: BoxDecoration(
          color: Style.primaryColor,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          // color: Colors.red,
        ),
        child: ListTile(
          dense: true,
          leading: SvgPicture.asset(
            icon,
            color: Theme.of(context).unselectedWidgetColor,
          ),
          title: Text(title),
        ),
      ),
    );
  }

  Future _fetchActivity(BuildContext context) async {
    try {
      // await Future.delayed(Duration(seconds: 5));
      activityDataList = (await Provider.of<TableViewModel>(context, listen: false)
              .fetchTable(tableName: TableName.Activity.name, page: 1, limit: 5))
          .data;
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }

  Future _fetchBlog(BuildContext context) async {
    try {
      // await Future.delayed(Duration(seconds: 5));
      blogDataList = (await Provider.of<TableViewModel>(context, listen: false)
              .fetchTable(tableName: TableName.Blog.name, page: 1, limit: 4))
          .data;
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }

  Future<UserModel?> _fetchUserInfo(BuildContext context) async {
    try {
      bool userExists = await Provider.of<AuthViewModel>(context, listen: false).isUserExists();
      if (userExists && mounted) {
        return await Provider.of<AuthViewModel>(context, listen: false).getUserInfoFromLocale();
      }
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
    return null;
  }

/*Future<List<MenuModel>?> _getMenuList(BuildContext context) async {
    try {
      return await Provider.of<ConfigViewModel>(context, listen: false)
          .getMenu();
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
    return null;
  }*/
}

class Categories {
  String? title;
  IconData? icon;
  String? routesWay;

  Categories({
    required this.title,
    required this.icon,
    required this.routesWay,
  });
}

// List<Categories> categoriesItem = [
//   Categories(title: "Hakkımızda", icon: "icon", routesWay: Routes.aboutPage),
//   Categories(title: "Takımımız", icon: "icon", routesWay: Routes.teamPage),
//   Categories(title: "Organizasyonumuz", icon: "icon", routesWay: Routes.servicePage),
//   Categories(title: "Galeri", icon: "icon", routesWay: Routes.galeryPage),
//   Categories(title: "Etkinlikler", icon: "icon", routesWay: Routes.activityPage),
//   Categories(title: "Blog", icon: "icon", routesWay: Routes.blogPage),
//   Categories(title: "Sponsorlarımız", icon: "icon", routesWay: Routes.sponsorPage),
//   Categories(title: "İletişim", icon: "icon", routesWay: Routes.contactPage),
// ];
