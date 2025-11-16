import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wan_flutter/repository/api.dart';
import 'package:wan_flutter/repository/datas/home_banner_data.dart';
import 'package:wan_flutter/repository/datas/home_list_data.dart';

class HomeViewModel with ChangeNotifier {
  int pageCount = 1;
  List<HomeBannerData?>? bannerList;
  List<HomeListItemData>? listData = [];
  Dio dio = Dio();

  // async 表示当前函数为异步
  /// 获取首页 Banner 数据
  Future getBanner() async {
    List<HomeBannerData?>? list = await Api.instance.getBanner();
    bannerList = list ?? [];
    notifyListeners();
  }

  Future initListData(bool loadMore, {ValueChanged<bool>? callback}) async {
    if (loadMore) {
      pageCount++;
    } else {
      pageCount = 1;
      listData?.clear();
    }
    // 先获取置顶数据
    getTopList(loadMore).then((topList) {
      if (!loadMore) {
        listData?.addAll(topList ?? []);
      }

      // 再获取首页列表
      getHomeList(loadMore).then((allList) {
        listData?.addAll(allList ?? []);
        // 刷新
        notifyListeners();

        // 回调出去
        callback?.call(loadMore);
      });
    });
  }

  /// 获取首页文章列表
  Future getHomeList(bool loadMore) async {
    List<HomeListItemData>? list = await Api.instance.getHomeList("$pageCount");
    if (list != null && list.isNotEmpty) {
      return list;
    } else {
      if (loadMore && pageCount > 0) {
        pageCount--;
      }
      return [];
    }
  }

  /// 获取首页置顶数据
  Future<List<HomeListItemData>?> getTopList(bool loadMore) async {
    if (loadMore) {
      return [];
    }
    List<HomeListItemData>? list = await Api.instance.getHomeTopList();
    return list;
  }

  Future collect(bool isCollect, String? id, int index) async {
    bool? success;
    if(isCollect) {
      success = await Api.instance.collect(id);
    } else {
      success = await Api.instance.unCollect(id);
    }
    if(success == true) {
      listData?[index].collect = isCollect;
      notifyListeners();
    }
  }
}
