import 'package:flutter/cupertino.dart';
import 'package:wan_flutter/repository/api.dart';
import 'package:wan_flutter/repository/datas/konwledge_list.dart';

class KnowledgeViewModel with ChangeNotifier {
  List<KnowledgeListData?>? list;

  Future knowledgeList() async {
    list = await Api.instance.knowledgeList();
    notifyListeners();
  }

  String generalSybTitle(List<KnowledgeChildren?>? children) {
    if (children == null || children.isEmpty == true) {
      return "";
    }
    StringBuffer stringBuffer = StringBuffer("");
    for (var element in children) {
      stringBuffer.write("${element?.name}");
    }
    return stringBuffer.toString();
  }
}
