import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task/constants/app_style.dart';
import 'package:task/provider/date_time_provider.dart';
import 'package:task/provider/radio_provider.dart';
import 'package:task/widget/date_time_widget.dart';
import 'package:task/widget/radio_widget.dart';
import 'package:task/widget/text_field_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  const AddNewTaskModel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Nova atividade",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
          const TextFieldWidget(maxLine: 1, hintText: "Título da atividade"),
          const Gap(12),
          const Text(
            "Descrição",
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          const TextFieldWidget(maxLine: 5, hintText: "Adicione uma descrição"),
          const Gap(12),
          const Text('Categoria', style: AppStyle.headingOne),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.green,
                  titleRadio: 'Trabalho',
                  valueInput: 1,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.blue.shade700,
                  titleRadio: 'Estudos',
                  valueInput: 2,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.amberAccent.shade700,
                  titleRadio: 'Saúde',
                  valueInput: 3,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 3),
                ),
              )
            ],
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
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.blue.shade800),
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
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // side: BorderSide(color: Colors.blue.shade800),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text('Salvar'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
