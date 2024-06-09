import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Twin',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DigitalTwinPage(),
    );
  }
}

class DigitalTwinPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Twin'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    'Weekly',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Monthly'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Yearly'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back),
                Text('Mar 24 - Mar 30, 2024'),
                Icon(Icons.arrow_forward),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      InfoCard(
                        title: 'Spark Points',
                        value: '1002',
                        icon: Icons.emoji_events,
                        isBig: true,
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 2,
                        children: [
                          InfoCard(
                            title: 'Distance Ran',
                            value: '101km',
                            icon: Icons.directions_run,
                            isBig: false,
                          ),
                          InfoCard(
                            title: 'Step Count',
                            value: '101km',
                            icon: Icons.directions_walk,
                            isBig: false,
                          ),
                          InfoCard(
                            title: 'Total Calories',
                            value: '20,402',
                            icon: Icons.local_fire_department,
                            isBig: false,
                          ),
                          InfoCard(
                            title: 'Average Heartrate',
                            value: '101km',
                            icon: Icons.favorite,
                            isBig: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ChartCard(title: 'Distance chart', chart: DistanceChart(), height: 250),
                      ChartCard(title: 'Steps chart', chart: StepsChart(), height: 250),
                      ChartCard(title: 'Calories chart', chart: CaloriesChart(), height: 300),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isBig;

  const InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    this.isBig = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: isBig ? 150 : 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: isBig ? 48 : 24),
                  SizedBox(width: 8.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: isBig ? 24 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                value,
                style: TextStyle(fontSize: isBig ? 32 : 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final String title;
  final Widget chart;
  final double height;

  const ChartCard({
    required this.title,
    required this.chart,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: height,
            child: chart,
          ),
        ],
      ),
    );
  }
}

class DistanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true, getTitles: (value) {
              return value % 5 == 0 ? '${value.toInt()}km' : '';
            }),
            bottomTitles: SideTitles(showTitles: true, getTitles: (value) {
              switch (value.toInt()) {
                case 0:
                  return 'Sun';
                case 1:
                  return 'Mon';
                case 2:
                  return 'Tue';
                case 3:
                  return 'Wed';
                case 4:
                  return 'Thu';
                case 5:
                  return 'Fri';
                case 6:
                  return 'Sat';
              }
              return '';
            }),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 2),
                FlSpot(1, 5),
                FlSpot(2, 10),
                FlSpot(3, 7),
                FlSpot(4, 5),
                FlSpot(5, 4),
                FlSpot(6, 6),
              ],
              isCurved: true,
              colors: [Colors.red],
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.red.withOpacity(0.3)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StepsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: SideTitles(showTitles: true, getTitles: (value) {
              return value % 1000 == 0 ? '${value.toInt()}' : '';
            }),
            bottomTitles: SideTitles(showTitles: true, getTitles: (value) {
              switch (value.toInt()) {
                case 0:
                  return 'Sun';
                case 1:
                  return 'Mon';
                case 2:
                  return 'Tue';
                case 3:
                  return 'Wed';
                case 4:
                  return 'Thu';
                case 5:
                  return 'Fri';
                case 6:
                  return 'Sat';
              }
              return '';
            }),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1000),
                FlSpot(1, 2000),
                FlSpot(2, 1500),
                FlSpot(3, 3000),
                FlSpot(4, 2000),
                FlSpot(5, 1000),
                FlSpot(6, 4000),
              ],
              isCurved: true,
              colors: [Colors.purple],
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.purple.withOpacity(0.3)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CaloriesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 4000,
                  color: Colors.red,
                  title: '',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 3000,
                  color: Colors.pink,
                  title: '',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 5000,
                  color: Colors.orange,
                  title: '',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 4500,
                  color: Colors.yellow,
                  title: '',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 3500,
                  color: Colors.green,
                  title: '',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 2000,
                  color: Colors.blue,
                  title: '',
                  radius: 40,
                ),
                PieChartSectionData(
                  value: 1500,
                  color: Colors.purple,
                  title: '',
                  radius: 40,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0), // Reduced padding
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LegendItem(color: Colors.red, text: 'Sunday'),
                  LegendItem(color: Colors.pink, text: 'Monday'),
                  LegendItem(color: Colors.orange, text: 'Tuesday'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LegendItem(color: Colors.yellow, text: 'Wednesday'),
                  LegendItem(color: Colors.green, text: 'Thursday'),
                  LegendItem(color: Colors.blue, text: 'Friday'),
                  LegendItem(color: Colors.purple, text: 'Saturday'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
