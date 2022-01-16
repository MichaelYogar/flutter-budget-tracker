import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker/api/models/item_model.dart';
import 'package:flutter_budget_tracker/components/widgets/charts/chart_base.dart';

class ChartLine extends StatefulWidget {
  const ChartLine({Key? key, required this.items}) : super(key: key);

  final List<ItemModel> items;

  @override
  _ChartLineState createState() => _ChartLineState();
}

class _ChartLineState extends State<ChartLine> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return ChartBase(
      chart: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Color(0xff232d37)),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 55,
            height: 34,
            child: TextButton(
              onPressed: () {
              },
              child: const Text(
                'Total',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: paintGrid(),
      titlesData: getTitles(),
      borderData: paintBorder(),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: getData(widget.items),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

List<FlSpot> getData(List<ItemModel> data) {
  Map<double, double> dataMap = <double, double>{};
  for (final ItemModel item in data) {
    final month = item.purchaseDate.month.toDouble();
    if (dataMap.containsKey(month)) {
      dataMap[month] = item.price + dataMap[month]!;
    } else {
      dataMap[month] = item.price;
    }
  }
  return dataMap.entries
      .map((entry) => FlSpot(entry.key, entry.value / 100))
      .toList();
}

FlGridData paintGrid() => FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    );

FlBorderData paintBorder() => FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d), width: 1),
    );

FlTitlesData getTitles() => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'MAR';
            case 5:
              return 'JUN';
            case 8:
              return 'SEP';
          }
          return '';
        },
        margin: 8,
        interval: 1,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '100';
            case 3:
              return '300';
            case 5:
              return '500';
          }
          return '';
        },
        reservedSize: 32,
        interval: 1,
        margin: 12,
      ),
      topTitles: SideTitles(showTitles: false),
      rightTitles: SideTitles(showTitles: false),
    );
