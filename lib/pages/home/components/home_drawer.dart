import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/model/menu_model.dart';
import 'package:fungimobil/model/user_model.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/viewmodel/config_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  List<MenuModel>? menuList;
  UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Style.primaryColor,
        width: 300,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: FutureBuilder(
          future: _fetchData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done && menuList != null) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  drawerHeader(context, userModel),
                  Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: Style.defaultPadding, bottom: Style.defaultPadding*3),
                          itemBuilder: (context, index) {
                            if (index >= (menuList?.length ?? 0)) {
                              if (userModel == null) {
                                return drawerItem(context, "Giriş Yap", Routes.loginPage, 'login.svg', onTap: () async {
                                  Navigator.pushNamed(context, Routes.loginPage);
                                });
                              } else {
                                return drawerItem(context, "Çıkış Yap", Routes.loginPage, 'exit.svg', onTap: () async {
                                  Provider.of<AuthViewModel>(context, listen: false).signOut().then(
                                      (value) => Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (route) => false));
                                });
                              }
                            }
                            var item = menuList![index];
                            return drawerItem(context, item.displayName!, item.tableName!, item.icon!);
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Color(0x88ff4500),
                            );
                          },
                          itemCount: (menuList?.length ?? 0) + 1)),
                  /*for (int i = 0; menuList != null && i < menuList!.length; i++)
                    drawerItem(context, menuList![i].displayName!, menuList![i].tableName!, menuList![i].icon!),
                  drawerItem(context, "Çıkış Yap", Routes.loginPage, 'exit.svg', onTap: () async {
                    Provider.of<AuthViewModel>(context, listen: false)
                        .signOut()
                        .then((value) => Navigator.pushNamedAndRemoveUntil(context, Routes.homePage, (route) => false));
                  }),*/
                ],
              );
            } else if (snapshot.hasError && snapshot.error != null) {
              HandleExceptions.handle(
                exception: snapshot.error,
                context: context,
              );
            }
            return Padding(
              padding: const EdgeInsets.all(Style.defaultPadding * 3),
              child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 0.4.sw), child: Image.asset('assets/images/black.png')),
            );
          },
        ),
      ),
    );
  }

  Widget drawerHeader(BuildContext context, UserModel? user) {
    return SizedBox(
      width: double.infinity,
      height: 0.3.sh,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(Style.defaultPadding),
        decoration: const BoxDecoration(
          gradient: LinearGradient(end: Alignment.topLeft, begin: Alignment.bottomRight, stops: [
            0.2,
            0.7,
            1.0
          ], colors: [
            Color(0xffff8c00),
            Color(0xffff5e0e),
            Color(0xffff4500),
          ]),
          color: Style.secondaryColor,
        ),
        // margin: const EdgeInsets.only(bottom: 8),
        child: user == null
            ? Center(
                child: Image.asset(
                  'assets/images/black.png',
                  height: Style.defaultIconSize * 3,
                  color: Colors.white,
                ),
              ) /*Column(
                mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Style.defaultPadding),
                  child: Image.asset(
                    'assets/images/black.png',
                    height: Style.defaultIconSize * 3,
                    color: Colors.white,
                  ),
                ),
              ],
            )*/
            : Padding(
              padding: const EdgeInsets.only(right: Style.defaultPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            // color: Style.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/logo_white_notbg.png',
                            height: Style.defaultIconSize * 4,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // const Spacer(),
                    Text(
                      "${user.name ?? ""} ${user.surname ?? ""}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    const SizedBox(
                      height: Style.defaultPadding / 2,
                    ),
                    Text(
                      user.email ?? "",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
            ),
      ),
    );
  }

  Widget drawerItem(BuildContext context, String title, String routes, String icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: icon.isEmpty
          ? const Icon(
              Icons.article_outlined,
              color: Color(0xffff5e0e),
            )
          : SvgPicture.asset(
              'assets/icons/$icon',
              width: Style.defaultIconSize,
              height: Style.defaultIconSize,
              color: const Color(0xffff5e0e),
            ),
      dense: true,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onTap: onTap ??
          () {
            Navigator.pushNamed(context, routes);
          },
    );
  }

  Future _fetchData(BuildContext context) async {
    try {
      userModel = await context.read<AuthViewModel>().getUserInfoFromLocale();
      menuList = await context.read<ConfigViewModel>().getMenu();
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }
}
