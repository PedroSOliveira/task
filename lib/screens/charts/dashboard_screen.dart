import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task/components/button_purchase.dart';
import 'package:task/models/task.dart';
import 'package:task/services/task_service.dart';

class TaskStatisticsScreen extends StatefulWidget {
  const TaskStatisticsScreen();

  @override
  State<TaskStatisticsScreen> createState() => _TaskStatisticsScreenState();
}

class _TaskStatisticsScreenState extends State<TaskStatisticsScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TaskService _taskService = TaskService();
  int totalPendingTasks = 0;
  int totalDoneTasks = 0;
  int totalEntretenimento = 0;
  int totalEstudo = 0;
  int totalTrabalho = 0;
  int totalPessoal = 0;
  int totalEsporte = 0;
  int totalViagem = 0;

  int totalEntretenimentoPending = 0;
  int totalEstudoPending = 0;
  int totalTrabalhoPending = 0;
  int totalPessoalPending = 0;
  int totalEsportePending = 0;
  int totalViagemPending = 0;

  Future<void> _fetchTasks() async {
    try {
      setState(() {
        // isLoading = true;
      });
      List<Task> fetchedTasks =
          await _taskService.getTasks(auth.currentUser!.email!);

      getNumberOfCategoryTasks(fetchedTasks);
      getNumberOfCategoryAndPendingTasks(fetchedTasks);

      setState(() {
        totalDoneTasks = getNumberOfCompletedTasks(fetchedTasks);
        totalPendingTasks = getNumberOfPendingTasks(fetchedTasks);
      });
    } catch (e) {
      print('Error fetching tasks: $e');
    } finally {
      setState(() {
        // isLoading = false;
      });
    }
  }

  int getNumberOfCompletedTasks(List<Task> tasks) {
    int completedCount = tasks.where((task) => task.isDone).length;
    return completedCount;
  }

  int getNumberOfPendingTasks(List<Task> tasks) {
    int pendingCount = tasks.where((task) => !task.isDone).length;
    return pendingCount;
  }

  void getNumberOfCategoryTasks(List<Task> tasks) {
    int totalTrabalhoTaks =
        tasks.where((task) => task.category == 'Trabalho').length;
    int totalEstudoTaks =
        tasks.where((task) => task.category == 'Estudo').length;
    int totalViagemTaks =
        tasks.where((task) => task.category == 'Viagem').length;
    int totalEsporteTaks =
        tasks.where((task) => task.category == 'Esporte').length;
    int totalPessoalTaks =
        tasks.where((task) => task.category == 'Pessoal').length;
    setState(() {
      totalTrabalho = totalTrabalhoTaks;
      totalEstudo = totalEstudoTaks;
      totalViagem = totalViagemTaks;
      totalEsporte = totalEsporteTaks;
      totalPessoal = totalPessoalTaks;
    });
  }

  void getNumberOfCategoryAndPendingTasks(List<Task> tasks) {
    int totalTrabalhoTaks = tasks
        .where((task) => !task.isDone && task.category == 'Trabalho')
        .length;
    int totalEstudoTaks =
        tasks.where((task) => !task.isDone && task.category == 'Estudo').length;
    int totalViagemTaks =
        tasks.where((task) => !task.isDone && task.category == 'Viagem').length;
    int totalEsporteTaks = tasks
        .where((task) => !task.isDone && task.category == 'Esporte')
        .length;
    int totalPessoalTaks = tasks
        .where((task) => !task.isDone && task.category == 'Pessoal')
        .length;
    setState(() {
      totalTrabalhoPending = totalTrabalhoTaks;
      totalEstudoPending = totalEstudoTaks;
      totalViagemPending = totalViagemTaks;
      totalEsportePending = totalEsporteTaks;
      totalPessoalPending = totalPessoalTaks;
    });
  }

  Widget _buildStatisticWidget(String value, String label) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 245, 249),
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 240, 245, 249),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 14),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardPurchase(),
                const Gap(8),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatisticWidget(
                          totalPendingTasks.toString(), "Atividades pendentes"),
                    ),
                    const Gap(15),
                    Expanded(
                      child: _buildStatisticWidget(
                          totalDoneTasks.toString(), "Atividades realizadas"),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  height: 300,
                  child: Stack(children: [
                    const Text(
                      "Atividades por categoria",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BarChart(
                      BarChartData(
                        barTouchData: barTouchData,
                        titlesData: titlesData,
                        borderData: borderData,
                        barGroups: barGroups,
                        gridData: const FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 20,
                      ),
                    ),
                  ]),
                ),
                const Gap(15),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  height: 250,
                  child: Stack(children: [
                    const Text(
                      "Atividades pendentes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            // setState(() {
                            //   if (!event.isInterestedForInteractions ||
                            //       pieTouchResponse == null ||
                            //       pieTouchResponse.touchedSection == null) {
                            //     touchedIndex = -1;
                            //     return;
                            //   }
                            //   touchedIndex = pieTouchResponse
                            //       .touchedSection!.touchedSectionIndex;
                            // });
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(
                            totalDoneTasks,
                            totalTrabalhoPending,
                            totalEstudoPending,
                            totalViagemPending,
                            totalEsportePending,
                            totalPessoalPending),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Trabalho';
        break;
      case 1:
        text = 'Viagem';
        break;
      case 2:
        text = 'Estudo';
        break;
      case 3:
        text = 'Esporte';
        break;
      case 4:
        text = 'Pessoal';
        break;
      // case 5:
      //   text = 'Sab';
      //   break;
      // case 6:
      //   text = 'Dom';
      //   break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue.shade500,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: totalTrabalho.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: totalEstudo.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: totalViagem.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: totalEsporte.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: totalPessoal.toDouble(),
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 245, 249),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 240, 245, 249),
      ),
      body: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Mingguan',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Grafik konsumsi kalori',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      // child: TaskStatisticsScreen(),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
            )
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> showingSections(
  int totalDoneTasks,
  int totalTrabalhoPending,
  int totalEstudoPending,
  int totalViagemPending,
  int totalEsportePending,
  int totalPessoalPending,
) {
  return List.generate(6, (i) {
    final isTouched = i == 0;
    final fontSize = isTouched ? 16.0 : 16.0;
    final radius = isTouched ? 55.0 : 50.0;
    const shadows = [Shadow(color: Colors.white, blurRadius: 1)];
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: Colors.blue.shade200,
          value: totalDoneTasks != 0
              ? (totalTrabalhoPending / totalDoneTasks * 100).toDouble()
              : 0,
          title: 'Trab',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: Colors.blue.shade400,
          value: totalDoneTasks != 0
              ? (totalEstudoPending / totalDoneTasks * 100).toDouble()
              : 0,
          title: 'Estu',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: Colors.blue.shade600,
          value: totalDoneTasks != 0
              ? (totalViagemPending / totalDoneTasks * 100).toDouble()
              : 0,
          title: 'Viag',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: Colors.blue.shade800,
          value: totalDoneTasks != 0
              ? (totalEsportePending / totalDoneTasks * 100).toDouble()
              : 0,
          title: 'Espo',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 4:
        return PieChartSectionData(
          color: Colors.blue.shade900,
          value: totalDoneTasks != 0
              ? (totalPessoalPending / totalDoneTasks * 100).toDouble()
              : 0,
          title: 'Pess',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      case 5:
        return PieChartSectionData(
          color: Colors.blueAccent.shade400,
          value: totalDoneTasks != 0
              ? (totalPessoalPending / totalDoneTasks * 100).toDouble()
              : 0,
          title: 'Entr',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ),
        );
      default:
        throw Error();
    }
  });
}
