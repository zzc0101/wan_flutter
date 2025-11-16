import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wan_flutter/constants.dart';
import 'package:wan_flutter/repository/api.dart';
import 'package:wan_flutter/utils/sp_utils.dart';

class PersonViewModel with ChangeNotifier {
  String? username;
  bool shouldLogin = false;

  Future initData() async {
    SpUtils.getString(Constants.SP_User_Name).then((value) {
      if (value == null || value == '') {
        username = '未登录';
        shouldLogin = true;
      } else {
        username = value;
        shouldLogin = false;
      }
      notifyListeners();
    });
  }

  // 退出登录
  Future logout(ValueChanged<bool> callback) async {
    bool? success = await Api.instance.logout();
    if (success == true) {
      await SpUtils.removeAll();
      callback.call(true);
    } else {
      callback.call(false);
    }
  }
}
