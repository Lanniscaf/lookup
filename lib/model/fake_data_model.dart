class FakeData {

  String countryName;
  Person person;
  String street;
  String city;
  String state;
  String zipCode;
  String phoneCode;

  FakeData({
    this.countryName,
    this.person,
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.phoneCode,
  });



  @override
  String toString() {
    return """
    countryName: $countryName
    person: $person
    street: $street
    city: $city
    state: $state
    zipCode: $zipCode
    phoneCode: $phoneCode
    """;
  }

}


class Person {
  
  String fullName;
  String gender;
  String birthday;
  String phone;

  Person({this.birthday, this.fullName, this.gender, this.phone});

  factory Person.fromJson(Map<String, dynamic>json) => Person(
    fullName : json['name'],
    gender   : json['gender'],
    birthday : json['birthday'],
  );


}