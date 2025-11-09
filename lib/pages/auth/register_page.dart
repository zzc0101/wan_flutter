import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter/common_ui/common_style.dart';
import 'package:wan_flutter/pages/auth/auth_vm.dart';
import 'package:wan_flutter/route/route_utils.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  String? input;

  AuthViewModel viewModel = AuthViewModel();

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
        child: Consumer<AuthViewModel>(
          builder: (context, vm, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                commonInput(
                  labelText: "输入账号",
                  onChanged: (value) {
                    vm.registerInfo.name = value;
                  },
                ),
                SizedBox(height: 20.h),
                commonInput(
                  labelText: "输入密码",
                  obscureText: true,
                  onChanged: (value) {
                    vm.registerInfo.password = value;
                  },
                ),
                SizedBox(height: 20.h),
                commonInput(
                  labelText: "再次输入密码",
                  obscureText: true,
                  onChanged: (value) {
                    vm.registerInfo.rePassword = value;
                  },
                ),
                SizedBox(height: 50.h),
                whiteBorderButton(
                  title: "点我开始注册",
                  onTap: () {
                    viewModel.register().then((value) {
                      if (value == true) {
                        showToast("注册成功");
                        RouteUtils.pop(context);
                      }
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
