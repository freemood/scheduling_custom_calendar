import 'package:flutter/material.dart';
import 'package:scheduling_custom_calendar/model/calendar/entity/shift_calendar_entity.dart';
import 'package:scheduling_custom_calendar/model/calendar/utils/Utils.dart';
import 'package:scheduling_custom_calendar/model/calendar/utils/lunar_util.dart';
import 'package:scheduling_custom_calendar/res/colors.dart';
import 'package:scheduling_custom_calendar/res/dimens.dart';
import 'package:scheduling_custom_calendar/utils/hex_color.dart';
import 'package:scheduling_custom_calendar/utils/object_util.dart';
import 'package:scheduling_custom_calendar/utils/widget_utils.dart';

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;
  final bool isHideScheduling;
  final Map<String, ShiftCalendarEntity> shiftMap;
  final bool isClick;
  final FontWeight fontWeight;
  final double fontSize;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.isHideScheduling: true,
    this.shiftMap,
    this.isClick: true,
    this.fontWeight,
    this.fontSize,
  });
  static Map<String, String> _nlMap = Map();

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return Container(
        alignment: Alignment.center,
        child: WidgetUtils.getTextColorView(
            dayOfWeek, Colours.text_73_70, Dimens.FONT_SIZE_14),
      );
    } else {
      return InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          if (isClick) {
            onDateSelected();
          }
        },
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: Colours.main_01),
                  color: isToday() ? Colours.main_01_15 : Colors.transparent,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isToday() ? Colours.main_01_15 : Colors.transparent,
                ),
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        isToday() ? '今' : Utils.formatDay(date),
                        style: isSelected
                            ? TextStyle(
                                color: Colours.text_2222,
                                fontWeight: fontWeight,
                                fontSize: fontSize,
                              )
                            : dateStyles,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    _getNl(date),
                    style: TextStyle(
                        color: Colours.text_73_70,
                        fontWeight: fontWeight,
                        fontSize: Dimens.FONT_SIZE_12),
                    textAlign: TextAlign.center,
                  ),
                  _showSchedulingView('hide',
                      textColor: Colors.transparent, fontweight: fontWeight),
                ],
              ),
              _showSchedulingView('', fontweight: fontWeight),
            ],
          ),
        ),
      );
    }
  }

  Widget _showSchedulingView(String type,
      {Color textColor: Colours.text_22_30, fontweight}) {
    var name = '暂无';
    var color = Colours.title_white_7a;
    var day = Utils.apiDayFormat(date);
    Color textColor = HexColor('0x337A7A7A');
    if (null != shiftMap) {
      shiftMap.forEach((key, value) {
        if (key.contains(day)) {
          name = value.name;
          if (ObjectUtil.isEmptyString(value.color)) {
            color = Colours.title_white_7a;
            textColor = HexColor('0x337A7A7A');
          } else {
            color = HexColor(value.color);
            textColor = HexColor(
                (value.color == 'B0B0B0' ? '0x66' : '0x33') + value.color);
          }
        }
      });
    }
    return Offstage(
      offstage: isHideScheduling,
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 4),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: WidgetUtils.getTextColorView(name, color, Dimens.FONT_SIZE_12,
              fontweight: fontweight, textAlign: TextAlign.center),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            // border: Border.all(width: 1, color: Colours.main_01),
            color: 'hide' != type ? textColor : Colors.transparent,
          ),
        ),
      ),
    );
  }

  bool isToday() {
    return Utils.apiDayFormat(DateTime.now()) == Utils.apiDayFormat(date);
  }

  String _getNl(DateTime date) {
    String nlStr = _nlMap[Utils.apiDayFormat(date)];
    if (ObjectUtil.isEmpty(nlStr)) {
      List<int> lunar = LunarUtil.solarToLunar(
          int.parse(Utils.formatOneYear(date)),
          int.parse(Utils.formatOneMonth(date)),
          int.parse(Utils.formatDay(date)));
      nlStr = LunarUtil.numToChinese(lunar[1], lunar[2], lunar[3]);
      _nlMap[Utils.apiDayFormat(date)] = nlStr;
    }
    return nlStr;
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: renderDateOrDayOfWeek(context),
    );
  }
}
