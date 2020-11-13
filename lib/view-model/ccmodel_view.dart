

import 'package:flutter/cupertino.dart';

class CCModelView extends ChangeNotifier {

  final String ccnumber;
  final String brand;
  final String type;
  final String level;
  final String bank;
  final String website;
  final String number;
  final String bin;
  final String country;
  final String isoCountry;
  final bool   valid;
  String postalCode;


  CCModelView({
    this.ccnumber,
    this.brand,
    this.type,
    this.level,
    this.bank,
    this.website,
    this.number,
    this.bin,
    this.country,
    this.valid,
    this.isoCountry,
    this.postalCode = '-'
  });

}