import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:wan_flutter/common_ui/loading.dart';
import 'package:wan_flutter/common_ui/smart_refresh/smart_refresh_widget.dart';
import 'package:wan_flutter/common_ui/web/webview_page.dart';
import 'package:wan_flutter/common_ui/web/webview_widget.dart';
import 'package:wan_flutter/pages/home/home_vm.dart';
import 'package:wan_flutter/repository/datas/home_list_data.dart';
import 'package:wan_flutter/route/route_utils.dart';
import 'package:wan_flutter/route/routest.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeViewModel homeViewModel = HomeViewModel();
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    Loading.showLoading();
    homeViewModel.getBanner();
    refreshOrLoad(false);
  }

  void refreshOrLoad(bool loadMore) {
    homeViewModel.initListData(
      loadMore,
      callback: (loadMore) {
        if (loadMore) {
          refreshController.loadComplete();
        } else {
          refreshController.refreshCompleted();
        }
        Loading.dismissAll();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) {
        return homeViewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: SmartRefreshWidget(
            controller: refreshController,
            onLoading: () {
              // 上拉加载回调
              refreshOrLoad(true);
            },
            onRefresh: () {
              // 下拉刷新回调
              homeViewModel.getBanner().then((value) {
                refreshOrLoad(false);
              });
            },
            child: SingleChildScrollView(
              child: Column(children: [_banner(), _homeListView()]),
            ),
          ),
          // SingleChild 相当于整个页面滚动
        ),
      ),
    );
  }

  Widget _homeListView() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _listItemView(vm.listData?[index], index);
          },
          itemCount: vm.listData?.length ?? 0,
        );
      },
    );
  }

  Widget _banner() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return SizedBox(
          width: double.infinity,
          height: 150.h,
          child: Swiper(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  RouteUtils.push(
                    context,
                    WebViewPage(
                      loadResource: vm.bannerList?[index]?.url ?? "",
                      webViewType: WebViewType.URL,
                      showTitle: true,
                      title: vm.bannerList?[index]?.title,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.lightBlue,
                  child: Image.network(
                    vm.bannerList?[index]?.imagePath ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            itemCount: vm.bannerList?.length ?? 0,
            indicatorLayout: PageIndicatorLayout.NONE,
            autoplay: true,
            control: const SwiperControl(),
            // 左右控制
            pagination: const SwiperPagination(), // 底部滚动小圆点
          ),
        );
      },
    );
  }

  Widget _listItemView(HomeListItemData? item, int index) {
    // 点击事件有两种实现方式： 1、 GestureDetector 2、InkWell()
    return GestureDetector(
      onTap: () {
        // 使用工具类进行跳转
        // RouteUtils.push(context, WebViewPage(title: '首页跳转过来的'));
        // 跳转带入参数
        // RouteUtils.pushForNamed(
        //   context,
        //   RoutePath.webViewPage,
        //   arguments: {'name', '使用路由传值'},
        // );
        RouteUtils.push(
          context,
          WebViewPage(
            loadResource: item?.link ?? "",
            webViewType: WebViewType.URL,
            showTitle: true,
            title: item?.title,
          ),
        );
        // 路由跳转方式如下
        // Navigator.pushNamed(context, RoutePath.webViewPage);
        // 原始跳转方式如下
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return WebViewPage(title: '首页跳转测试',);
        // }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        padding: EdgeInsets.only(
          top: 5.h,
          bottom: 5.h,
          left: 10.w,
          right: 10.w,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.8.r),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    'https://img1.baa.bitautotech.com/dzusergroupfiles/2024/03/20/c104babcd38445e0bab39502edb67ebd.jpg',
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  item?.author?.isNotEmpty == true
                      ? item?.author ?? ''
                      : item?.shareUser ?? '',
                  style: TextStyle(color: Colors.black),
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Text(
                    item?.niceShareDate ?? '',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 5.w),
                (item?.type?.toInt() == 1)
                    ? Text(
                        '置顶',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            Text(
              item?.title ?? '',
              style: TextStyle(color: Colors.black, fontSize: 12.sp),
            ),
            Row(
              children: [
                Text(
                  item?.chapterName ?? '',
                  style: TextStyle(color: Colors.green, fontSize: 12.sp),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () {
                    var isCollect;
                    if (item?.collect == true) {
                      isCollect = false;
                    } else {
                      isCollect = true;
                    }
                    homeViewModel.collect(isCollect, "${item?.id}", index);
                  },
                  child: Image.asset(
                    item?.collect == true
                        ? 'assets/images/img_collect.png'
                        : 'assets/images/img_collect_grey.png',
                    width: 30.r,
                    height: 30.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
