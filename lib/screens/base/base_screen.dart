import 'package:flutter/material.dart';
import 'package:task/main.dart';
import 'package:task/mocks/fakes_tasks.dart';
import 'package:task/screens/calendar/calendar_screen.dart';
import 'package:task/screens/charts/dashboard_screen.dart';
import 'package:task/screens/home/home_tab.dart';
import 'package:task/screens/login/login_screen.dart';
import 'package:task/screens/menuScreen/menu_tiles_screen.dart';
import 'package:task/screens/pomodoro/pomodoro_screen.dart';
import 'package:task/theme/manager_theme.dart';

class BaseScreen extends StatefulWidget {
  final ThemeModeManager themeModeManager;

  BaseScreen({required this.themeModeManager});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color get backgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade900 : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          // CalendarPage(),
          PomodoroScreen(),
          TaskStatisticsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article_rounded,
              size: 24,
            ),
            label: 'Tarefas',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_month),
          //   label: 'Calendário',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lock_clock_rounded),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
