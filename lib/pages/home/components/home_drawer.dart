import 'package:flutter/material.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/model/user_model.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Style.primaryColor,
      width: 300,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: Provider.of<AuthViewModel>(context, listen: false)
                  .getUserInfoFromLocale(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  var datas = snapshot.data as UserModel;
                  debugPrint(datas.toString());
                  return drawerHeader(context, datas);
                } else if (snapshot.hasError && snapshot.error != null) {
                  HandleExceptions.handle(
                    exception: snapshot.error,
                    context: context,
                  );
                  return Container();
                } else {
                  return Container();
                }
              },
            ),
            drawerItem(context, "Ana Sayfa", Routes.homePage, Icons.home),
            drawerItem(context, "Hakkımızda", Routes.aboutPage, Icons.info),
            drawerItem(context, "Takımımız", Routes.teamPage, Icons.people),
            drawerItem(context, "Organizasyonumuz", Routes.servicePage,
                Icons.room_service_rounded),
            drawerItem(
                context, "Galeri", Routes.galeryPage, Icons.photo_camera),
            drawerItem(context, "Etkinlikler", Routes.activityPage,
                Icons.local_activity),
            drawerItem(context, "Blog", Routes.blogPage,
                Icons.pending_actions_outlined),
            drawerItem(context, "Sponsorlarımız", Routes.sponsorPage,
                Icons.sports_handball_rounded),
            drawerItem(
                context, "İletişim", Routes.contactPage, Icons.contact_mail),
            drawerItem(
                context, "Çıkış Yap", Routes.loginPage, Icons.logout_outlined,
                onTap: () async {
              Provider.of<AuthViewModel>(context, listen: false).signOut().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                      context, Routes.homePage, (route) => false));
            }),
          ],
        ),
      ),
    );
  }

  DrawerHeader drawerHeader(BuildContext context, UserModel datas) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Style.secondaryColor,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Style.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/logo_white_notbg.png',
                height: 50,
                color: Style.textColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "${datas.name ?? ""} ${datas.surname ?? ""}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Text(
              datas.phone ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              datas.email ?? "",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Column drawerItem(
      BuildContext context, String title, String routes, IconData icon,
      {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          dense: true,
          title: Text(title),
          onTap: onTap ??
              () {
                Navigator.pushNamed(context, routes);
              },
        ),
        const Divider(),
      ],
    );
  }
}
