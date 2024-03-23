import 'dart:convert';

import 'package:covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:covid_tracker_app/Services/Utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StateServices
{
  Future<WorldStatesModel> fetchWorldStatesRecords()
  async{
    var data;
    final response=await http.get(Uri.parse(AppUrl.worldStatesApi));
    data=jsonDecode(response.body.toString());
    if(response.statusCode==200)
      {
        data=jsonDecode(response.body.toString());
        return WorldStatesModel.fromJson(data);
      }
    else
      {
         throw Exception("Error");
      }
}


  Future<List<dynamic>> fetchCountriesname()
  async{
    var datacountry;
    final response=await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200)
    {
      datacountry=jsonDecode(response.body.toString());
      return datacountry;
    }
    else
    {
      throw Exception("Error");
    }
  }

}