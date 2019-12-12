import 'package:flutter/material.dart';

class RouteUtil {
  //栈移除上个view，打开新的view
  static void goReplaceView(BuildContext context, String name) {
    pushReplacementNamed(context, name);
  }

  //打开新的view
  static void goView(BuildContext context, String name) {
    pushNamed(context, name);
  }

  //关闭当前view
  static void closeView(BuildContext context) {
    Navigator.of(context).pop();
  }

  //关闭当前view,带参数返回
  static void closeParameterView(BuildContext context, Map map) {
    Navigator.of(context).pop(map);
  }

//回到主界面,销毁栈其他view
  // static void goMainView(BuildContext context) {
  //   pushNamedAndRemoveUntil(context);
  // }

//带参数跳转界面view
  static Future goParameter(
      BuildContext context, StatefulWidget statefulWidget) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return statefulWidget;
      }),
    );
  }

  static void pushNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushNamed(pageName);
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  // static void pushNamedAndRemoveUntil(BuildContext context) {
  //   Navigator.of(context).pushNamedAndRemoveUntil(
  //       PageConstance.MAIN_PAGE, ModalRoute.withName(PageConstance.MAIN_PAGE));
  // }
}
