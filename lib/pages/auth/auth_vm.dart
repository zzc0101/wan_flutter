import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:wan_flutter/constants.dart';
import 'package:wan_flutter/repository/api.dart';
import 'package:wan_flutter/repository/datas/auth_data.dart';
import 'package:wan_flutter/utils/sp_utils.dart';

class AuthViewModel with ChangeNotifier {
  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  /// 注册
  Future<dynamic> register() async {
    if (registerInfo.name != null &&
        registerInfo.password != null &&
        registerInfo.rePassword != null &&
        registerInfo.password == registerInfo.rePassword) {
      if ((registerInfo.password?.length ?? 0) >= 6) {
        dynamic callback = await Api.instance.register(
          name: registerInfo.name,
          password: registerInfo.password,
          rePassword: registerInfo.rePassword,
        );
        if (callback is bool) {
          return callback;
        } else {
          return true;
        }
      }
      showToast("密码长度必须大于6位");
      return false;
    }
    showToast("输入不能为空或者密码必须一致");
    return false;
  }

  /// 登录
  Future<bool?> login() async {
    if (loginInfo.name != null && loginInfo.password != null) {
      AuthData data = await Api.instance.login(
        name: loginInfo.name,
        password: loginInfo.password,
      );
      if (data.username != null && data.username?.isNotEmpty == true) {
        // 保存用户名
        SpUtils.saveString(Constants.SP_User_Name, data.username ?? "");
        return true;
      }
      showToast("登录失败");
      return false;
    }
    showToast("输入不能为空");
    return false;
  }

  void setLoginInfo({String? username, String? password}) {
    if (username != null) {
      loginInfo.name = username;
    }

    if (password != null) {
      loginInfo.password = password;
    }
  }
}

class RegisterInfo {
  String? name;
  String? password;
  String? rePassword;
}

class LoginInfo {
  String? name;
  String? password;
}
