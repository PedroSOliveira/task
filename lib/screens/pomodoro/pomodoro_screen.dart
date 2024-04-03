// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'dart:async';

// class PomodoroScreen extends StatefulWidget {
//   @override
//   _PomodoroScreenState createState() => _PomodoroScreenState();
// }

// class _PomodoroScreenState extends State<PomodoroScreen> {
//   int _minutes = 25;
//   int _seconds = 0;
//   bool _isRunning = false;
//   late Timer _timer;

//   void _startTimer() {
//     _isRunning = true;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_minutes == 0 && _seconds == 0) {
//         _resetTimer();
//         // Aqui você pode adicionar qualquer ação quando o tempo acabar, como exibir uma notificação.
//         return;
//       }
//       setState(() {
//         if (_seconds == 0) {
//           _minutes--;
//           _seconds = 59;
//         } else {
//           _seconds--;
//         }
//       });
//     });
//   }

//   void _stopTimer() {
//     if (_timer != null) {
//       _timer.cancel();
//       _isRunning = false;
//     }
//   }

//   void _resetTimer() {
//     _stopTimer();
//     setState(() {
//       _minutes = 25;
//       _seconds = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   width: 300,
//                   height: 300,
//                   child: CircularProgressIndicator(
//                     value: _minutes * 60 / (25 * 60),
//                     valueColor:
//                         const AlwaysStoppedAnimation<Color>(Colors.blue),
//                     backgroundColor: Colors.grey.shade200,
//                     strokeWidth: 10,
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       '$_minutes:${_seconds.toString().padLeft(2, '0')}',
//                       style:
//                           TextStyle(fontSize: 60, color: Colors.grey.shade600),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.play_arrow,
//                     color: Colors.blue.shade400,
//                   ),
//                   onPressed: _isRunning ? null : _startTimer,
//                   iconSize: 60,
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.stop,
//                     color: Colors.blue.shade500,
//                   ),
//                   onPressed: _stopTimer,
//                   iconSize: 60,
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.refresh,
//                     color: Colors.blue.shade400,
//                   ),
//                   onPressed: _resetTimer,
//                   iconSize: 60,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _stopTimer();
//     super.dispose();
//   }
// }
