import 'package:beautifulsoup/beautifulsoup.dart';
import 'package:http/http.dart' as http;
import 'package:lookup/view-model/ccmodel_view.dart';

class BinProvider {

  static Future getBinData(String bin) async {
    try {
      final url = 'https://bincheck.io/bin/$bin';
      final res = await http.post(url, body: {});
      final decoded = res.body;

      var soup = Beautifulsoup(decoded);
      final detailsInRow = soup('table').children.first.children;
      
      final String brand       = _replaceSpace(detailsInRow[1].children[1].text) ?? '';
      final String type        = _replaceSpace(detailsInRow[2].children[1].text) ?? '';
      final String level       = _replaceSpace(detailsInRow[3].children[1].text) ?? '';
      final String issuerBank  = _replaceSpace(detailsInRow[4].children[1].text) ?? '';
      final String website     = _replaceSpace(detailsInRow[5].children[1].text) ?? '';
      final String phone       = _replaceSpace(detailsInRow[6].children[1].text) ?? '';
      final String countryName = _replaceSpace(detailsInRow[7].children[1].text) ?? '';
      final bool   isValid     = true;
      
      final CCModelView card = CCModelView(
        bank: issuerBank,
        bin: bin,
        brand: brand,
        ccnumber: '${bin.substring(0,4)}  ${bin.substring(4,6)}xx  xxxx  xxxx',
        country: countryName,
        level: level,
        number: phone,
        type: type,
        valid: isValid,
        website: website
      );

      return card;
    } catch(e){
      return null;
    }
  }





}

_replaceSpace(String text) {
  var splited = text.split(' ');
  String sentence = '';
  for( var word in splited){
    sentence += (word.replaceAll(' ', '')).replaceAll('\t', '');
    sentence += ' ';
  }
  return sentence;
}