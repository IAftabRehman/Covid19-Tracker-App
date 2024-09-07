import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tracker_app/Models/world_states_model.dart';
import 'package:tracker_app/Services/URL/urls.dart';


class stateServices {

  Future<WorldStatesModel> worldStateRecords() async{
    final response = await http.get(Uri.parse(urls.worldStatesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi() async{
    var data;
    final response = await http.get(Uri.parse(urls.countriesList));

    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception('Error');
    }
  }
}