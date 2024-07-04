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
    DateTime(2024, 5, 1),
    DateTime(2024, 5, 1),
    DateTime(2024, 5, 1),
    DateTime(2024, 5, 2),
    DateTime(2024, 5, 3),
    DateTime(2024, 5, 26),
    DateTime(2024, 6, 11),
    DateTime(2024, 6, 12),
    DateTime(2024, 6, 13),
    DateTime(2024, 6, 15),
    DateTime(2024, 6, 17),
    DateTime(2024, 6, 16),
    DateTime(2024, 6, 18),
  ]; //better to build a list beforehand like this.

  //Initialize a DuoCalendar object
  DuoCalendar calendar =
      DuoCalendar(dayNameLetters: 3); //dayNameLetters: 3 or 2

  //Initialize the calendar before the build method of your widget
  //Cause:______________________________________________________________________
  //else, the calendar will be initialized every time the build method is called
  //thus the supplyDate will be reset to the current date every time the build method is called

  @override
  Widget build(BuildContext context) {
    //Build method of your widget
    calendar.streakList =
        StreakList; //Within the build method, supply the streakList
    calendar.setStreakData(); //Set the streak data for the calendar
    calendar.colorList = [
      //Color list if u want to specify colors for each date in streakList
      //Otherwise, the default color will be used; see variables in DuoCalendar class
      1,
      2,
      2,
      3,
      1,
      2,
      2,
      3,
      1,
      1,
      2
    ]; //Color numbering list corresponding to each date in streakList, starts from 1 to n
    //Specify color paletter corresponding to the numbering types in the colorList (1, 2, 3, ... n)
    //let the highest number in the colorList be n, then the colorPaletteList must have n colors
    //if you can't specify all colors, fill with Colors.transparent
    //NOTE:_____________________________________________________________________
    // If you are supplying the colorList, ensure no duplicate items in streaklist and colorList
    //before supplying the streaklist and colorList. If you happen to draw data from a database,
    //then remove duplicates from the data on your own before supplying it to the calendar.
    calendar.colorPaletteList = [
      Color.fromARGB(255, 214, 16, 16),
      const Color.fromARGB(255, 0, 140, 255),
      Color.fromARGB(255, 0, 255, 174),
    ];

    //__________________________________________________________________________
    //SUPPLYING THE BACK AND FORWARD BUTTON FUNCTIONS
    //Copy and paste, just change Variable names
    //__________________________________________________________________________
    calendar.backButtonFunction = () {
      setState(() {
        calendar.streakList = StreakList; //Supply the StreakList again here
        calendar.supplyDate = calendar.supplyDateForPreviousMonth;
        calendar.calendarBuild(context);
      });
    };
    calendar.forwardButtonFunction = () {
      setState(() {
        calendar.streakList = StreakList; //Supply the StreakList again here
        calendar.supplyDate = calendar.supplyDateForNextMonth;
        calendar.calendarBuild(context);
        //have to change the streakList here
      });
    };
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
            Container(child: calendar.calendarBuild(context)), //Build only ONCE
          ],
        ),
      ),
    ));
  }
}
