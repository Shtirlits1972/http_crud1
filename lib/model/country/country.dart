class Country {
  final int id;
  final String countryName;

  Country({this.id, this.countryName});

  @override
   String toString()
  {
     return '$id  $countryName';
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      countryName: json['countryName'],
    );
  }
}
