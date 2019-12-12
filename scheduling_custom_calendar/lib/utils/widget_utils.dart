import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduling_custom_calendar/res/colors.dart';
import 'package:scheduling_custom_calendar/res/dimens.dart';
import 'package:scheduling_custom_calendar/utils/route_util.dart';
import 'package:scheduling_custom_calendar/utils/utils.dart';

import 'object_util.dart';


class WidgetUtils {
  static Widget getImageWidget(String name,
      {String format: 'png', BoxFit fit: BoxFit.fitWidth}) {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Utils.getImgPath(name, format: format)),
        fit: fit,
      ),
    ));
  }

  static Widget getImagewidth(String name,
      {String format: 'png', double width: 32.0, BoxFit fit: BoxFit.fitWidth}) {
    return Image.asset(
      Utils.getImgPath(name, format: format),
      width: width,
      fit: fit,
    );
  }

  static Widget getImageAsset(String name,
      {String format: 'png', double width: 32.0, double height: 32.0}) {
    return Image.asset(
      Utils.getImgPath(name, format: format),
      width: width,
      height: height,
    );
  }

  static Widget getImageAssetWidget(String name,
      {String format: 'png', double size: 32.0}) {
    return Image.asset(
      Utils.getImgPath(Utils.reTextNull(name), format: format),
      width: size,
      height: size,
    );
  }

  static Widget getTextColorView(String text, Color color, var size,
      {TextAlign textAlign: TextAlign.start,
      fontweight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
      maxline: 300}) {
    return Container(
      child: Text(
        Utils.reTextNull(text),
        softWrap: true,
        maxLines: maxline,
        overflow: overflow, // 显示不完，就在后面显示点点
        textAlign: textAlign,
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: size,
          color: color,
          fontWeight: fontweight,
        ),
      ),
    );
  }

  static Widget getTextListPageView(
    String text,
    Color color,
    var size, {
    TextAlign textAlign: TextAlign.start,
    fontweight: FontWeight.w400,
    int maxLines: 3,
  }) {
    return Text(
      Utils.reTextNull(text),
      softWrap: true,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: size,
        color: color,
        fontWeight: fontweight,
      ),
    );
  }

  static Widget getTextColorLineView(String text, Color color, var size) {
    return Container(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          // decoration: TextDecoration.none,
          fontSize: size,
          color: color,
        ),
      ),
    );
  }

  // static Widget getRichTextView(List<RichTextEntity> list) {
  //   return RichText(
  //       text: TextSpan(
  //     children: list.map((RichTextEntity entity) {
  //       return buildTextView(entity); //赋值后的Widget
  //     }).toList(),
  //   ));
  // }

  // static TextSpan buildTextView(RichTextEntity entity) {
  //   return TextSpan(
  //     text: entity.title,
  //     style: TextStyle(
  //       backgroundColor: entity.backgroundColor,
  //       color: entity.textColor,
  //       fontSize: entity.size,
  //       fontWeight: entity.fontweight,
  //     ),
  //   );
  // }

  static Widget getTextView(String text, var size) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
        ),
      ),
    );
  }

  static Widget getTextViewPading16(String text, var size) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
        ),
      ),
    );
  }

  static Widget drawDivider8() {
    return Container(
        alignment: FractionalOffset.center,
        padding: const EdgeInsets.only(top: 8),
        child: Divider(
          height: 1.0,
          color: Color(0xFFF5F5F5),
        ));
  }

  static Widget drawDivider(
      {Color color: Colours.gray_f5, double height: 1.0}) {
    return Container(
        alignment: FractionalOffset.center,
        child: Divider(
          height: height,
          color: color,
        ));
  }

  static Widget drawCodeDivider(
      {Color color: Colours.gray_f5,
      double height: 2.0,
      double width: double.infinity}) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget drawDividerMargin16({Color color: Colours.gray_f5}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        alignment: FractionalOffset.center,
        child: Divider(
          height: 1.0,
          color: color,
        ));
  }

  static Widget drawVerticalDivider(
      {Color color: Colours.gray_f5,
      double height: 50,
      double width: 1,
      FractionalOffset alignment: FractionalOffset.center}) {
    return Container(
      width: width,
      alignment: alignment,
      height: height,
      child: VerticalDivider(color: color),
    );
  }

  static Widget buildLoginProgress() {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colours.main_01),
    );
  }

  static Widget buildTextField(
      TextEditingController controller,
      TextInputType type,
      String text,
      List<TextInputFormatter> list,
      String iconData,
      {bool isSecrecy: false}) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
        alignment: Alignment.center,
        height: 60.0,
//        decoration: BoxDecoration(
//            color: Colors.transparent,
//            border: Border.all(color: Colours.main_01, width: 1.0),
//            borderRadius: BorderRadius.circular(12.0)),
        child: TextField(
          style: TextStyle(
            // backgroundColor:Colours.main_01,
            // color: Colours.main_01,
            fontSize: 16.0,
          ),
          controller: controller,
          obscureText: isSecrecy,

          keyboardType: type,
          cursorColor: Colours.main_01,
          decoration: InputDecoration(
//            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
            prefixIcon: WidgetUtils.getImageAssetWidget(iconData, size: 22),
            hintText: text,
            hintStyle: TextStyle(
              color: Colours.text_04,
            ),

            //  hint: text,

//            labelText: text,
//            labelStyle: TextStyle(fontSize: 13.0, color: Colours.main_01),
//            hintText: text,
          ),
          autofocus: false,
          inputFormatters: list,
          // onChanged: (str) => mProvide.username = str,
        ));
  }

  static Widget buildTextFieldName(
      TextEditingController controller,
      TextInputType type,
      String text,
      List<TextInputFormatter> list,
      String iconData,
      {Function codeCallback}) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
        alignment: Alignment.center,
        height: 60.0,
//        decoration: BoxDecoration(
//            color: Colors.transparent,
//            border: Border.all(color: Colours.main_01, width: 1.0),
//            borderRadius: BorderRadius.circular(12.0)),
        child: TextField(
          style: TextStyle(
            // backgroundColor:Colours.main_01,
            // color: Colours.main_01,
            fontSize: 16.0,
          ),
          controller: controller,
          keyboardType: type,
          cursorColor: Colours.main_01,
          onChanged: (name) {
            codeCallback(name);
          },
          decoration: InputDecoration(
//            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
            prefixIcon: WidgetUtils.getImageAssetWidget(iconData, size: 22),
            hintText: text,
            hintStyle: TextStyle(
              color: Colours.text_04,
            ),

            //  hint: text,

//            labelText: text,
//            labelStyle: TextStyle(fontSize: 13.0, color: Colours.main_01),
//            hintText: text,
          ),
          autofocus: false,
          inputFormatters: list,
          // onChanged: (str) => mProvide.username = str,
        ));
  }

  static Widget buildTextFieldTwo(TextEditingController controller,
      TextInputType type, String text, List<TextInputFormatter> list) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        height: 60.0,
//        decoration: BoxDecoration(
//            color: Colors.transparent,
//            border: Border.all(color: Colours.main_01, width: 1.0),
//            borderRadius: BorderRadius.circular(12.0)),
        child: TextField(
          style: TextStyle(
            fontSize: 16.0,
          ),
          controller: controller,
          keyboardType: type,
          cursorColor: Colours.main_01,
          decoration: InputDecoration(
//            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
            hintText: text,
          ),
          autofocus: false,
          inputFormatters: list,
          onChanged: (v) {},
        ));
  }

  static Widget buildTextFieldCode(
      TextEditingController controller,
      TextInputType type,
      String text,
      List<TextInputFormatter> list,
      String codeCountdownStr,
      Color colorStr,
      {Function codeCallback}) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        height: 50.0,
//        decoration: BoxDecoration(
//            color: Colors.transparent,
//            border: Border.all(color: Colours.main_01, width: 1.0),
//            borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                style: TextStyle(
                  fontSize: 16.0,
                ),
                controller: controller,
                keyboardType: type,
                cursorColor: Colours.main_01,

                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                  hintText: text,
                  hintStyle: TextStyle(
                    color: Colours.text_04,
                  ),
                ),
                autofocus: false,
                inputFormatters: list,
                // onChanged: (str) => mProvide.username = str,
              ),
              flex: 1,
            ),
            GestureDetector(
              onTap: (() {
                codeCallback(codeCountdownStr);
              }),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: getTextColorView(
                    codeCountdownStr, colorStr, Dimens.FONT_SIZE_16),
              ),
            ),
          ],
        ));
  }

  // static PreferredSizeWidget showAppar(BuildContext context, String title,
  //     {Color backgroundColor: Colours.main_01,
  //     Color leadingColor: Colors.white,
  //     Color textColor: Colors.white,
  //     double textSize: Dimens.FONT_SIZE_20,
  //     List<WidgetActionEntity> actionList,
  //     Function onTapCall,
  //     bool isHide: false}) {
  //   return AppBar(
  //     leading: IconButton(
  //       icon: Icon(
  //         Icons.arrow_back_ios,
  //         color: leadingColor,
  //         size: 16,
  //       ),
  //       onPressed: () {
  //         RouteUtil.closeView(context);
  //       },
  //     ),
  //     elevation: 0.0,
  //     backgroundColor: backgroundColor,
  //     title: WidgetUtils.getTextColorView(title, textColor, textSize),
  //     centerTitle: true,
  //     actions: ObjectUtil.isEmptyList(actionList)
  //         ? List()
  //         : actionList.map((WidgetActionEntity entity) {
  //             return _getAppbarView(entity,
  //                 onTapCall: onTapCall, isHide: isHide); //赋值后的Widget
  //           }).toList(),
  //   );
  // }

  // static PreferredSizeWidget showApparNotLeading(
  //     BuildContext context, String title,
  //     {Color backgroundColor: Colours.title_white,
  //     Color leadingColor: Colors.black,
  //     Color textColor: Colors.black,
  //     double textSize: Dimens.FONT_SIZE_20,
  //     bool isCenterTitle: true,
  //     bool isHide: false,
  //     fontweight: FontWeight.w400,
  //     List<WidgetActionEntity> actionList,
  //     Function onTapCall}) {
  //   return AppBar(
  //     // automaticallyImplyLeading: false,
  //     // leading:  IconButton(
  //     //     icon: Icon(
  //     //       Icons.arrow_back_ios,
  //     //       color: leadingColor,
  //     //       size: 16,
  //     //     ),
  //     //     onPressed: () {
  //     //       RouteUtil.closeView(context);
  //     //     },
  //     //   ),
  //     automaticallyImplyLeading: false,
  //     elevation: 0.0,
  //     backgroundColor: backgroundColor,
  //     title: WidgetUtils.getTextColorView(title, textColor, textSize,
  //         fontweight: fontweight),
  //     centerTitle: isCenterTitle,
  //     actions: ObjectUtil.isEmptyList(actionList)
  //         ? List()
  //         : actionList.map((WidgetActionEntity entity) {
  //             return _getAppbarView(entity,
  //                 onTapCall: onTapCall, isHide: isHide); //赋值后的Widget
  //           }).toList(),
  //   );
  // }

  // static Widget _getAppbarView(WidgetActionEntity entity,
  //     {Function onTapCall, bool isHide}) {
  //   return isHide
  //       ? Container()
  //       : Container(
  //           padding: const EdgeInsets.only(right: 16),
  //           alignment: FractionalOffset.center,
  //           child: GestureDetector(
  //             onTap: () {
  //               if (null == onTapCall) {
  //                 return;
  //               }
  //               onTapCall();
  //             },
  //             child: showActionView(entity),
  //           ));
  // }

  // static Widget showActionView(WidgetActionEntity entity) {
  //   Widget actionView;
  //   LogUtil.e(entity.actionType, tag: 'entity.......');
  //   if (ObjectUtil.isEmpty(entity.actionType)) {
  //     if (null != entity.iconData) {
  //       entity.actionType = 'icon';
  //     } else {
  //       entity.actionType = 'text';
  //     }
  //   }
  //   switch (entity.actionType) {
  //     case 'icon':
  //       actionView = Icon(
  //         entity.iconData,
  //         color: Colors.white,
  //         size: entity.size,
  //       );
  //       break;
  //     case 'image':
  //       actionView = Row(
  //         children: <Widget>[
  //           getImageAsset(entity.image),
  //           getTextColorView(
  //               entity.title, entity.actionColor, Dimens.FONT_SIZE_14),
  //         ],
  //       );
  //       break;
  //     case 'text':
  //       actionView = getTextColorView(
  //           entity.title, entity.actionColor, Dimens.FONT_SIZE_14);
  //       break;
  //     case 'image_and_text':
  //       break;
  //     default:
  //   }
  //   return actionView;
  // }

  static Widget showBoxBotton(String title,
      {Color boxColor: Colours.main_01,
      Color textColor: Colors.black,
      double textSize: Dimens.FONT_SIZE_16}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        decoration: BoxDecoration(
            border: Border.all(color: boxColor, width: 1.0),
            borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: WidgetUtils.getTextColorView(title, textColor, textSize),
        ));
  }

  static Widget buildScrollview(List<String> listPhoto,
      {double width: 64, double height: 64}) {
    return SingleChildScrollView(
      //滑动的方向 Axis.vertical为垂直方向滑动，Axis.horizontal 为水平方向
      scrollDirection: Axis.horizontal,
      //true 滑动到底部
      reverse: false,
      padding: EdgeInsets.all(0.0),
      //滑动到底部回弹效果
      physics: BouncingScrollPhysics(),
      child: Row(
        children: listPhoto.map((String path) {
          return buildGridView(path, width: width, height: height); //赋值后的Widget
        }).toList(),
      ),
    );
  }

  static Widget buildGridView(String path,
      {double width: 64, double height: 64}) {
    return Stack(
      alignment: const FractionalOffset(1, 0),
      children: <Widget>[
        Container(
            width: width,
            height: height,
            margin: const EdgeInsets.all(5.0),
            child: Material(
              borderRadius: BorderRadius.circular(0.0),
              shadowColor: Colors.blue.shade200,
              color: Colors.white,
              elevation: 0.0,
              child: FadeInImage.assetNetwork(
                image: path,
                placeholder: 'images/picture_loading.png' /* 指定gif */,
                fit: BoxFit.cover,
              ),
            )),
      ],
    );
  }

  static Widget itmeStyleView(String title, String content,
      {bool isShow: true,
      Color contentColor: Colours.text_2222,
      Color textColor: Colours.text_91,
      double verticalPadding: 12}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: verticalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            WidgetUtils.getTextColorView(title, textColor, Dimens.FONT_SIZE_16),
            Expanded(
              child: Padding(
                child: WidgetUtils.getTextColorView(
                    content, contentColor, Dimens.FONT_SIZE_16,
                    textAlign: TextAlign.end),
                padding: const EdgeInsets.only(left: 16),
              ),
            ),
            Offstage(
              offstage: isShow,
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ));
  }

  static Widget boxChangeBotton(String title, bool isSoild,
      {Color soildColor: Colors.transparent,
      Color boxColor: Colours.main_01,
      Color textColor: Colors.black,
      double textSize: Dimens.FONT_SIZE_13,
      Function onTapCall}) {
    return GestureDetector(
      onTap: (() {
        if (!isSoild) {
          isSoild = true;
        }
        if (null == onTapCall) {
          return;
        }
        onTapCall(isSoild);
      }),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          decoration: BoxDecoration(
              color: isSoild ? Colours.main_01 : Colors.transparent,
              border: Border.all(color: boxColor, width: 1.0),
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: WidgetUtils.getTextColorView(
                  title, isSoild ? Colors.white : Colours.main_01, textSize),
            ),
          )),
    );
  }

  static Widget boxChangeAutoBotton(String title, bool isSoild,
      {Color soildColor: Colors.transparent,
      Color boxColor: Colours.main_01,
      Color textColor: Colors.black,
      double textSize: Dimens.FONT_SIZE_13,
      Function onTapCall}) {
    return GestureDetector(
      onTap: (() {
        if (isSoild) {
          isSoild = false;
        } else {
          isSoild = true;
        }
        if (null == onTapCall) {
          return;
        }
        onTapCall(isSoild);
      }),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          decoration: BoxDecoration(
              color: isSoild ? Colours.main_01 : Colours.gray_f0,
              border: Border.all(
                  color: isSoild ? boxColor : Colours.gray_f0, width: 1.0),
              borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: WidgetUtils.getTextColorView(
                  title, isSoild ? Colors.white : Colours.text_03, textSize),
            ),
          )),
    );
  }

  static Widget lineView() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colours.gray_f0,
          border: Border.all(color: Colours.gray_f0, width: 4.0),
          borderRadius: BorderRadius.horizontal(),
        ));
  }

  static Widget showItmeView(String title, String content,
      {String iocn: 'picture_loading',
      bool isShow: true,
      Color contentColor: Colours.text_01,
      double contentSize: Dimens.FONT_SIZE_16,
      double parmSize: Dimens.FONT_SIZE_16,
      Color parmColor: Colours.main_01,
      bool isHide: false}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            WidgetUtils.getImageAssetWidget(iocn),
            Padding(
                padding: const EdgeInsets.only(left: 16),
                child: WidgetUtils.getTextColorView(
                    title, contentColor, contentSize)),
            Expanded(
              child: Container(),
            ),
            WidgetUtils.getTextColorView(content, parmColor, parmSize),
            !isHide
                ? WidgetUtils.getImageAssetWidget('system_moreb')
                : Container(
                    width: 24,
                  ),
          ],
        ));
  }

  static Widget showTextField(
      {int maxLines: 3,
      // int minLines: 3,
      int maxLength: 200,
      double hintSize: Dimens.FONT_SIZE_14,
      String hintText: '',
      Color focusedBorderColor: Colours.main_01}) {
    return TextField(
      maxLength: maxLength,
      maxLines: maxLines,
      // minLines: minLines,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          /*边角*/
//                borderRadius: BorderRadius.all(
//                  Radius.circular(30), //边角为30
//                ),
          borderSide: BorderSide(
            color: Colors.transparent, //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: focusedBorderColor, //边框颜色为绿色
          width: 3, //宽度为5
        )),
        // errorText: "errorText",

        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintSize,
        ),
      ),
    );
  }

  static Widget showResultTextField(TextEditingController controller,
      {int minLines: 3,
      int maxLines: 10,
      int maxLength: 200,
      String hintText: '',
      double hintSize: Dimens.FONT_SIZE_14,
      Color focusedBorderColor: Colors.transparent}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      minLines: minLines,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          /*边角*/
//                borderRadius: BorderRadius.all(
//                  Radius.circular(30), //边角为30
//                ),
          borderSide: BorderSide(
            color: Colors.transparent, //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: focusedBorderColor, //边框颜色为绿色
          width: 3, //宽度为5
        )),
        // errorText: "errorText",
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: hintSize,
        ),
      ),
    );
  }

//画圆
  static Widget clipRRect(
      {double circular: 50,
      double width: 18,
      double height: 18,
      Color color: Colours.yanqi_red,
      String text}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: Container(
        // decoration: ShapeDecoration(
        //   color: color,
        //   // 统一四边颜色和宽度
        //   shape: Border.all(
        //       color: Color(0xFF00FFFF), style: BorderStyle.solid, width: 1),
        // ),
        alignment: FractionalOffset.center,
        width: width,
        height: height,
        color: color,
        child: getTextColorView(text, Colors.white, Dimens.FONT_SIZE_10),
      ),
    );
  }

  //画圆
  static Widget clipRRectShape({
    double circular: 50,
    double width1: 20,
    double height1: 20,
    Color color1: Colours.clipRRect_vertical,
    double width2: 17,
    double height2: 17,
    Color color2: Colours.clipRRect_xujian,
    bool isHide: true,
  }) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: isHide,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(circular),
            child: Container(
              width: width1,
              height: height1,
              color: color1,
            ),
          ),
        ),
        Offstage(
          offstage: !isHide,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(circular),
            child: Container(
              color: color2,
              width: width2,
              height: height2,
            ),
          ),
        ),
        Positioned(
          left: 2,
          top: 2,
          right: 2,
          bottom: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(circular),
            child: Container(
              decoration: BoxDecoration(
                  color: color2,
                  gradient: RadialGradient(colors: [
                    Colours.clipRRect_xujian,
                    Colours.clipRRect_xujian,
                    Colours.clipRRect_vertical
                  ], radius: 1, tileMode: TileMode.mirror)),
            ),
          ),
        ),
      ],
    );
  }

//圆形图片
  static Widget clipRRectNetWorkImage(
    String path, {
    double circular: 50,
    double width: 18,
    double height: 18,
    Color color: Colors.red,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: Container(
        alignment: FractionalOffset.center,
        width: width,
        height: height,
        color: color,
        child: Center(
            child: FadeInImage.assetNetwork(
          image: path,
          placeholder: 'images/picture_loading.png' /* 指定gif */,
        )),
      ),
    );
  }

  // static Widget showEditText(WidgetEntity widgetEntity) {
  //   TextInputType inputType = BaseConstant.textInputTypeAll;
  //   switch (widgetEntity.inputType) {
  //     case 'all':
  //     case 'none':
  //       inputType = BaseConstant.textInputTypeAll;
  //       break;
  //     case 'number':
  //       inputType = BaseConstant.textInputTypeNumber;
  //       break;
  //   }
  //   return Container(
  //     padding: const EdgeInsets.only(top: 2, bottom: 2),
  //     color: Colors.white,
  //     child: Column(
  //       children: <Widget>[
  //         Row(
  //           children: <Widget>[
  //             Expanded(
  //               child: Container(
  //                 padding: const EdgeInsets.only(left: 16),
  //                 alignment: FractionalOffset.centerLeft,
  //                 child: getTextColorView(
  //                     widgetEntity.title, Colors.black, Dimens.FONT_SIZE_16),
  //               ),
  //               flex: 1,
  //             ),
  //             Expanded(
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 8),
  //                 child: showTextFieldMx(widgetEntity.hitTitle, inputType,
  //                     widgetEntity.controller),
  //               ),
  //               flex: 2,
  //             ),
  //           ],
  //         ),
  //         drawDivider(),
  //       ],
  //     ),
  //   );
  // }

  // static Widget showTextFieldMx(
  //     String hitTitle, TextInputType type, TextEditingController controller) {
  //   return TextField(
  //     keyboardType: type,
  //     inputFormatters: (type == BaseConstant.textInputTypeAll)
  //         ? [BaseConstant.inputTypeAll]
  //         : [BaseConstant.inputTypeFolat],
  //     controller: controller,
  //     decoration: InputDecoration(
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(
  //           color: Colors.white, //边线颜色为黄色
  //           width: 1, //边线宽度为2
  //         ),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //         color: Colors.white, //边框颜色为绿色
  //         width: 3, //宽度为5
  //       )),
  //       contentPadding: EdgeInsets.all(10.0),
  //       hintText: hitTitle,
  //     ),
  //     autofocus: false,
  //   );
  // }

  static Widget showBaseInfoView(String title) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          color: Colours.gray_f0,
          alignment: FractionalOffset(0, 0),
          child: getTextColorView(title, Colours.text_91, Dimens.FONT_SIZE_13),
        ),
      ],
    );
  }

  // static WidgetEntity initEditText(String title, String content,
  //     String hitTitle, String inoutType, TextEditingController controller) {
  //   WidgetEntity widgetEntity = WidgetEntity();
  //   widgetEntity.title = title;
  //   widgetEntity.editTextContent = content;
  //   widgetEntity.hitTitle = hitTitle;
  //   widgetEntity.inputType = inoutType;
  //   widgetEntity.controller = controller;
  //   controller.text = content;
  //   widgetEntity.type = 'EditText';
  //   widgetEntity.fristValue = Utils.reTextNull(content);
  //   return widgetEntity;
  // }

  static Widget imageGallers(String title, List<String> list) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          WidgetUtils.getTextColorView(
              title, Colours.text_91, Dimens.FONT_SIZE_16),
          Expanded(
            child: Container(
              alignment: FractionalOffset(1, 0),
              padding: const EdgeInsets.only(left: 16),
              child: WidgetUtils.buildScrollview(list),
            ),
          ),
        ],
      ),
    );
  }

//背景加文字
  static Widget periodicityDate(String title,
      {Color backgroundColor: Colours.blackground_02,
      double padding: 3,
      Color textColor: Colours.text_9C1,
      double textSize: Dimens.FONT_SIZE_10}) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(padding),
      child: WidgetUtils.getTextColorView(title, textColor, textSize),
    );
  }
}
