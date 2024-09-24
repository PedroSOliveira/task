import 'package:flutter/material.dart';
import 'dart:async';

import 'package:task/theme/manager_theme.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int _minutes = 25;
  int _seconds = 0;
  bool _isRunning = false;
  Timer? _timer; // Use Timer? para permitir valores nulos.

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_minutes == 0 && _seconds == 0) {
        _resetTimer();
        return;
      }
      setState(() {
        if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _seconds--;
        }
      });
    });
  }

  void _stopTimer() {
    // Verifique se o _timer não é nulo e está ativo antes de cancelar.
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _isRunning = false;
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _minutes = 25;
      _seconds = 0;
    });
  }

  Color get backgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade900 : Colors.grey.shade200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    value: (_minutes * 60 + _seconds) / (25 * 60),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                    backgroundColor: backgroundColor,
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_minutes:${_seconds.toString().padLeft(2, '0')}',
                      style:
                          TextStyle(fontSize: 60, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.blue.shade400,
                  ),
                  onPressed: _isRunning ? null : _startTimer,
                  iconSize: 60,
                ),
                IconButton(
                  icon: Icon(
                    Icons.stop,
                    color: Colors.blue.shade500,
                  ),
                  onPressed: _isRunning ? _stopTimer : null,
                  iconSize: 60,
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.blue.shade400,
                  ),
                  onPressed: _resetTimer,
                  iconSize: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopTimer(); // Certifique-se de que o timer está cancelado corretamente.
    super.dispose();
  }
}
