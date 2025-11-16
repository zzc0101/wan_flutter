import 'package:dio/dio.dart';
import 'package:wan_flutter/http/dio_instance.dart';
import 'package:wan_flutter/repository/datas/app_check_update_model.dart';
import 'package:wan_flutter/repository/datas/auth_data.dart';
import 'package:wan_flutter/repository/datas/common_website_data.dart';
import 'package:wan_flutter/repository/datas/home_banner_data.dart';
import 'package:wan_flutter/repository/datas/home_list_data.dart';
import 'package:wan_flutter/repository/datas/knowledge_detail_list_data.dart';
import 'package:wan_flutter/repository/datas/konwledge_list.dart';
import 'package:wan_flutter/repository/datas/my_collects_model.dart';
import 'package:wan_flutter/repository/datas/search_data.dart';
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

  // 获取体系数据
  Future<List<KnowledgeListData?>> knowledgeList() async {
    Response response = await DioInstance.instance().get(path: "tree/json");
    KnowledgeData knowledgeData = KnowledgeData.fromJson(response.data);
    return knowledgeData.list;
  }

  // 获取收藏数据
  Future<bool?> collect(String? id) async {
    Response response = await DioInstance.instance().post(
      path: "lg/collect/${id}/json",
    );
    if (response.data != null && response.data is bool) {
      return response.data;
    }
    return true;
  }

  // 取消收藏
  Future<bool?> unCollect(String? id) async {
    Response response = await DioInstance.instance().post(
      path: "lg/uncollect_originId/${id}/json",
    );
    return boolCallback(response.data);
  }

  // 退出登录
  Future<bool?> logout() async {
    Response response = await DioInstance.instance().get(
      path: "user/logout/json",
    );
    return true;
  }

  // 知识体系明细数据
  Future<List<KnowledgeDetailItemData>?> detailKnowledgeList(
    String? pageCount,
    String? cid,
  ) async {
    Response response = await DioInstance.instance().get(
      path: "article/list/$pageCount/json",
      param: {"cid": cid},
    );
    var knowledgeDetailData = KnowledgeDetailListData.fromJson(response.data);
    return knowledgeDetailData.datas;
  }

  // 搜索数据
  Future<List<SearchListData>?> searchList(String? keyword) async {
    Response response = await DioInstance.instance().post(
      path: "article/query/0/json",
      queryParameters: {"k": keyword},
    );
    var searchData = SearchData.fromJson(response.data);
    return searchData.datas;
  }

  // 获取我的收藏列表
  Future<List<MyCollectItemModel>?> getMyCollects(String pageCount) async {
    Response response = await DioInstance.instance().get(
      path: "lg/collect/list/$pageCount/json",
    );
    MyCollectsModel? model = MyCollectsModel.fromJson(response.data);
    if (model.datas != null && model.datas?.isNotEmpty == true) {
      return model.datas;
    }
    return [];
  }

  // 取消收藏
  Future<bool> cancelCollect(String id) async {
    Response response = await DioInstance.instance().post(
      path: "lg/uncollect_originId/$id/json",
    );
    if (response.data != null && response.data == true) {
      return true;
    } else {
      return false;
    }
  }

  // 检查APP新版本
  Future<AppCheckUpdateModel?> checkUpdate() async {
    DioInstance.instance().changeBaseUrl("分发接口");
    Response response = await DioInstance.instance().post(path: "");
    DioInstance.instance().changeBaseUrl("平台接口");
    return AppCheckUpdateModel.fromJson(response.data);
  }

  bool? boolCallback(dynamic data) {
    if (data != null && data is bool) {
      return data;
    }
    return false;
  }
}
