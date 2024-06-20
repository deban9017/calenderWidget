import 'package:flutter/material.dart';
import 'package:calendar_widget/calendar.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DateTime> StreakList = [
    DateTime(2024, 5, 4),
    DateTime(2024, 5, 5),
    DateTime(2024, 5, 3),
    DateTime(2024, 5, 1),
    DateTime(2024, 5, 26),
    DateTime(2024, 5, 27),
    DateTime(2024, 5, 28),
    DateTime(2024, 5, 31),
    //generate all dates of the month 6
    DateTime(2024, 6, 2),
    DateTime(2024, 6, 4),
    DateTime(2024, 6, 6),
    DateTime(2024, 6, 12),
    DateTime(2024, 6, 13),
    DateTime(2024, 6, 14),
    DateTime(2024, 6, 17),
    DateTime(2024, 6, 16),
    DateTime(2024, 6, 18),
    DateTime(2024, 6, 19),
  ];

  DuoCalendar calendar = DuoCalendar(dayNameLetters: 3);
  //Initialize the calendar before the build method
  //Cause:______________________________________________________________________
  //else, the calendar will be initialized every time the build method is called
  //thus the supplyDate will be reset to the current date every time the build method is called

  @override
  Widget build(BuildContext context) {
    calendar.streakList = StreakList;
    calendar.calendarBuild(context);

    //SUPPLYING THE BACK AND FORWARD BUTTON FUNCTIONS
    //__________________________________________________________________________
    calendar.backButtonFunction = () {
      //TESTING
      // print('updated streakList: ${calendar.streakList}'); //TESTING
      setState(() {
        calendar.streakList = StreakList;
        calendar.supplyDate = calendar.supplyDateForPreviousMonth;
        calendar.calendarBuild(context);
      });
    };
    calendar.forwardButtonFunction = () {
      setState(() {
        calendar.streakList = StreakList;
        // print('Calendar.supplyDate next month (inside fwd button): ${calendar.supplyDateForNextMonth}'); //TESTING
        calendar.supplyDate = calendar.supplyDateForNextMonth;
        // print('Supplied date: ${calendar.supplyDate}'); //TESTING
        calendar.calendarBuild(context);
        //have to change the streakList here
      });
    };
    //__________________________________________________________________________

    //STREAKLIST TESTING________________________________________________________
    // StreakService streak = StreakService();
    // streak.streakList = StreakList;
    // streak.supplyDate = DateTime.now();
    // streak.CalculateStreakData();
    // print('longestStreak: ${streak.longestStreak}');
    // print('lastStreak: ${streak.lastStreak}');
    // print('lastDayIsStreak: ${streak.currentStreakIsLastStreak}');

    //__________________________________________________________________________

    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                child: calendar.StreakDataDashboard(context),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(child: calendar.calendarBuild(context)),
          ],
        ),
      ),
    ));
  }
}
