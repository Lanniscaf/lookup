

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
  final CardType company;
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
    this.postalCode = '-',
    this.company
  });

}

CardType _getCardType(String cc) {
  if(cc[0] == '5') return CardType.Mastercard;
  if(cc[0] == '4') return CardType.Visa;
  if(cc[0] == '3') return CardType.Amex;

  // * By default returns the uknown Type
  return CardType.Unknown;
}

// ! CardType is a Card Category
enum CardType {
  Mastercard,
  Visa,
  Amex,
  Unknown
}