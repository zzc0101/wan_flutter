import 'package:dio/dio.dart';
import 'package:wan_flutter/http/dio_instance.dart';
import 'package:wan_flutter/repository/datas/auth_data.dart';
import 'package:wan_flutter/repository/datas/common_website_data.dart';
import 'package:wan_flutter/repository/datas/home_banner_data.dart';
import 'package:wan_flutter/repository/datas/home_list_data.dart';
import 'package:wan_flutter/repository/datas/search_hot_keys_data.dart';

class Api {
  static Api instance = Api._();

  Api._();

  // async 表示当前函数为异步
  /// 获取首页 Banner 数据
  Future<List<HomeBannerData?>?> getBanner() async {
    Response response = await DioInstance.instance().get(path: 'banner/json');
    HomeBannerListData bannerData = HomeBannerListData.fromJson(response.data);
    return bannerData.bannerList;
  }

  /// 获取首页文章列表
  Future<List<HomeListItemData>?> getHomeList(String pageCount) async {
    Response response = await DioInstance.instance().get(
      path: 'article/list/$pageCount/json',
    );
    HomeListData homeData = HomeListData.fromJson(response.data);
    return homeData.datas;
  }

  /// 获取首页置顶数据
  Future<List<HomeListItemData>?> getHomeTopList() async {
    Response response = await DioInstance.instance().get(
      path: 'article/top/json',
    );
    HomeTopListData homeTopData = HomeTopListData.fromJson(response.data);
    return homeTopData.topList;
  }

  /// 获取常用网站
  Future<List<CommonWebsiteData>?> getWebsiteList() async {
    Response response = await DioInstance.instance().get(path: 'friend/json');
    CommonWebsiteListData commonWebsiteListData =
        CommonWebsiteListData.fromJson(response.data);
    return commonWebsiteListData.websiteList;
  }

  /// 获取搜素热点
  Future<List<SearchHotKeysData>?> getSearchHotKeys() async {
    Response response = await DioInstance.instance().get(path: 'hotkey/json');
    SearchHotKeysListData searchHotKeysListData =
        SearchHotKeysListData.fromJson(response.data);
    return searchHotKeysListData.keyList;
  }

  /// 注册
  Future<dynamic> register({
    String? name,
    String? password,
    String? rePassword,
  }) async {
    Response response = await DioInstance.instance().post(
      path: 'user/register',
      queryParameters: {
        "username": name,
        "password": password,
        "repassword": rePassword,
      },
    );
    return response.data;
  }

  /// 登录
  Future<AuthData> login({String? name, String? password}) async {
    Response response = await DioInstance.instance().post(
      path: 'user/login',
      queryParameters: {"username": name, "password": password},
    );
    return AuthData.fromJson(response.data);
  }
}
