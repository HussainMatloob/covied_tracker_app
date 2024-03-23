import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices StatesServic = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: SearchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "Search with country name",
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: StatesServic.fetchCountriesname(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                      title: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 89,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (SearchController.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    name:snapshot.data![index]['country'],
                                                  image: snapshot.data![index]['countryInfo']['flag'],
                                                  totalCases: snapshot.data![index]['cases'],
                                                  totalDeaths: snapshot.data![index]['deaths'],
                                                  totalRecovered: snapshot.data![index]['recovered'],
                                                  active: snapshot.data![index]['active'],
                                                  critical: snapshot.data![index]['critical'],
                                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                                  test: snapshot.data![index]['tests'],)));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  ),
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                SearchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(name:snapshot.data![index]['country'],
                                                      image: snapshot.data![index]['countryInfo']['flag'],
                                                      totalCases: snapshot.data![index]['cases'],
                                                      totalDeaths: snapshot.data![index]['deaths'],
                                                      totalRecovered: snapshot.data![index]['recovered'],
                                                      active: snapshot.data![index]['active'],
                                                      critical: snapshot.data![index]['critical'],
                                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                                      test: snapshot.data![index]['tests'],)));
                                      }
                                    },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
