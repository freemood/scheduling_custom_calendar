# scheduling_custom_calendar

概述<br>
支持公历，农历<br>
日期范围设置，默认支持的最大日期范围为1971.01-2030.12<br>
跳转到指定日期<br>
显示隐藏顶部的WeekBar<br>
支持周视图的展示,支持月份视图和星期视图的展示与切换联动<br>
支持上一周、下一周的切换week<br>
支持禁止切换下一周、上一周和上一月、下一月<br>
支持默认显示方式是周，还是月<br>
支持禁止点击非本月的日期，防止切换日期<br>

使用<br>
1.在pubspec.yaml文件里面添加依赖:<br>
scheduling_custom_calendar:<br>
    git:<br>
      url: https://github.com/freemood/scheduling_custom_calendar.git<br>
2.使用日历方法<br>
```
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
```
  isExpandable：是否需要切换月（周）历<br>
  onDateSelected：选择的日期<br>
  displayMonthChange：监听年月<br>
  isHideScheduling：隐藏班次<br>
  shiftMap：核心排班数据<br>
  isClick：非本月是否需要触发点击事件<br>
  isNextMonth:是否需要切换下一月<br>
  isBeforeMonth:是否需要切换上一月<br>
  isNextDayWeek:是否需要切换下一周<br>
  isBeforeWeek:是否需要切换上一周<br>
  isShowMonthView：默认是月历<br>
  
  
## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
