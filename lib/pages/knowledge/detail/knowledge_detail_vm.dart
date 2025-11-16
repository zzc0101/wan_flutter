import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter/repository/api.dart';
import 'package:wan_flutter/repository/datas/knowledge_detail_list_data.dart';
import 'package:wan_flutter/repository/datas/konwledge_list.dart';

class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab> tabs = [];
  List<KnowledgeDetailItemData> detailList = [];
  int _pageCount = 0;

  void initTabs(List<KnowledgeChildren>? tabList) {
    tabList?.forEach((element) {
      tabs.add(Tab(text: element.name ?? ""));
    });
  }

  Future getDetailList(String? cid, bool loadMore) async {
    if (loadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      detailList?.clear();
    }
    var list = await Api.instance.detailKnowledgeList("$_pageCount", cid);
    if (list?.isNotEmpty == true) {
      detailList?.addAll(list ?? []);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }
}
