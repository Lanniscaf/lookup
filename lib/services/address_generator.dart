import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lookup/model/fake_data_model.dart';
import 'package:lookup/services/abstract/address_abstract.dart';
import 'package:http/http.dart' as http;
import 'package:beautifulsoup/beautifulsoup.dart';


class AddressGenerator extends AddressGeneratorClass {
  
  @override
  Future getCountryDataISO2(String iso2) async {
    iso2 = iso2.toLowerCase().replaceAll(' ', '');
    final String data = await  rootBundle.loadString('assets/data/url_providers.json');
    Map enlaces = jsonDecode(data);

    String toSearch = enlaces[iso2];
    if(toSearch == null) return null;

    final body = await http.get(toSearch, headers: {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36"},);
    final soup = Beautifulsoup(body.body);

    // ? This variable have all the relevant content of the page.
    var _askjnd = soup.find_all('div.row.detail.no-margin.no-padding');
    var content = _askjnd[0].children[1].children;

    int items = content.length;
    int dif = 31 - items;


    // ! Critical
    String personName;
    String personGender;
    String personPhoneNumber;
    String personBirthday;
    String randomAddress;
    String cityTown;
    String state;
    String postalCode;
    String country;
    String dialingCode;

    for(int i=0; i < content.length; i++){
      var row = content[i];
      try { 
        if(row.children[0].firstChild.text.contains('Full Name')){
          personName = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Gender')){
          personGender = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Phone Number')){
          personPhoneNumber = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Birthday')){
          personBirthday = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Street')){
          randomAddress = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('City')){
          cityTown = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('State')){
          state = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Zip Code')){
          postalCode = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Country')){
          country = (row.children[1].firstChild.firstChild.attributes['value']);
        } else if(row.children[0].firstChild.text.contains('Dialing Code')){
          dialingCode = (row.children[1].firstChild.firstChild.attributes['value']);
        }
      } catch(e){
      } 
    }
    
    final _personData = Person(fullName: personName ?? '-', gender: personGender ?? '-', phone: personPhoneNumber ?? '-', birthday: personBirthday ?? '-');
    final FakeData _fakeData = new FakeData(
      person      : _personData    ?? '-',
      street      : randomAddress  ?? '-',
      city        : cityTown       ?? '-',
      state       : state          ?? '-',
      zipCode     : postalCode     ?? '-',
      countryName : country        ?? '-',
      phoneCode   : dialingCode    ?? '-'
    );
    return _fakeData;
  }
  
  _getterData(int position, content){
    try {
      return (content[position].children[1].firstChild.firstChild.attributes['value']);
    } catch(e){
      return null;
    }
  }



}