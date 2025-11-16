import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:wan_flutter/pages/knowledge/knowledge_vm.dart';
import 'package:wan_flutter/repository/datas/konwledge_list.dart';
import 'package:wan_flutter/route/route_utils.dart';

class KnowledgePage extends StatefulWidget {
  @override
  State createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<KnowledgePage> {
  KnowledgeViewModel viewModel = KnowledgeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.knowledgeList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<KnowledgeViewModel>(
            builder: (context, vm, child) {
              return ListView.builder(
                itemCount: vm.list?.length ?? 0,
                itemBuilder: (context, index) {
                  _itemView(vm.list?[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _itemView(KnowledgeListData? item) {
    return GestureDetector(
      onTap: () {
        //  进入明细页面
        RouteUtils.push(
          context,
          KnowledgeDetailTabPage(tableList: item?.children),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 15.w,
          right: 15.w,
          top: 10.h,
          bottom: 10.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12), // 边框颜色
          borderRadius: BorderRadius.circular(5.r), // 边框圆角
        ),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w), // 外边距
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.name ?? "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(viewModel.generalSybTitle(item?.children)),
                ],
              ),
            ),
            Image.asset(
              "assets/images/img_arrow_right.png",
              height: 24.r,
              width: 24.r,
            ),
          ],
        ),
      ),
    );
  }
}
