import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker/api/models/item_model.dart';
import 'package:flutter_budget_tracker/components/widgets/charts/indicator.dart';
import 'package:flutter_budget_tracker/utils/color.dart';

import 'chart_base.dart';

class ChartPie extends StatelessWidget {
  final List<ItemModel> items;

  const ChartPie({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spending = <String, double>{};

    for (final item in items) {
      spending.update(
        item.category,
        (value) => value + item.price,
        ifAbsent: () => item.price,
      );
    }

    return ChartBase(
      chart: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: spending
                    .map((category, amountSpent) => MapEntry(
                          category,
                          PieChartSectionData(
                            titleStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            color: getColor(category),
                            radius: 100.0,
                            title: '\$${amountSpent.toStringAsFixed(2)}',
                            value: amountSpent,
                          ),
                        ))
                    .values
                    .toList(),
                sectionsSpace: 0,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: spending.keys
                .map((category) => Indicator(
                      color: getColor(category),
                      text: category,
                      textColor: Colors.white,
                      isSquare: false,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
