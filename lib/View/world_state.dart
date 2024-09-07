import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tracker_app/Models/world_states_model.dart';
import 'package:tracker_app/Services/states_services.dart';
import 'package:tracker_app/View/countries.dart';

class worldState extends StatefulWidget {
  const worldState({super.key});

  @override
  State<worldState> createState() => _worldStateState();
}

class _worldStateState extends State<worldState> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    stateServices state_services = stateServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Covid 19", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 10),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .02),
                FutureBuilder(
                  future: state_services.worldStateRecords(),
                    builder: (context, AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                        flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                      );
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases!.toString(),),
                              "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                              legendTextStyle: TextStyle(
                                color: Colors.white,
                              )
                            ),
                            animationDuration: Duration(seconds: 2),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                            child: Card(
                              color: Colors.blue.withOpacity(.6),
                              child: Column(
                                children: [
                                  RecallRow(title: "Total", value: snapshot.data!.cases.toString()),
                                  RecallRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                  RecallRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => countries()));                          
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(6)
                                ),
                                child: Center(child: Text("Track Countries", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }
                  ),
              ],
            ),
          )
      ),
    );
  }
}


class RecallRow extends StatelessWidget {
  String title, value;
   RecallRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(value, style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

