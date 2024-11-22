import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task/ads/interstitial_with_mediation.dart';
import 'package:task/constants/app_style.dart';
import 'package:task/models/task.dart';
import 'package:task/provider/date_time_provider.dart';
import 'package:task/provider/loading_save_task.dart';
import 'package:task/provider/radio_provider.dart';
import 'package:task/screens/home/components/category_tile.dart';
import 'package:task/services/task_service.dart';
import 'package:task/services/task_storage_service.dart';
import 'package:task/theme/manager_theme.dart';
import 'package:task/utils/generate_id_storage.dart';
import 'package:task/widget/date_time_widget.dart';
import 'package:task/widget/text_field_widget.dart';
import 'package:toastification/toastification.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel(
      {super.key,
      required TextEditingController this.fieldTitleController,
      required TextEditingController this.fieldDescriptionController,
      required this.getTasks,
      required this.user});
  final Function getTasks;

  final TextEditingController fieldTitleController;
  final TextEditingController fieldDescriptionController;
  final TaskStorageService taskService = TaskStorageService();
  final selectedCategoryProvider = StateProvider<String>((ref) => '');
  final loading = StateProvider<bool>((ref) => false);

  final String user;

  List<String> categories = [
    'Trabalho',
    'Entretenimento',
    'Estudo',
    'Viagem',
    'Pessoal'
  ];

  String selectedCategory = 'Trabalho';

  void showMessageNewTaskRegister(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 2),
      title: const Text('Atividade cadastrada!'),
      description: RichText(text: TextSpan(text: fieldTitleController.text)),
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

  void showMessageWarningEmptyFields(BuildContext context) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.simple,
      autoCloseDuration: const Duration(seconds: 2),
      title: const Text('Campos vazios! Preencha os campos.'),
      description: RichText(
          text: const TextSpan(
              text: 'Preencha o(s) campo(s) e tente novamente!')),
      alignment: Alignment.topRight,
      animationDuration: const Duration(milliseconds: 400),
      icon: const Icon(
        Icons.check,
        size: 34,
      ),
      primaryColor: Colors.yellow.shade400,
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

  Timestamp convertDateToTimestamp(String date) {
    final formattedDate = DateFormat('dd/MM/yyyy').parse(date);

    return Timestamp.fromDate(formattedDate);
  }

  Timestamp convertTimeToTimestamp(String time) {
    final formattedTime = DateFormat('HH:mm').parse(time);

    return Timestamp.fromDate(formattedTime);
  }

  void saveNewTask(BuildContext context, WidgetRef ref, String category,
      String date, String time) async {
    try {
      bool isEmptyFields = _verifyFieldsIsEmpty();

      _setLoading(ref, true);

      if (isEmptyFields) {
        showMessageWarningEmptyFields(context);
      } else {
        Task task = convertNewTaskRegister(category, date, time);

        task.id = generateUniqueId();
        TaskStorageService.addTask(task);

        showMessageNewTaskRegister(context);

        await InterstitialWithMediation.instance.show();

        getTasks();

        closeModal(context);
      }
    } catch (error) {
      print(error);
    } finally {
      _setLoading(ref, false);
    }
  }

  Task convertNewTaskRegister(String category, String date, String time) {
    final dateTimestamp = convertDateToTimestamp(date);
    final timeTimestamp = convertTimeToTimestamp(time);

    final combinedTimestamp = Timestamp(
      dateTimestamp.seconds + timeTimestamp.seconds,
      dateTimestamp.nanoseconds,
    );

    final convertTime =
        combinedTimestamp.toDate().add(const Duration(hours: -3));

    final Timestamp adjustedTimestamp = Timestamp.fromDate(convertTime);

    Task task = Task(
      title: fieldTitleController.text,
      description: fieldDescriptionController.text,
      category: category,
      date: date,
      isDone: false,
      notes: [],
      user: user,
      id: '',
    );

    return task;
  }

  void closeModal(context) {
    Navigator.of(context).pop();
  }

  void _selectedOptionCategory(WidgetRef ref, String category) {
    ref.read(radioProvider.notifier).update((state) => category);
  }

  void _setLoading(WidgetRef ref, bool isLoading) {
    ref.read(loadingProvider.notifier).update((state) => isLoading);
  }

  bool _verifyFieldsIsEmpty() {
    if (fieldTitleController.text.isEmpty ||
        fieldDescriptionController.text.isEmpty) {
      return true;
    }
    return false;
  }

  Color get contentBackgroundColor =>
      ThemeModeManager.isDark ? Colors.grey.shade900 : Colors.white;

  Color get textTitleColor =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.grey;

  Color get buttonCancelBackground =>
      ThemeModeManager.isDark ? Colors.grey.shade500 : Colors.white;

  Color get buttonCancelTextColor =>
      ThemeModeManager.isDark ? Colors.grey.shade800 : Colors.blue.shade800;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);
    final categoryProv = ref.watch(radioProvider);
    final isLoading = ref.watch(loadingProvider);

    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        color: contentBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Nova atividade",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textTitleColor,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Text(
            "Titulo da atividade",
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            maxLine: 1,
            hintText: "Título da atividade",
            controller: fieldTitleController,
          ),
          const Gap(12),
          const Text(
            "Descrição",
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            maxLine: 5,
            hintText: "Adicione uma descrição",
            controller: fieldDescriptionController,
          ),
          const Gap(12),
          const Text('Categoria', style: AppStyle.headingOne),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return CategoryTile(
                  category: categories[index],
                  isSelected: categoryProv == categories[index],
                  onPressed: () =>
                      _selectedOptionCategory(ref, categories[index]),
                );
              },
              separatorBuilder: (_, index) => const SizedBox(
                width: 15,
              ),
              itemCount: categories.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                  titleText: 'Data',
                  valueText: dateProv,
                  icon: CupertinoIcons.calendar,
                  onTap: () async {
                    final getValue = await showDatePicker(
                      // locale: const Locale("pt", "BR"),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    );
                    if (getValue != null) {
                      final format = DateFormat('dd/MM/yyyy');
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  }),
              Gap(22),
              DateTimeWidget(
                titleText: 'Hora',
                valueText: ref.watch(timeProvider),
                icon: CupertinoIcons.clock,
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonCancelBackground,
                    foregroundColor: buttonCancelTextColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: buttonCancelTextColor),
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
                    backgroundColor: !isLoading
                        ? Colors.blue.shade800
                        : Colors.grey.shade400,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // side: BorderSide(color: Colors.blue.shade800),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          saveNewTask(
                              context, ref, categoryProv, dateProv, timeProv);
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('Salvar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
