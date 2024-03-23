import 'package:covid_tracker_app/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,test;
  DetailScreen({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5233),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(

          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            PieChart(
              dataMap: {
                "Total":  double.parse(widget.totalCases.toString()),
                "Recovered": double.parse(widget.totalRecovered.toString()),
                "Deaths": double.parse(widget.totalDeaths.toString()),
              },
              chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true
              ),
              chartRadius:
              MediaQuery.of(context).size.width / 3.2,
              legendOptions: const LegendOptions(
                legendPosition: LegendPosition.left,
              ),
              animationDuration:
              const Duration(milliseconds: 1200),
              chartType: ChartType.ring,
              colorList: colorList,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
                      child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.06,),
                          ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                          ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                          ReuseableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                          ReuseableRow(title: 'Active', value: widget.active.toString()),
                          ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                          ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                          ReuseableRow(title: 'Test', value: widget.test.toString())
                        ],
                      ),
                                      ),
                    ),

                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
