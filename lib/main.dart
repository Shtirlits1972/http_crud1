import 'package:flutter/material.dart';
import 'model/country/country_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Http Crud-1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CountryForm(),
    );
  }
}
