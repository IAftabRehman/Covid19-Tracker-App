import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tracker_app/Services/states_services.dart';
import 'package:tracker_app/View/country_details.dart';

class countries extends StatefulWidget {
  const countries({super.key});

  @override
  State<countries> createState() => _countriesState();
}

class _countriesState extends State<countries> {

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Center(child: Text("Covid 19", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: controller,
                    onChanged: (value){
                      setState(() {
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Search Country Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),
                  ),
                ),

                Expanded(
                  child: FutureBuilder(
                      future: stateServices().countriesListApi(),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                        if(!snapshot.hasData){
                          return ListView.builder(
                              itemCount: 8,
                              itemBuilder: (context, index){
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Container(height: 20, width: 80, color: Colors.black),
                                        subtitle: Container(height: 10, width: 80, color: Colors.black),
                                        leading: Container(height: 50, width: 80, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          );
                        }else{
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                              itemBuilder: (context, index){

                              String countryName = snapshot.data![index]['country'];
                               if(controller.text.isEmpty){
                                 return Column(
                                   children: [
                                     InkWell(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => country_details(
                                           image: snapshot.data![index]['countryInfo']['flag'],
                                           name: snapshot.data![index]['country'],
                                           totalCases: snapshot.data![index]['cases'],
                                           totalRecovered: snapshot.data![index]['recovered'],
                                           totalDeaths: snapshot.data![index]['deaths'],
                                         )));
                                       },
                                       child: ListTile(
                                         title: Text(snapshot.data![index]['country'], style: TextStyle(color: Colors.white)),
                                         subtitle: Text(snapshot.data![index]['cases'].toString(), style: TextStyle(color: Colors.white, fontSize: 15)),

                                         leading: Image(
                                             height: 50,
                                             width: 50,
                                             image: NetworkImage(
                                                 snapshot.data![index]['countryInfo']['flag']
                                             )),
                                       ),
                                     )
                                   ],
                                 );
                               }else if(countryName.toLowerCase().contains(controller.text.toLowerCase())){
                                 return Column(
                                   children: [
                                     InkWell(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => country_details(
                                           image: snapshot.data![index]['countryInfo']['flag'],
                                           name: snapshot.data![index]['country'],
                                           totalCases: snapshot.data![index]['cases'],
                                           totalRecovered: snapshot.data![index]['recovered'],
                                           totalDeaths: snapshot.data![index]['deaths'],
                                         )));
                                       },
                                       child: ListTile(
                                         title: Text(snapshot.data![index]['country'], style: TextStyle(color: Colors.white)),
                                         subtitle: Text(snapshot.data![index]['cases'].toString(), style: TextStyle(color: Colors.white, fontSize: 15)),

                                         leading: Image(
                                             height: 50,
                                             width: 50,
                                             image: NetworkImage(
                                                 snapshot.data![index]['countryInfo']['flag']
                                             )),
                                       ),
                                     )
                                   ],
                                 );
                               }else{
                                 return Container();
                               }
                              }
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
