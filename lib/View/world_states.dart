import 'package:covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  @override
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds:1), vsync: this)
        ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5233),
  ];

  Widget build(BuildContext context) {
    StateServices statesServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: Center(
                            child: SpinKitCubeGrid(
                              color: Colors.white,
                              size: 100,
                              controller: _controller,
                            ),
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),
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
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 5),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseableRow(
                                    title: 'Total',
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Recovered',
                                    value:   snapshot.data!.recovered.toString(),
                                  ),
                                  ReuseableRow(
                                    title: 'Deaths',
                                    value:   snapshot.data!.recovered.toString() ,
                                  ),
                                  ReuseableRow(
                                    title: 'Active',
                                    value:   snapshot.data!.active.toString() ,
                                  ),
                                  ReuseableRow(
                                    title: 'Critical',
                                    value:   snapshot.data!.critical.toString() ,
                                  ),
                                  ReuseableRow(
                                    title: 'Today Deaths',
                                    value:   snapshot.data!.todayCases.toString() ,
                                  ),
                                  ReuseableRow(
                                    title: 'Today Recovered',
                                    value:   snapshot.data!.todayRecovered.toString() ,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          GestureDetector(
                            onTap: ()
                            {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff1aa260),
                              ),
                              child: Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          Divider(
            height: 2,
          )
        ],
      ),
    );
  }
}
