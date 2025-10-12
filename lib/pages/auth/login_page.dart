import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_flutter/common_ui/common_style.dart';
import 'package:wan_flutter/pages/auth/register_page.dart';
import 'package:wan_flutter/route/route_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String? input;

  TextEditingController? inputController;

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Container(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonInput(labelText: "输入账号"),
            SizedBox(height: 20.h),
            commonInput(labelText: "输入密码"),
            SizedBox(height: 50.h),
            whiteBorderButton(title: "开始登录", onTap: () {}),
            SizedBox(height: 5.h),
            registerButton(() {
              RouteUtils.push(context, RegisterPage());
            }),
          ],
        ),
      ),
    );
  }
}
