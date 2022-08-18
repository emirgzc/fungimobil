import 'package:flutter/material.dart';
import 'package:fungimobil/constants/style.dart';

class DrawerItemModel {
  String title;
  String route;
  IconData icon;

  DrawerItemModel(this.title, this.route, this.icon);
}

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  bool userExists = true;

  late final List<DrawerItemModel> menuItemList;

  @override
  Widget build(BuildContext context) {
    menuItemList = [
      DrawerItemModel('Ana Sayfa', '/home', Icons.home_outlined),
      DrawerItemModel('Hakkımızda', '/about', Icons.info_outline),
      DrawerItemModel('Organizasyonumuz', '/organization', Icons.ac_unit_outlined),
      DrawerItemModel('Galeri', '/gallery', Icons.photo_outlined),
      DrawerItemModel('Etkinlikler', '/activities', Icons.local_activity_outlined),
      DrawerItemModel('Blog', '/blog', Icons.newspaper),
      DrawerItemModel('Sponsorlar', '/sponsor', Icons.handshake_outlined),
      DrawerItemModel('Alışveriş', '/shop', Icons.shopping_cart_outlined),
      DrawerItemModel('İletişim', '/contact', Icons.contact_support_outlined),
      if(userExists) DrawerItemModel('Profil', '/profile', Icons.person_outline),
      if(!userExists) DrawerItemModel('Çıkış Yap', '/sigOut', Icons.exit_to_app_outlined),
    ];
    return Container(
      height: double.infinity,
      color: Colors.white,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildProfile(context),
          // SizedBox(height: Style.defaultPadding*2,),
          Expanded(
            child: Scrollbar(
              thickness: 4,
              trackVisibility: true,
              child: ListView.separated(
                 padding: EdgeInsets.symmetric(vertical: Style.defaultPadding*3),
                  scrollDirection: Axis.vertical,
                  physics: PageScrollPhysics(),
                  itemBuilder: (context, index) {
                    var model = menuItemList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Style.defaultPadding, vertical: Style.defaultPadding / 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            model.icon,
                            color: Colors.deepOrange.shade800,
                          ),
                          SizedBox(
                            width: Style.defaultPadding,
                          ),
                          Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                  child: Text(
                            model.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ))),
                        ],
                      ),
                    );
                    // return ListTile(
                    //   minVerticalPadding: 0,
                    //   leading: Icon(model.icon, color: Colors.deepOrange.shade800,),
                    //   title: Text(model.title, style: Theme.of(context).textTheme.titleMedium,),
                    // );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: menuItemList.length),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  TODO: Navigate ProfilePage
      },
      child: Material(
        color: Colors.deepOrange,
        child: Card(
          margin: EdgeInsets.all(Style.defaultPadding),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Style.defaultPadding),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Material(
                      color: Colors.deepOrange.shade500,
                      child: Image.asset(
                        'assets/images/logo_white_notbg.png',
                        height: 50,
                      )),
                ),
                SizedBox(
                  width: Style.defaultPadding,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Furkan Yağmur',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(
                        height: Style.defaultPadding / 5,
                      ),
                      Text(
                        'Öğrenci',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
