import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wan_flutter/common_ui/common_style.dart';
import 'package:wan_flutter/pages/auth/login_page.dart';
import 'package:wan_flutter/route/route_utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
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
            SizedBox(height: 20.h),
            commonInput(labelText: "再次输入密码"),
            SizedBox(height: 50.h),
            whiteBorderButton(
              title: "点我开始注册",
              onTap: () {
                RouteUtils.push(context, LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
