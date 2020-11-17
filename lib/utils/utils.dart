

class Extrapolar {

  final String bin1;
  final String bin2;

  Extrapolar({this.bin1, this.bin2});

  // * Getters *
  List<String> get extrapolaciones {
    List<String>results = [];
    if(bin1.length < 15) return null;
    if(bin2.length >= 16){
      results.add(similitud());
      results.add(sofia());
      results.add(advance());
    }
    if(bin2.length < 16) {
      results.add(grupo1());
      results.add(normal5x());
      results.add(xie());
      results.add(xiie());
      results.add(xiiie());
      results.add(xiiiie());
    }

    return results;
  }


  // * Functions

  // ? 2 BIN METHODS
  String similitud(  ) {
  //
    String result='';
    if(!basiChk()) return null;
    for(int x=0; x < 16; x++) {
      if(bin1[x] == bin2[x]) result += bin1[x];
      else { result += 'x';}
    }
    return result;
  }

  String sofia(  ) {
    if(!basiChk()) return null;
    if(bin1[6] != bin2[6]) return null;
    String result='';
    List<String> strim = [
      bin1.substring(0,8),
      bin2.substring(8,)
    ];
    String ccmult='';
    for(int i=0; i < strim[0].length; i++) ccmult += (int.tryParse(strim[0][i]) * int.tryParse(strim[1][i])).toString();
    strim[0] += ccmult.substring(0,8);
    for(int i=0; i < bin1.length; i++) {
      if(bin1[i] == strim[0][i]) result += bin1[i];
      else { result += 'x'; }
    }
    if(result[15]=='x') result = result.substring(0,15) + '1';
    return result;
  }

  String advance(  ) {
    if(!basiChk()) return null;
    if(bin1.substring(6,8) != bin2.substring(6,8)) return null;
    String result = '';
    String cuerpo1 = bin1.substring(0,8);
    List<String> strim = [
      bin1.substring(9,11),
      bin2.substring(9,11)
    ];
    String mul1 = (int.tryParse(strim[0][0]) + int.tryParse(strim[0][1])).toString();
    String mul2 = (int.tryParse(strim[1][1]) + int.tryParse(strim[1][0])).toString();
    while (true) {
      if(mul1.length >= 2){
        mul1 = (int.tryParse(mul1[0]) + int.tryParse(mul1[1])).toString();
        continue;
      }
      else if(mul2.length >= 2){
        mul2 = (int.tryParse(mul2[0]) + int.tryParse(mul2[1])).toString();
        continue;
      } else { break; }
    }
    mul1 = (int.tryParse(mul1) / 2 ).toString();
    mul2 = (int.tryParse(mul2) / 2 ).toString();
    mul1 = ((double.tryParse(mul1) * 5 ).round()).toString();
    mul2 = ((double.tryParse(mul2) * 5 ).round()).toString();
    cuerpo1 += (int.tryParse(mul1)+int.tryParse(mul2)).toString();
    result = cuerpo1;
    for(int i=0; i<6; i++) result+='x';

    return result;
  }

  // ? 1 BIN Methods

  String grupo1(  ) {
    String result = '';
    if(!basiChk()) return null;
    result += bin1.substring(0,6) + bin1.substring(6,7)+'x'+bin1.substring(8,9)+'x'+bin1.substring(9,10)+'xx'+bin1.substring(12,13)+bin1.substring(13,14)+'x'+bin1.substring(15,);

    return result;
  }

  String normal5x(  ) {
    String result = '';
    if(!basiChk()) return null;
    result+= bin1.substring(0,11) + 'xxxxx';

    return result;
  }

  String xie(  ) {
    String result = '';
    if(!basiChk()) return null;
    result += bin1.substring(0,6)+'xxxx'+bin1.substring(10,14)+'xx';
    
    return result;
  }

  String xiie(  ) {
    String result = '';
    if(!basiChk()) return null;
    result += bin1.substring(0,10)+'xxxxx';

    return result;
  }

  String xiiie(  ) {
    String result = '';
    if(!basiChk()) return null;
    result += bin1.substring(0,7)+'x'+bin1.substring(8,9)+'xxx'+bin1.substring(12,14)+'xx';

    return result;
  }

  String xiiiie(  ) {
    String result = '';
    if(!basiChk()) return null;
    result += bin1.substring(0,7)+'xx'+bin1.substring(10,11)+'x'+bin1.substring(12,13)+'xxxx';

    return result;
  }

  bool basiChk(){
    if(bin1.length != 16 || bin2.length != 16) return false;
    if(bin1[0] == "3"    || bin2[0] == "3"   ) return false;
    if(bin1.substring(0,6) != bin2.substring(0,6)) return false;

    return true;
  }

}