import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scheduling_custom_calendar/model/calendar/entity/shift_calendar_entity.dart';
import 'package:scheduling_custom_calendar/model/calendar/utils/Utils.dart';
import 'package:scheduling_custom_calendar/res/colors.dart';
import 'package:scheduling_custom_calendar/res/dimens.dart';
import 'package:scheduling_custom_calendar/utils/object_util.dart';
import 'package:scheduling_custom_calendar/utils/widget_utils.dart';
import 'package:tuple/tuple.dart';

import 'calendar_tile.dart';

typedef DayBuilder(BuildContext context, DateTime day);

class Calendar extends StatefulWidget {
  Calendar(
      {this.onDateSelected,
      this.onSelectedRangeChange,
      this.displayMonthChange,
      this.isExpandable: false,
      this.isShowMonthView: false,
      this.isHideScheduling: true,
      this.isHideChangeWeek: true,
      this.dayBuilder,
      this.shiftMap,
      this.weeksDaysChange,
      this.showTodayAction: true,
      this.showChevronsToChangeRange: true,
      this.showCalendarPickerIcon: true,
      this.isNextMonth: false,
      this.isBeforeMonth: false,
      this.isNextDayWeek: true,
      this.isBeforeWeek: true,
      this.initialCalendarDateOverride});

  final DayBuilder dayBuilder;
  final DateTime initialCalendarDateOverride;
  final bool isExpandable;
  final ValueChanged<String> displayMonthChange;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<List<DateTime>> weeksDaysChange;
  final ValueChanged<Tuple2<DateTime, DateTime>> onSelectedRangeChange;
  final bool showCalendarPickerIcon;
  final bool showChevronsToChangeRange;
  final bool showTodayAction;
  final bool isHideScheduling;//是否隐藏班次
  final bool isHideChangeWeek;//是否隐藏上一周下一周
  final bool isNextMonth;//是否需要切换下一月
  final bool isBeforeMonth;//是否需要切换上一月
  final bool isNextDayWeek;//是否需要切换下一周
  final bool isBeforeWeek;//是否需要切换上一周
  final bool isShowMonthView;//默认是月历
  final Map<String, ShiftCalendarEntity> shiftMap;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = Utils();
  String currentMonth;
  String displayMonth;
  var gestureDirection;
  var gestureStart;
  bool isExpanded = false;
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void initState() {
    super.initState();
    if (widget.initialCalendarDateOverride != null)
      _selectedDate = widget.initialCalendarDateOverride;
    isExpanded = widget.isShowMonthView;
    selectedMonthsDays = Utils.daysInMonth(_selectedDate);
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
    selectedWeeksDays =
        Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
            .toList()
            .sublist(0, 7);
    _getWeeksDaysChange(selectedWeeksDays);

    displayMonth = Utils.formatMonth(_selectedDate);
    // _onDisplayMonthChange();
  }

  _getWeeksDaysChange(selectedWeeksDays) {
    if (null != widget.weeksDaysChange) {
      widget.weeksDaysChange(selectedWeeksDays);
    }
  }

  _onDisplayMonthChange() {
    if (widget.displayMonthChange != null &&
        ObjectUtil.isNotEmpty(displayMonth)) {
      widget.displayMonthChange(displayMonth);
    }
  }

  Widget get nameAndIconRow {
    var leftInnerIcon;
    var rightInnerIcon;
    var leftOuterIcon;
    var rightOuterIcon;
    //弹出日历窗口
    // if (widget.showCalendarPickerIcon) {
    //   rightInnerIcon = IconButton(
    //     onPressed: () => selectDateFromPicker(),
    //     icon: Icon(Icons.calendar_today),
    //   );
    // } else {
    //   rightInnerIcon = Container();
    // }

    if (widget.showChevronsToChangeRange) {
      //上个月
      leftOuterIcon = !this.widget.isBeforeWeek
          ? Container()
          : GestureDetector(
              onTap: () {
                isExpanded ? previousMonth() : previousWeek();
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.chevron_left,
                    color: Colours.text_04,
                    size: 24,
                  ),
                  WidgetUtils.getTextColorView(isExpanded ? '上一月' : '上一周',
                      Colours.text_2222, Dimens.FONT_SIZE_16),
                ],
              ),
            );
      //下个月
      rightOuterIcon = !this.widget.isNextDayWeek
          ? Container()
          : GestureDetector(
              onTap: () {
                isExpanded ? nextMonth() : nextWeek();
              },
              child: Row(
                children: <Widget>[
                  WidgetUtils.getTextColorView(isExpanded ? '下一月' : '下一周',
                      Colours.text_2222, Dimens.FONT_SIZE_16),
                  Icon(
                    Icons.chevron_right,
                    color: Colours.text_04,
                    size: 24,
                  ),
                ],
              ),
            );
    } else {
      leftOuterIcon = Container();
      rightOuterIcon = Container();
    }

    if (widget.showTodayAction) {
      //立刻切换成当天
      // leftInnerIcon = InkWell(
      //   child: Text('Today'),
      //   onTap: resetToToday,
      // );
    } else {
      leftInnerIcon = Container();
    }

    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftOuterIcon ?? Container(),
            leftInnerIcon ?? Container(),
            rightInnerIcon ?? Container(),
            rightOuterIcon ?? Container(),
          ],
        ),
        Align(
          alignment: FractionalOffset.center,
          child: WidgetUtils.getTextColorView(
            displayMonth,
            Colours.gray_33,
            Dimens.FONT_SIZE_16,
          ),
        ),
      ],
    );
  }

  Widget get calendarGridView {
    return Container(
      margin: const EdgeInsets.only(top: 4, left: 8, right: 8),
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Offstage(
            offstage: this.widget.isHideChangeWeek,
            child: nameAndIconRow,
          ),
          _dayWeek(),
          GestureDetector(
            onHorizontalDragStart: (gestureDetails) =>
                beginSwipe(gestureDetails),
            onHorizontalDragUpdate: (gestureDetails) =>
                getDirection(gestureDetails),
            onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 7,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: this.widget.isHideScheduling ? 0.95 : 0.57,
              padding: EdgeInsets.only(bottom: 0.0),
              children: calendarBuilder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dayWeek() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: Utils.weekdays.map((String date) {
          return Expanded(
            flex: 1,
            child: WidgetUtils.getTextColorView(
                date, Colours.text_73_70, Dimens.FONT_SIZE_14,
                textAlign: TextAlign.center),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeeksDays;

    // Utils.weekdays.forEach(
    //   (day) {
    //     dayWidgets.add(
    //       CalendarTile(
    //         isDayOfWeek: true,
    //         dayOfWeek: day,
    //       ),
    //     );
    //   },
    // );

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach(
      (day) {
        if (monthStarted && day.day == 01) {
          monthEnded = true;
        }

        if (Utils.isFirstDayOfMonth(day)) {
          monthStarted = true;
        }

        if (this.widget.dayBuilder != null) {
          // dayWidgets.add(
          //   CalendarTile(
          //     child: this.widget.dayBuilder(context, day),
          //     date: day,
          //     onDateSelected: () => handleSelectedDateAndUserCallback(day),
          //   ),
          // );
        } else {
          // if (monthEnded) {
          //   return;
          // }
          dayWidgets.add(
            CalendarTile(
              onDateSelected: () => handleSelectedDateAndUserCallback(day),
              date: day,
              dateStyles: configureDateStyle(monthStarted, monthEnded),
              isSelected: Utils.isSameDay(selectedDate, day),
              isHideScheduling: this.widget.isHideScheduling,
              shiftMap: this.widget.shiftMap,
            ),
          );
        }
      },
    );
    return dayWidgets;
  }

  TextStyle configureDateStyle(monthStarted, monthEnded) {
    TextStyle dateStyles;
    if (isExpanded) {
      dateStyles = monthStarted && !monthEnded
          ? TextStyle(
              color: Colours.text_2222,
              fontWeight: FontWeight.w500,
              fontSize: Dimens.FONT_SIZE_18)
          : TextStyle(
              color: Colours.text_26_40,
              fontWeight: FontWeight.w500,
              fontSize: Dimens.FONT_SIZE_18);
    } else {
      dateStyles = TextStyle(
          color: Colours.text_2222,
          fontWeight: FontWeight.w500,
          fontSize: Dimens.FONT_SIZE_18);
    }
    return dateStyles;
  }

  //切换周、月
  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(Utils.fullDayFormat(selectedDate)),
          GestureDetector(
            onTap: () {
              toggleExpanded();
            },
            child: Container(
              color: Colors.transparent,
              child: isExpanded
                  ? WidgetUtils.getImageAssetWidget('date_arrow_up', size: 32)
                  : WidgetUtils.getImageAssetWidget('date_arrow_down',
                      size: 32),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void resetToToday() {
    _selectedDate = DateTime.now();
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      displayMonth = Utils.formatMonth(_selectedDate);
      _onDisplayMonthChange();
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    // LogUtil.e(this.widget.isNextDay,tag: 'this.widget.isNextDay......');
    if (!this.widget.isNextMonth) {
      return;
    }
    setState(() {
      _selectedDate = Utils.nextMonth(_selectedDate);
      var firstDateOfMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfMonth, lastDateOfMonth);
      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
      displayMonth = Utils.formatMonth(_selectedDate);
      _onDisplayMonthChange();
    });
  }

  void previousMonth() {
    if (!this.widget.isBeforeMonth) {
      return;
    }
    setState(() {
      _selectedDate = Utils.previousMonth(_selectedDate);
      var firstDateOfMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfMonth, lastDateOfMonth);
      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
      displayMonth = Utils.formatMonth(_selectedDate);
      _onDisplayMonthChange();
    });
  }

  void nextWeek() {
    if (!this.widget.isNextDayWeek) {
      return;
    }

    setState(() {
      _selectedDate = Utils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      _getWeeksDaysChange(selectedWeeksDays);
      displayMonth = Utils.formatMonth(_selectedDate);
      _onDisplayMonthChange();
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    if (!this.widget.isBeforeWeek) {
      return;
    }
    setState(() {
      _selectedDate = Utils.previousWeek(_selectedDate);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      _getWeeksDaysChange(selectedWeeksDays);
      displayMonth = Utils.formatMonth(_selectedDate);
      _onDisplayMonthChange();
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    var selectedRange = Tuple2<DateTime, DateTime>(start, end);
    if (widget.onSelectedRangeChange != null) {
      widget.onSelectedRangeChange(selectedRange);
    }
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2030),
    );

    if (selected != null) {
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

      setState(() {
        _selectedDate = selected;
        selectedWeeksDays =
            Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList();
        selectedMonthsDays = Utils.daysInMonth(selected);
        displayMonth = Utils.formatMonth(selected);
        _onDisplayMonthChange();
      });
      // updating selected date range based on selected week
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      _launchDateSelectionCallback(selected);
    }
  }

  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      if (isExpanded) {
        nextMonth();
      } else {
        nextWeek();
      }
    } else {
      if (isExpanded) {
        previousMonth();
      } else {
        previousWeek();
      }
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(day);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(day);
    setState(() {
      _selectedDate = day;
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = Utils.daysInMonth(day);
    });
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected(day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExpansionCrossFade(
          collapsed: calendarGridView,
          expanded: calendarGridView,
          isExpanded: isExpanded,
        ),
        expansionButtonRow
      ],
    );
  }
}

class ExpansionCrossFade extends StatelessWidget {
  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});

  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: AnimatedCrossFade(
        firstChild: collapsed,
        secondChild: expanded,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
