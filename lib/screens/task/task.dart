import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task/ads/bottom_banner_ad.dart';
import 'package:task/ads/interstitial_with_mediation.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/base/base_screen.dart';

import 'package:task/screens/task/components/date_item.dart';
import 'package:task/screens/task/components/detail_description.dart';
import 'package:task/screens/task/components/detail_item.dart';
import 'package:task/screens/task/components/notes_item.dart';
import 'package:task/services/task_service.dart';
import 'package:task/services/task_storage_service.dart';
import 'package:task/theme/manager_theme.dart';
import 'package:toastification/toastification.dart';

class TaskDetailsPage extends StatefulWidget {
  TaskDetailsPage({Key? key, required this.task, required this.getTasks})
      : super(key: key);
  final Task task;
  final Function getTasks;
  @override
  _TaskDetailsPageState createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final themeModeManager = ThemeModeManager();

  Future<void> deleteTaskById(BuildContext context) async {
    try {
      await TaskStorageService.removeTask(widget.task.id);
      backToScreen(context);
      showMessageNewTaskRegister(context);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }

  void backToScreen(context) {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BaseScreen(
          themeModeManager: themeModeManager,
        ),
      ),
    );
  }

  void showMessageNewTaskRegister(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 2),
      title: const Text('Atividade removida!'),
      description: RichText(
          text: const TextSpan(text: 'A atividade foi removida com sucesso!')),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(
        Icons.check,
        size: 34,
      ),
      primaryColor: Colors.blue.shade500,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(14),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: FractionallySizedBox(
            heightFactor: 0.22,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Deseja mesmo excluir a atividade?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(40),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red.shade300,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.red.shade300),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade300,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => deleteTaskById(context),
                          child: const Text('Confirmar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color get backgroundColor => ThemeModeManager.isDark
      ? Colors.grey.shade900
      : const Color.fromARGB(255, 240, 245, 249);

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(widget.task.date);
    String formattedTime = DateFormat('HH:mm').format(widget.task.date);

    return WillPopScope(
      onWillPop: () async {
        await InterstitialWithMediation.instance.show();
        widget.getTasks();
        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.grey,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.notifications,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () => _showFilterModal(context),
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.red.shade300,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: const BottomBannerAd(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                TaskTitleColumn(task: widget.task),
                const SizedBox(height: 10),
                TaskDescriptionColumn(task: widget.task),
                const SizedBox(height: 10),
                TaskDateTimeColumn(
                  date: formattedDate,
                  time: formattedTime,
                  task: widget.task,
                ),
                const SizedBox(height: 10),
                // const TaskNotesColumn(
                //   notes:
                //       'Esta é uma descrição da tarefa. Aqui você pode adicionar notas e detalhes adicionais sobre a tarefa.',
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
