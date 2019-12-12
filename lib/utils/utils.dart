import 'dart:io';

import 'package:flutter/material.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'images/$name.$format';
  }

  // static String getPinyin(String str) {
  //   return PinyinHelper.getShortPinyin(str).substring(0, 1).toUpperCase();
  // }

//  static Color getCircleBg(String str) {
//    String pinyin = getPinyin(str);
//    return getCircleAvatarBg(pinyin);
//  }

//  static Color getCircleAvatarBg(String key) {
//    return circleAvatarMap[key];
//  }

  // static Color getChipBgColor(String name) {
  //   String pinyin = PinyinHelper.getFirstWordPinyin(name);
  //   pinyin = pinyin.substring(0, 1).toUpperCase();
  //   return nameToColor(pinyin);
  // }

  static Color nameToColor(String name) {
    // assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  static String reTextNull(String str) {
    if (null == str || str.isEmpty || '请选择' == str || 'null' == str) {
      return '';
    }
    return str;
  }

  static String reTimeNull(String str) {
    if (null == str || str.isEmpty || 'null' == str) {
      return '请选择';
    }
    return str;
  }

  static int reIntNull(String str) {
    if (null == str || str.isEmpty || '请选择' == str || 'null' == str) {
      return 0;
    }
    return int.parse(str);
  }

//   static bool showNullToast(BuildContext context,String str, String toastStr) {
//     if (null == str || str.isEmpty || '请选择' == (str)) {
//       StringBuffer sb = new StringBuffer();
//       if ('请选择' == (str)) {
//         sb..write('请选择')..write(toastStr);
//       } else {
//         sb..write(toastStr)..write('未填写');
//       }
//       ShowToast.showToast(context,sb.toString());
//       return true;
//     }
//     return false;
//   }
// }

// class FileImageEx extends FileImage {
//   int fileSize;
//   FileImageEx(File file, { double scale = 1.0 })
//       : assert(file != null),
//         assert(scale != null),
//         super(file, scale: scale) {
//     fileSize = file.lengthSync();
//   }

//   @override
//   bool operator ==(dynamic other) {
//     if (other.runtimeType != runtimeType)
//       return false;
//     final FileImageEx typedOther = other;
//     return file?.path == typedOther.file?.path
//         && scale == typedOther.scale && fileSize == typedOther.fileSize;
//   }

}