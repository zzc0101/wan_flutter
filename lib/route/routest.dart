import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter/common_ui/web/webview_page.dart';
import 'package:wan_flutter/common_ui/web/webview_widget.dart';
import 'package:wan_flutter/pages/auth/login_page.dart';
import 'package:wan_flutter/pages/auth/register_page.dart';
import 'package:wan_flutter/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:wan_flutter/pages/search/search_page.dart';
import 'package:wan_flutter/pages/tab_page.dart';

// 路由管理类
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(WebViewPage(loadResource: "", webViewType: WebViewType.URL,), settings: settings);
      case RoutePath.loginPage:
        return pageRoute(LoginPage(), settings: settings);
      case RoutePath.registerPage:
        return pageRoute(RegisterPage(), settings: settings);
      case RoutePath.detailKnowledgePage:
        return pageRoute(KnowledgeDetailTabPage(), settings: settings);
      case RoutePath.searchPage:
        return pageRoute(SearchPage(), settings: settings);
    }
    return pageRoute(
      Scaffold(
        body: SafeArea(child: Center(child: Text("路由： ${settings.name} 不存在"))),
      ),
    );
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
      maintainState: maintainState ?? true,
      allowSnapshotting: allowSnapshotting ?? true,
    );
  }
}

// 路由地址
class RoutePath {
  // 首页
  static const String tab = "/";

  // 网页页面
  static const String webViewPage = "/web_view_page";

  // 登录页面
  static const String loginPage = "/login_page";

  // 注册页面
  static const String registerPage = "/register_page";

  // 知识详情页
  static const String detailKnowledgePage = "/detail_knowledge_page";

  // 搜索页
  static const String searchPage = "/search_page";
}
