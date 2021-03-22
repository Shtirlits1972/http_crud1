import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http_crud1/model/country/country.dart';
import 'add_edit_country.dart';
import 'country_crud.dart';
import 'package:http_crud1/Ut.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CountryForm extends StatefulWidget {
  CountryForm({Key key}) : super(key: key);

  @override
  _CountryFormState createState() => _CountryFormState();
}

class _CountryFormState extends State<CountryForm> {
  // ignore: deprecated_member_use
  // List<Country> countries = List<Country>();
  int selctIndex = -1;
  int selctId = 0;
  ScrollController scr = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список стран'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: getListBuilder(),
              ),
              flex: 15,
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            tooltip: 'Add new Country',
            onPressed: () {
              print('press Add button');
              addCountry();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            tooltip: 'Delete Country',
            onPressed: () async {
              if (selctIndex > -1) {
                if (await confirm(context,
                    title: Text('Warning'), content: Text('want to delete?'))) {
                  delete(selctId);
                  return print('pressedOK id = ' + selctIndex.toString());
                }
                return print('pressedCancel');
              } else {
                Fluttertoast.showToast(
                    msg: "Select Item For delete",
                    toastLength: Toast.LENGTH_SHORT,
                    // gravity: ToastGravity.CENTER,
                    // timeInSecForIosWeb: 1,
                    // backgroundColor: Colors.red,
                    // textColor: Colors.white,
                    // fontSize: 16.0
                    );
              }
            },
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            tooltip: 'Refresh data',
            onPressed: () {
              print('press refresh button');
              refresh();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  void delete(int id) async {
    CountryCrud crud = CountryCrud();
    bool isDelete = await crud.delete(id);

    if (isDelete) {
      selctIndex = -1;
      selctId = 0;
      refresh();
    }
  }

  void refresh() async {
    CountryCrud crud = CountryCrud();
    dynamic response = await crud.getData();

    setState(() {
      Ut.countries = response;
    });
  }

  void addCountry() {
    print('Add Country!');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountryAddEditForm(),
      ),
    );
  }

  Widget getListBuilder() {
    ListView listWiev = ListView.builder(
      itemCount: Ut.countries.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey.withOpacity(0.3),
          margin: EdgeInsets.only(top: 2),
          child: ListTile(
            leading: ClipRect(
              child: CircleAvatar(
                child: Text(
                  Ut.countries[index].id.toString(),
                ),
              ),
            ),
            title: Text(Ut.countries[index].countryName),
            selectedTileColor: Colors.blue.withOpacity(0.5),
            selected: (index == selctIndex) ? true : false,
            onTap: () {
              selctIndex = index;
              selctId = Ut.countries[index].id;
              refresh();
            },
          ),
        );
      },
    );
    return listWiev;
  }

  List<Widget> _buildList() {
    return Ut.countries
        .map(
          (Country f) => Container(
            padding: EdgeInsets.only(top: 2),
            child: ListTile(
              onTap: () {
                selctId = f.id;
              },
              selectedTileColor: Colors.lightGreen,
              tileColor: Colors.grey,
              title: Text(f.countryName),
              leading: ClipRect(
                child: CircleAvatar(
                  child: Text(
                    f.id.toString(),
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
  }
}
