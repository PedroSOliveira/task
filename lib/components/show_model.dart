import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:task/constants/app_style.dart';
import 'package:task/provider/radio_provider.dart';
import 'package:task/widget/date_time_widget.dart';
import 'package:task/widget/radio_widget.dart';
import 'package:task/widget/text_field_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  const AddNewTaskModel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioCategory = ref.watch(radioProvider);
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
              const Expanded(
                child: RadioWidget(
                  categoryColor: Colors.green,
                  titleRadio: 'Trabalho',
                  valueInput: 1,
                ),
              ),
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.blue.shade700,
                  titleRadio: 'Estudos',
                  valueInput: 2,
                ),
              ),
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.amberAccent.shade700,
                  titleRadio: 'Saúde',
                  valueInput: 3,
                ),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: 'Data',
                valueText: 'dd/mm/yy',
                icon: CupertinoIcons.calendar,
              ),
              Gap(22),
              DateTimeWidget(
                titleText: 'Hora',
                valueText: 'hh: mm',
                icon: CupertinoIcons.clock,
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
                  onPressed: () {},
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
