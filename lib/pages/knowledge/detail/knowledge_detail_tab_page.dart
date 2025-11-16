import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter/pages/knowledge/detail/knowledge_detail_vm.dart';
import 'package:wan_flutter/pages/knowledge/detail/knowledge_tab_child_page.dart';
import 'package:wan_flutter/repository/datas/konwledge_list.dart';

class KnowledgeDetailTabPage extends StatefulWidget {
  const KnowledgeDetailTabPage({super.key, this.tableList});

  final List<KnowledgeChildren>? tableList;

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeDetailTabPageState();
  }
}

class _KnowledgeDetailTabPageState extends State<KnowledgeDetailTabPage>
    with SingleTickerProviderStateMixin {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: widget.tableList?.length ?? 0, vsync: this);
    viewModel.initTabs(widget.tableList);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return viewModel;
        },
        child: Scaffold(
            appBar: AppBar(
                title: TabBar(
                    tabs: viewModel.tabs,
                    controller: tabController,
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    isScrollable: true)),
            body: SafeArea(
                child: TabBarView(
                  controller: tabController, children: children(),))));
  }

  List<Widget> children() {
    return widget.tableList?.map((e) {
      return KnowledgeTabChildPage(cid: "${e.id ?? ""}",);
    }).toList() ?? [];
  }
}
