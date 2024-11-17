// import 'package:demo_app/constants/linker.dart';
// import 'package:demo_app/widgets/text-widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:fl_chart/fl_chart.dart';

import 'package:ecare/constants/linker.dart';

class PerformanceChart extends StatefulWidget {
  const PerformanceChart({super.key});

  @override
  State<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart> {
  TextEditingController nameController = TextEditingController();

  // Example data
  int totalAppsInstalled = 120;
  int totalCardsPurchased = 45;
  List<String> userNames = ['John Doe', 'Jane Smith', 'Mike Johnson'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BoldTextWidgetTheme(text: 'Performance Chart'),
            SizedBox(height: 10.h),

            // Bar Chart
            SizedBox(
              height: 300.h,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: totalAppsInstalled.toDouble(),
                          color: Colors.blue,
                          width: 20,
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: totalCardsPurchased.toDouble(),
                          color: Colors.green,
                          width: 20,
                        )
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Apps Installed');
                            case 1:
                              return const Text('Cards Purchased');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Total number of apps installed
            BoldTextWidgetTheme(
                text: 'Total Apps Installed: $totalAppsInstalled'),
            SizedBox(height: 10.h),

            // Total number of cards purchased through the link
            BoldTextWidgetTheme(
                text: 'Total Cards Purchased: $totalCardsPurchased'),
            SizedBox(height: 10.h),

            // Display the names of users who installed the app
            BoldTextWidgetTheme(text: 'Users Installed:'),
            SizedBox(height: 5.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userNames.map((userName) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    userName,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
