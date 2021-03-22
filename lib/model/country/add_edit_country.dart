import 'package:flutter/material.dart';
import 'package:http_crud1/model/country/country_crud.dart';
import 'package:http_crud1/model/country/country.dart';
import 'package:http_crud1/Ut.dart';

class CountryAddEditForm extends StatefulWidget {
  CountryAddEditForm({Key key}) : super(key: key);

  @override
  _CountryAddEditFormState createState() => _CountryAddEditFormState();
}

class _CountryAddEditFormState extends State<CountryAddEditForm> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add new Country'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Contry Name',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter name of new country',
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 3)),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: () {
                var newCountry = addCountry(controller.text);

                if (newCountry != null) {
                  Navigator.pop(context, true);
                }
              },
              child: Icon(Icons.save),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Icon(Icons.cancel),
            )
          ],
        ),
      ),
    );
  }

  addCountry(String countryName) async {
    CountryCrud crud = CountryCrud();
    Country result = await crud.add(countryName);

    print(result.toString());
    Ut.countries = await crud.getData();
    int y = 0;
  }
}
