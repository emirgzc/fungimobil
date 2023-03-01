import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/style.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/model/table_model.dart' as table;
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/appbar.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';
import 'package:fungimobil/widgets/loading_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? editData;
  UserModel? userModel;
  int? blogCommentNumber, activityCommentNumber, recordNumber;

  final Map<String, dynamic> updateData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Profil Sayfası"),
      body: FutureBuilder(
          future: _fetchUserInfo(),
          builder: (context, snapshot) {
            if (userModel != null &&
                blogCommentNumber != null &&
                activityCommentNumber != null &&
                recordNumber != null) {
              return profileBody(userModel!, context);
            } else if (snapshot.hasError && snapshot.error != null) {
              HandleExceptions.handle(
                  exception: snapshot.error, context: context);
            }
            return const LoadingWidget();
          }),
    );
  }

  Widget profileBody(UserModel userModel, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: Style.defaultPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Style.secondaryColor.withOpacity(0.3),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Lottie.asset(
                    "assets/lottie/personel.json",
                    height: 130,
                    width: 130,
                    fit: BoxFit.cover,
                    repeat: true,
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 24),
                  height: 100,
                  width: 1,
                  color: Style.secondaryColor.withOpacity(0.4),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        userModel.phone ?? "",
                        style: TextStyle(
                          fontSize: 32.sp,
                        ),
                      ),
                    ),
                    Text(
                      userModel.email ?? "",
                      style: TextStyle(
                        fontSize: 32.sp,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        userModel.job ?? "",
                        style: TextStyle(
                          fontSize: 32.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        userModel.city ?? "",
                        style: TextStyle(
                          fontSize: 32.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name ?? '',
                    style: TextStyle(
                      fontSize: 100.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userModel.surname ?? '',
                    style: TextStyle(
                      height: 0.8,
                      fontSize: 120.sp,
                      color: Style.textColor.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Column(
                children: [
                  menuItem(
                    Style.secondaryColor,
                    "Blog Yorumları",
                    Icons.comment,
                    () {
                      Navigator.pushNamed(context, Routes.blogCommentPage);
                    },
                  ),
                  menuItem(
                    Style.dangerColor,
                    "Etkinlik Yorumları",
                    Icons.comment_bank_outlined,
                    () {
                      Navigator.pushNamed(context, Routes.activityCommentPage);
                    },
                  ),
                  menuItem(
                    Style.succesColor,
                    "Kayıtlarım",
                    Icons.receipt_long_rounded,
                    () {
                      Navigator.pushNamed(context, Routes.recordListPage);
                    },
                  ),
                  menuItem(
                    Colors.blueAccent,
                    "Düzenle",
                    Icons.receipt_long_rounded,
                    () => editPop(),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<AuthViewModel>(context, listen: false)
                        .signOut()
                        .then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.homePage, (route) => false);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 24),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Style.secondaryColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(
                        Style.defaultRadiusSize,
                      ),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Style.dangerColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Çıkış Yap",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            /* editIcon(context),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Style.defautlVerticalPadding / 2),
                  padding: EdgeInsets.all(100.r),
                  decoration: BoxDecoration(
                    boxShadow: [Style.defaultShadow],
                    color: Colors.white,
                    // border: Border.all(
                    //   width: 1,
                    //   color: Style.secondaryColor.withOpacity(0.4),
                    // ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${userModel.name?[0] ?? ''} ${userModel.surname?[0] ?? ''}',
                    style: TextStyle(
                      fontSize: Style.bigTitleTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding / 4),
                  child: Text(
                    '${userModel.name ?? ''} ${userModel.surname ?? ''}',
                    style: TextStyle(
                      fontSize: 56.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: Style.defaultPadding / 2,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Table(
                    columnWidths: const {
                      0: MinColumnWidth(FractionColumnWidth(1), IntrinsicColumnWidth()),
                      1: MinColumnWidth(FractionColumnWidth(1), IntrinsicColumnWidth()),
                      2: MinColumnWidth(FractionColumnWidth(1), IntrinsicColumnWidth()),
                    },
                    children: [
                      TableRow(children: [
                        Icon(
                          Icons.mail_outline_rounded,
                          size: 40.r,
                        ),
                        const SizedBox(
                          width: Style.defaultPadding / 2,
                        ),
                        Align(alignment: Alignment.center, child: Text(userModel.email ?? '')),
                      ]),
                      const TableRow(children: [
                        SizedBox(
                          height: Style.defaultPadding / 2,
                        ),
                        SizedBox(
                          height: Style.defaultPadding / 2,
                        ),
                        SizedBox(
                          height: Style.defaultPadding / 2,
                        ),
                      ]),
                      TableRow(children: [
                        Icon(
                          Icons.phone_android_outlined,
                          size: 40.r,
                        ),
                        const SizedBox(
                          width: Style.defaultPadding / 2,
                        ),
                        Align(alignment: Alignment.center, child: Text(userModel.phone ?? '')),
                      ]),
                    ],
                  ),
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Style.defautlVerticalPadding),
                  child: Text(
                    userModel.about ?? '',
                    style: TextStyle(
                      fontSize: 44.sp,
                      color: Style.textColor.withOpacity(0.6),
                    ),
                  ),
                ),
                profileMenuItem(
                  () {
                    Navigator.pushNamed(context, Routes.blogCommentPage);
                  },
                  "Blog Yorumlarım",
                  "${blogCommentNumber!} Yorum",
                ),
                profileMenuItem(
                  () {
                    Navigator.pushNamed(context, Routes.activityCommentPage);
                  },
                  "Etkinlik Yorumlarım",
                  "${activityCommentNumber!} Yorum",
                ),
                profileMenuItem(
                  () {
                    Navigator.pushNamed(context, Routes.recordListPage);
                  },
                  "Kayıtlarım",
                  '${recordNumber!} Kayıt',
                ),
              ],
            ), */
          ],
        ),
      ),
    );
  }

  Widget menuItem(
    Color color,
    String title,
    IconData icon,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(
                  Style.defaultRadiusSize * 2,
                ),
              ),
              child: const Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileMenuItem(void Function()? onTap, String title, String content) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200.h,
        margin: EdgeInsets.only(
          bottom: Style.defautlVerticalPadding / 4,
          top: Style.defautlVerticalPadding / 2,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Style.defautlVerticalPadding / 2,
          horizontal: Style.defautlHorizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          boxShadow: [Style.defaultShadow],
          color: Colors.white,
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Style.defaultTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(content),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Style.textColor.withOpacity(0.6),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget editIcon(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => editPop(),
          child: Container(
            padding: EdgeInsets.all(32.r),
            decoration: BoxDecoration(
              boxShadow: [Style.defaultShadow],
              color: Colors.white,
              // border: Border.all(
              //   width: 1,
              //   color: Style.secondaryColor.withOpacity(0.4),
              // ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }

  Future editPop() {
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
      builder: (context1) {
        return FutureBuilder<Map<String, dynamic>?>(
            future: editData == null ? _fetchEditData() : null,
            builder: (context, snapshot) {
              if (editData != null) {
                Map<String, dynamic> userData = snapshot.data!['data'];
                var columns = (snapshot.data!['columns'] as Map).map(
                    (key, value) =>
                        MapEntry(key as String, table.Column.fromJson(value)));
                return SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Style.defautlVerticalPadding,
                        horizontal: Style.defautlHorizontalPadding,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Style.defautlVerticalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Profil Güncelleme",
                                  style: TextStyle(
                                    fontSize: Style.bigTitleTextSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(Icons.close),
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: columns.length,
                              itemBuilder: (context, index) {
                                var column = columns.values.toList()[index];
                                return CustomTextField(
                                  hintText: column.display!,
                                  initialValue: userData[column.name],
                                  onChanged: (value) {
                                    if (value == null) {
                                      updateData.remove(column.name);
                                    } else {
                                      updateData[column.name!] = value;
                                    }
                                  },
                                );
                              }),
                          // CustomTextField(hintText: "İsim Soyisim"),
                          // CustomTextField(hintText: "Mail Adresi"),
                          // CustomTextField(hintText: "Telefon Numarası"),
                          // CustomTextField(hintText: "Şehir"),
                          // CustomTextField(hintText: "Meslek"),
                          // CustomTextField(hintText: "Hakkımda"),
                          // CustomTextField(hintText: "Şifre"),
                          // CustomTextField(hintText: "Şifre Tekrar"),
                          ButtonForLogin(title: "Güncelle", onTap: _updateData),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError && snapshot.error != null) {
                HandleExceptions.handle(
                    exception: snapshot.error, context: context);
              }
              return const LoadingWidget();
            });
      },
    ).then((value) => editData = null);
  }

  Future _fetchUserInfo() async {
    try {
      userModel = await Provider.of<AuthViewModel>(context, listen: false)
          .getUserInfoFromLocale();
      if (!mounted) return;
      blogCommentNumber =
          await Provider.of<TableViewModel>(context, listen: false)
              .fetchTableCount(
                  tableName: TableName.BlogComment.name,
                  filter: {'own_id': userModel!.id});
      if (!mounted) return;
      activityCommentNumber =
          await Provider.of<TableViewModel>(context, listen: false)
              .fetchTableCount(
                  tableName: TableName.ActivityComment.name,
                  filter: {'own_id': userModel!.id});
      if (!mounted) return;
      recordNumber = await Provider.of<TableViewModel>(context, listen: false)
          .fetchTableCount(
              tableName: TableName.ActivityRecord.name,
              filter: {'own_id': userModel!.id});
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }

  Future<Map<String, dynamic>?> _fetchEditData() async {
    try {
      editData = await Provider.of<TableViewModel>(context, listen: false)
          .tableEdit(
              tableName: TableName.users.name,
              id: int.parse(userModel!.id!),
              isUserDb: true);
      return editData!;
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
    return null;
  }

  _updateData() async {
    try {
      Provider.of<TableViewModel>(context, listen: false)
          .tableUpdate(
              tableName: TableName.users.name,
              data: updateData,
              id: int.parse(userModel!.id!),
              isUserDb: true)
          .then((value) {
        Provider.of<AuthViewModel>(context, listen: false)
            .syncLocaleUserInfo()
            .then((value) {
          Navigator.pop(context);
          setState(() {});
        });
      });
    } catch (e) {
      HandleExceptions.handle(exception: e, context: context);
    }
  }
}
