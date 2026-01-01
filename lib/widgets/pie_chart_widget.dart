import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, int> breakdown;

  const PieChartWidget({
    super.key,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    final entries = breakdown.entries.toList();
    final sections = entries
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final categoryEntry = entry.value;
          final total = breakdown.values.fold<int>(0, (a, b) => a + b);
          final percentage = (categoryEntry.value / total * 100).toStringAsFixed(1);

          return PieChartSectionData(
            color: colors[index % colors.length],
            value: categoryEntry.value.toDouble(),
            title: '$percentage%',
            radius: 100,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        })
        .toList();

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          sectionsSpace: 2,
        ),
      ),
    );
  }
}
