import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/repository/api.dart';
import 'package:wan_flutter/repository/datas/search_data.dart';

class SearchViewModel with ChangeNotifier {

  List<SearchListData>? searchList;

  Future search(String? keyword) async {
    searchList = await Api.instance.searchList(keyword);
    notifyListeners();
  }

  void clear() async {
    searchList?.clear();
    notifyListeners();
  }
}