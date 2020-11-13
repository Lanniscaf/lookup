import 'package:lookup/services/abstract/address_abstract.dart';
import 'package:http/http.dart' as http;
import 'package:beautifulsoup/beautifulsoup.dart';


class AddressGenerator extends AddressGeneratorClass {
  
  final String _api = 'fake-it.ws';

  @override
  Future<String> getPostalFromCountryISO(String countryIso) async {
    try {
      // * Zip Code From ISO COUNTRY
      String postalCode;

      final _url = 'http://$_api/${countryIso.toLowerCase().replaceAll(' ', '')}';
      final _res = await http.get(_url, headers: {"User-Agent": "PostmanRuntime/7.26.5"});

      final soup = Beautifulsoup(_res.body);
      final dataTable = soup('tbody');
      
      final rows = dataTable.children;

      for( var tr in rows ) {
        var ths = tr.querySelectorAll('th');

        if(ths[0].text.contains('Postcode')){
          postalCode = tr.querySelectorAll('td')[0].text;
        }
        if(ths[1].text.contains('Postcode')){
          postalCode = tr.querySelectorAll('td')[1].text;
        }
      }
      
      return postalCode;
    } catch(e){
      print(e);
      return null;
    }
  }

}