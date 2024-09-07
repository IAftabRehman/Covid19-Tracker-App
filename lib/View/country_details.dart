import 'package:flutter/material.dart';

class country_details extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered;
  country_details({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
  });

  @override
  State<country_details> createState() => _country_detailsState();
}

class _country_detailsState extends State<country_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Covid 19", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.image),
          ),
          SizedBox(height: 20),
          Text(widget.name, style: TextStyle(fontSize: 30, color: Colors.white),),
          SizedBox(height: 40),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      RecallRow(title: "Cases", value: widget.totalCases.toString()),
                      RecallRow(title: "Deaths", value: widget.totalDeaths.toString()),
                      RecallRow(title: "Recovered", value: widget.totalRecovered.toString()),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
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

