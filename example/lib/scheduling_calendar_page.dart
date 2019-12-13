import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:math';

import 'package:example/department_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduling_custom_calendar/model/calendar/entity/shift_calendar_entity.dart';
import 'package:scheduling_custom_calendar/model/calendar/ui/flutter_calendar.dart';
import 'package:scheduling_custom_calendar/model/calendar/utils/Utils.dart';
import 'package:scheduling_custom_calendar/res/colors.dart';
import 'package:scheduling_custom_calendar/res/dimens.dart';
import 'package:scheduling_custom_calendar/utils/date_util.dart';
import 'package:scheduling_custom_calendar/utils/object_util.dart';
import 'package:scheduling_custom_calendar/utils/widget_utils.dart';

class SchedulingCalendarPage extends StatefulWidget {
  @override
  _SchedulingCalendarPageState createState() => _SchedulingCalendarPageState();
}

class _SchedulingCalendarPageState extends State<SchedulingCalendarPage>
    with AutomaticKeepAliveClientMixin {
  var displayMonth;
  var nowMonth;
  var selectDay;
  var selectMonthDay;
  var selectWeekDay;
  var selectYear;
  var today;

  var _isBeforeDay = true;
  var _isNextDay = true;
  //用来判断是否需要切换上、下月
  Map<String, Map<String, bool>> _nextMonthMap = {};

  //排班显示集合
  Map<String, ShiftCalendarEntity> _shiftMap = {};

  //根据月份识别相应集合
  Map<String, Map<String, ShiftCalendarEntity>> _shiftMonthMap = {};

  @override
  bool get wantKeepAlive => true;
  List<ShiftCalendarEntity> _listMonth = [];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initDay();

    today = DateUtil.getNowDateStr(format: DateFormat.YEAR_MONTH_DAY);
    selectDay = DateUtil.getNowDateStr(format: DateFormat.YEAR_MONTH_DAY);
    displayMonth = Utils.formatMonth(DateTime.now());
    nowMonth = DateUtil.getNowDateStr(format: DateFormat.YEAR_MONTH);
    _showInformationTask(DateTime.now());
  }

  initDay() {
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
  }

  Widget bodyView() {
    return Stack(
      children: <Widget>[
        // WidgetUtils.getImagewidth('tongjibg',
        //     width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
        Column(
          children: <Widget>[
            _nameAndMonth(),
            //日历
            _calendarView(),
            //班次
            _nowDayShifts(),
          ],
        ),
      ],
    );
  }

  Widget _nowDayShifts() {
    return Container(
        decoration: BoxDecoration(
          color: Colours.title_white,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                WidgetUtils.getTextColorView(
                    selectDay == today ? '今日' : selectYear,
                    Colours.text_91,
                    Dimens.FONT_SIZE_16,
                    fontweight: FontWeight.w500),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: WidgetUtils.getTextColorView(
                      selectDay == today
                          ? Utils.formatMonthDayFormat(DateTime.now())
                          : selectMonthDay,
                      Colours.text_91,
                      Dimens.FONT_SIZE_16,
                      fontweight: FontWeight.w500),
                ),
                WidgetUtils.getTextColorView(
                    selectDay == today
                        ? DateUtil.getZHWeekDay(DateTime.now())
                        : selectWeekDay,
                    Colours.text_91,
                    Dimens.FONT_SIZE_16,
                    fontweight: FontWeight.w500),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DepartmentPage();
                      }),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: WidgetUtils.getTextColorView(
                            '查看部门信息', Colours.main_01, Dimens.FONT_SIZE_14),
                      ),
                  
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colours.main_01,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _titleView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 41,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              '排班',
              style: TextStyle(
                fontSize: 18,
                color: Colours.text_2222,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameAndMonth() {
    return Container(
      child: Column(
        children: <Widget>[
          _titleView(),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: WidgetUtils.getTextColorView(
                displayMonth, Colours.text_2222, Dimens.FONT_SIZE_16),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colours.main_01_15,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(top: 4, bottom: 16),
            child: WidgetUtils.getTextColorView(
                '排班班表', Colours.title_white, Dimens.FONT_SIZE_16,
                fontweight: FontWeight.w600),
          ),
        ],
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
        isExpandable: true,
        onDateSelected: (date) => handleNewDate(date),
        displayMonthChange: (data) => handleDisplayMonth(data),
        isHideScheduling: false,
        shiftMap: _shiftMap,
        isClick: true,
        isBeforeMonth: _isBeforeDay,
        isNextMonth: _isNextDay,
        isShowMonthView: true,
      ),
    );
  }

  void handleDisplayMonth(String data) {
    if (!mounted) return;
    setState(() {
      displayMonth = data;
      nowMonth = data.replaceAll('年', '-').replaceAll('月', '');
      _resetCanlendar();
    });
  }

  _resetCanlendar() {
    selectDay = nowMonth + '-01';
    _shiftMap = _shiftMonthMap[nowMonth];
    _retToday();
    if (null == _shiftMap) {
      _showInformationTask(DateUtil.getDateTime(selectDay));
    }

    // _isBeforeDay = _nextMonthMap[nowMonth]['isBeforeDay'];
    // _isNextDay = _nextMonthMap[nowMonth]['isNextDay'];
  }

  _retToday() {
    DateTime dateTime = DateUtil.getDateTime(selectDay);
    selectYear = Utils.formatOneYear(dateTime);
    selectMonthDay = Utils.formatMonthDayFormat(dateTime);
    selectWeekDay = DateUtil.getZHWeekDay(dateTime);
  }

  void handleNewDate(DateTime dateTime) {
    setState(() {
      selectDay = DateUtil.getDateStrByDateTime(dateTime,
          format: DateFormat.YEAR_MONTH_DAY);
      _retToday();
    });

    // _showInformationTask(DateUtil.getDateStrByDateTime(dateTime,
    //     format: DateFormat.YEAR_MONTH_DAY));
  }

  _showInformationTask(dateTime) {
    _shiftMap = {};
    List<DateTime> selectedMonthsDays = Utils.daysInMonth(dateTime);
    int count = _listMonth.length;
    for (var dateTime in selectedMonthsDays) {
      ShiftCalendarEntity shiftCalendarEntity =
          _listMonth[Random().nextInt(count)];
      shiftCalendarEntity.day = Utils.apiDayFormat(dateTime);
      _shiftMap[shiftCalendarEntity.day] = shiftCalendarEntity;
    }

    _shiftMonthMap[nowMonth] = _shiftMap;
    _retToday();
    // Map<String, bool> map = Map();
    // map['isBeforeDay'] = _isBeforeDay;
    // map['isNextDay'] = _isNextDay;
    // _nextMonthMap[nowMonth] = map;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colours.main_01,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colours.gray_f0,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          padding: EdgeInsets.all(0.0),
          physics: BouncingScrollPhysics(),
          child: bodyView(),
        ),
      ),
    );
  }
}
