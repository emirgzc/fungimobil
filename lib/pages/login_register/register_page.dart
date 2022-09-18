import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fungimobil/constants/handle_exceptions.dart';
import 'package:fungimobil/constants/routes.dart';
import 'package:fungimobil/constants/table_util.dart';
import 'package:fungimobil/model/table_model.dart' as table;
import 'package:fungimobil/pages/login_register/components/big_title.dart';
import 'package:fungimobil/pages/login_register/components/button_login.dart';
import 'package:fungimobil/pages/login_register/components/desc_title.dart';
import 'package:fungimobil/viewmodel/auth_viewmodel.dart';
import 'package:fungimobil/viewmodel/table_view_model.dart';
import 'package:fungimobil/widgets/custom_text_field.dart';
import 'package:fungimobil/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final Map<String, dynamic> data;
  Map<String, table.Column>? createData;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    data = {};
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        createData = await Provider.of<TableViewModel>(context, listen: false).tableCreate(tableName: TableName.users.name, isUserDb: true);
        setState(() {});
      } catch (e) {
        HandleExceptions.handle(exception: e, context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var status = Provider.of<AuthViewModel>(context).status;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        body: createData == null ? const LoadingWidget() : Stack(
          children: [
            buildRegisterPage(),
            if(status == AuthVMStatus.busy) const LoadingWidget(),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterPage() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 80.w,
            right: 80.w,
            top: 216.h,
          ),
          child: Center(
            child: Column(
              children: [
                BigTitle(title: "Kayıt Sayfası", size: 80.sp),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 48.h),
                  child: DescTitle(
                    title: "Fungi Turkey mobil uygulamasına kayıt olmak için aşağıdaki formu doldurunuz.",
                    size: 56.sp,
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: createData!.length,
                    itemBuilder: (context, index) {
                      var column = createData!.values.toList()[index];
                      return CustomTextField(
                        hintText: column.display!,
                        onChanged: (value) {
                          if (value == null) {
                            data.remove(column.name);
                          } else {
                            data[column.name!] = value;
                          }
                        },
                      );
                    }),
                // CustomTextField(hintText: "İsim Soyisim",),
                // CustomTextField(hintText: "Mail Adresi"),
                // CustomTextField(hintText: "Telefon Numarası"),
                // CustomTextField(hintText: "Şehir"),
                // CustomTextField(hintText: "Meslek"),
                // CustomTextField(hintText: "Şifre"),
                // CustomTextField(hintText: "Şifre Tekrar"),
                ButtonForLogin(title: "Kayıt Ol", onTap: _register),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _register() {
    if (data.isNotEmpty && _formKey.currentState!.validate()) {
      try {
        Provider.of<AuthViewModel>(context, listen: false).register(data).then((value) => _navigateLogin());
      } catch (e) {
        HandleExceptions.handle(exception: e, context: context);
      }
    }
  }

  _navigateLogin() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.loginPage, (route) => false,);
  }
}
