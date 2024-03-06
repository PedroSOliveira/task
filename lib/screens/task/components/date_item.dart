import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart' as cdp;

class TaskDateTimeColumn extends StatelessWidget {
  final String date;
  final String time;

  const TaskDateTimeColumn({Key? key, required this.date, required this.time})
      : super(key: key);

  // void _showDatePicker(BuildContext context) async {
  //   final DateTime? pickedDate = await showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext builder) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.5,
  //         color: const Color.fromARGB(255, 240, 245, 249),
  //         child: Theme(
  //           data: ThemeData.light().copyWith(
  //             colorScheme: const ColorScheme.light(
  //               primary: Colors.blue, // Define a cor do texto e dos ícones
  //             ),
  //           ),
  //           child: CalendarDatePicker(
  //             initialDate: DateTime.now(),
  //             firstDate: DateTime(2000),
  //             lastDate: DateTime(2100),
  //             onDateChanged: (DateTime newDate) {
  //               Navigator.pop(context, newDate);
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );

  //   if (pickedDate != null) {
  //     print('Data selecionada: ${DateFormat('dd/MM/yyyy').format(pickedDate)}');
  //   }
  // }

  void _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), // Arredonda o canto superior esquerdo
            topRight: Radius.circular(20), // Arredonda o canto superior direito
          ),
          child: Container(
            color: const Color.fromARGB(255, 240, 245, 249),
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.blue, // Define a cor do texto e dos ícones
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateChanged: (DateTime newDate) {
                        Navigator.pop(context, newDate);
                      },
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    if (pickedDate != null) {
      print('Data selecionada: ${DateFormat('dd/MM/yyyy').format(pickedDate)}');
    }
  }

  void _showTimePicker(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.white,
              inversePrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      print('Hora selecionada: ${pickedTime.format(context)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showDatePicker(context),
            child: Row(
              children: [
                const Icon(
                  Icons.event,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Data',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showTimePicker(context),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Hora',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.notifications,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              const Text(
                'Lembrete',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 15,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(
                Icons.repeat,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              const Text(
                'Repetir',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
