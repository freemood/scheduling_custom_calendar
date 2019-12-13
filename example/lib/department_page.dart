import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scheduling_custom_calendar/model/calendar/entity/shift_calendar_entity.dart';
import 'package:scheduling_custom_calendar/model/calendar/ui/flutter_calendar.dart';
import 'package:scheduling_custom_calendar/model/calendar/utils/Utils.dart';
import 'package:scheduling_custom_calendar/res/colors.dart';
import 'package:scheduling_custom_calendar/res/dimens.dart';
import 'package:scheduling_custom_calendar/utils/date_util.dart';
import 'package:scheduling_custom_calendar/utils/log_util.dart';
import 'package:scheduling_custom_calendar/utils/widget_utils.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<ShiftCalendarEntity> _listMonth = [];
  var selectDay;
  var toDay;
  var startDay;
  var endDay;
  var _userId;
  List<DateTime> indexDate = [];
  var _index = 0;
  Map<String, ShiftCalendarEntity> _shiftMap = {};
  var _isBeforeWeek = true;
  var _isNextWeek = true;

  @override
  void initState() {
    super.initState();
    toDay = DateUtil.getNowDateStr(format: DateFormat.YEAR_MONTH_DAY);
    _listMonth
      ..add(ShiftCalendarEntity()
        ..color = '167AB3'
        ..day = '2019-12-01'
        ..endTime = '02:00'
        ..name = 'A班'
        ..startTime = '18:00')
      ..add(ShiftCalendarEntity()
        ..color = '0D949B'
        ..day = '2019-12-01'
        ..endTime = '06:00'
        ..name = 'B班'
        ..startTime = '19:00')
      ..add(ShiftCalendarEntity()
        ..color = 'FC6815'
        ..day = '2019-12-01'
        ..endTime = '12:00'
        ..name = 'C班'
        ..startTime = '20:00')
      ..add(ShiftCalendarEntity()
        ..color = '47970B'
        ..day = '2019-12-01'
        ..endTime = '08:00'
        ..name = '休息'
        ..startTime = '15:00')
      ..add(ShiftCalendarEntity()
        ..color = 'B0B0B0'
        ..day = '2019-12-01'
        ..endTime = ''
        ..name = '暂无'
        ..startTime = '');

    _showInformationTask(getWeekDay(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: WidgetUtils.getTextColorView(
            '部门排班', Colours.title_white, Dimens.FONT_SIZE_16),
        backgroundColor: Colours.main_01,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colours.title_white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          padding: EdgeInsets.all(0.0),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              _calendarView(),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: WidgetUtils.drawCodeDivider(height: 1),
              ),
              //_departmentListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calendarView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colours.title_white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Calendar(
        isExpandable: false,
        onDateSelected: (date) => handleNewDate(date),
        weeksDaysChange: (data) => handleweeksDays(data),
        isHideScheduling: false,
        isHideChangeWeek: false,
        shiftMap: _shiftMap,
        // isBeforeWeek: _isBeforeWeek,
        // isNextDayWeek: _isNextWeek,
      ),
    );
  }

  List<DateTime> getWeekDay(selectedDate) {
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selectedDate);
    List<DateTime> selectedWeeksDays =
        Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
            .toList()
            .sublist(0, 7);
            LogUtil.e(selectedWeeksDays.length,tag: 'getWeekDay.........');
    return selectedWeeksDays;
  }

  // Widget _departmentListView() {
  //   return Container(
  //     child: Column(
  //       children: _listSchedules.map((ScheduleEntity entity) {
  //         return _departmentView(entity); //赋值后的Widget
  //       }).toList(),
  //     ),
  //   );
  // }

  // Widget _departmentView(ScheduleEntity entity) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 24),
  //     child: Column(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.only(left: 16),
  //           child: Row(
  //             children: <Widget>[
  //               WidgetUtils.getTextColorView(
  //                   entity.userName, Colours.gray_33, Dimens.FONT_SIZE_17,
  //                   fontweight: FontWeight.w500),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 32),
  //                 child: WidgetUtils.getTextColorView(
  //                     entity.schedule, Colours.text_gray, Dimens.FONT_SIZE_16),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: entity.shiftList.map((ShiftEntity entity) {
  //               return _personView(entity);
  //             }).toList(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _personView(ShiftEntity entity) {
  //   return Expanded(
  //     child: Container(
  //       alignment: Alignment.center,
  //       margin: EdgeInsets.symmetric(horizontal: entity.horizontalPadding),
  //       padding: EdgeInsets.symmetric(
  //           horizontal: entity.horizontalPadding,
  //           vertical: entity.verticalPadding),
  //       decoration: BoxDecoration(
  //         // border: Border.all(color: boxColor, width: 1.0),
  //         borderRadius: BorderRadius.circular(4.0),
  //         color: ObjectUtil.isEmptyString(entity.color)
  //             ? Colours.text_22_30
  //             : HexColor('0x33' + entity.color),
  //       ),
  //       child: WidgetUtils.getTextColorView(
  //           ObjectUtil.isEmptyString(entity.name) ? '暂无' : entity.name,
  //           (ObjectUtil.isEmptyString(entity.color) || '222222' == entity.color)
  //               ? Colours.title_white_70
  //               : HexColor(entity.color),
  //           '暂无' == entity.name ? Dimens.FONT_SIZE_10 : Dimens.FONT_SIZE_12,
  //           fontweight: FontWeight.w500),
  //     ),
  //     flex: 1,
  //   );
  // }

  void handleweeksDays(List<DateTime> data) {
    // startDay = DateUtil.getDateStrByDateTime(data[0],
    //     format: DateFormat.YEAR_MONTH_DAY);
    // endDay = DateUtil.getDateStrByDateTime(data[data.length - 1],
    //     format: DateFormat.YEAR_MONTH_DAY);
    indexDate = data;
    // _setDateTimeIndx(ObjectUtil.isEmptyString(selectDay) ? toDay : selectDay);
    _showInformationTask(data);
  }

  void handleNewDate(DateTime dateTime) {
    if (dateTime.millisecondsSinceEpoch <
        DateTime.now().millisecondsSinceEpoch) {
      return;
    }
    // selectDay = DateUtil.getDateStrByDateTime(dateTime,
    //     format: DateFormat.YEAR_MONTH_DAY);
    // _settingPadding(selectDay);
    // _setDateTimeIndx(selectDay);
  }

  // _setDateTimeIndx(day) {
  //   if (!ObjectUtil.isEmptyList(indexDate)) {
  //     int count = indexDate.length;
  //     for (var i = 0; i < count; i++) {
  //       String indexDay = DateUtil.getDateStrByDateTime(indexDate[i],
  //           format: DateFormat.YEAR_MONTH_DAY);
  //       if (day == indexDay) {
  //         _index = i;
  //         return;
  //       }
  //     }
  //   }
  // }

//设置边距
  // _settingPadding(selectDay) {
  //   setState(() {
  //     for (var taskEntity in _listSchedules) {
  //       for (var personEntity in taskEntity.shiftList) {
  //         personEntity.verticalPadding = 12;
  //         personEntity.horizontalPadding = 4;
  //         if (_userId == taskEntity.userId) {
  //           ShiftCalendarEntity shiftCalendarEntity = ShiftCalendarEntity();
  //           shiftCalendarEntity
  //             ..color = personEntity.color
  //             ..date = personEntity.date
  //             ..day = personEntity.day
  //             ..endTime = personEntity.endTime
  //             ..hasBefore = personEntity.hasBefore
  //             ..hasNext = personEntity.hasNext
  //             ..horizontalPadding = personEntity.horizontalPadding
  //             ..isSelect = personEntity.isSelect
  //             ..name = personEntity.name
  //             ..startTime = personEntity.startTime
  //             ..userId = personEntity.userId
  //             ..verticalPadding = personEntity.verticalPadding;
  //           _shiftMap[_userId + personEntity.day] = shiftCalendarEntity;
  //         }
  //         if (selectDay == personEntity.day) {
  //           personEntity.verticalPadding = 14;
  //           personEntity.horizontalPadding = 2;
  //           if (!ObjectUtil.isEmptyString(personEntity.name) &&
  //               ('暂无' == personEntity.name || '休息' == personEntity.name)) {
  //             taskEntity.schedule = '${personEntity.name}';
  //           } else {
  //             taskEntity.schedule =
  //                 '${personEntity.name}:${personEntity.startTime}~${personEntity.endTime}';
  //           }
  //         }
  //       }
  //     }
  //   });
  // }

  _showInformationTask(List<DateTime> data) {
    int length =_listMonth.length;
    for (var dateTime in data) {
      ShiftCalendarEntity shiftCalendarEntity =
          _listMonth[Random().nextInt(length)];
      shiftCalendarEntity.day = Utils.apiDayFormat(dateTime);
      _shiftMap[shiftCalendarEntity.day] = shiftCalendarEntity;
    }
  }
}
