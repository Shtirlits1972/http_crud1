import 'package:http_crud1/Ut.dart';
import 'country.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CountryCrud {
  final String host = Ut.host;

  Future<List<Country>> getData() async {
    List<Country> list = List<Country>();

    try {
      var response = await http.get(Uri.http(host, '/Country/GetData'));

      if (response.statusCode == 200) {
        var allData = (json.decode(response.body) as List<dynamic>);
        print(allData);
        allData.forEach((dynamic val) {
          if (val['countryName'] != null && val['id'] != null) {
            var record =
                Country(id: val['id'], countryName: val['countryName']);
            list.add(record);
          }
        });
      } else {
        print(response.statusCode);
      }
    } on Exception catch (exception) {
      print('exception: $exception');
    } catch (error) {
      print('error: $error');
    }

    return list;
  }

  Future<Country> add(String countryName) async {
    final response = await http.post(
      Uri.http(host, '/Country/Add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'id': '0', 'countryName': countryName}),
    );

    if (response.statusCode == 200) {
      return Country.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to create country.');
      return null;
    }
  }

  Future<bool> delete(int id) async {
    final response =
        await http.post(Uri.http(host, '/Country/Del', {'id': id.toString()}));

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete country.');
    }
    return false;
  }
}
