import 'package:flutter/material.dart';
import 'package:lookup/get_it.dart';
import 'package:lookup/services/address_generator.dart';
import 'package:lookup/services/bin_provider.dart';
import 'package:lookup/view-model/ccmodel_view.dart';
import 'package:lookup/views/home_view.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class SearchViewModel extends ChangeNotifier {

  bool isLoading = false;
  TextEditingController binController = TextEditingController();
  final GlobalKey<NavigatorState> navigator = getIt<NAVIGATOR>().navigateKey;
  final RegExp filterLetters = new RegExp('([a-zA-Z])+');
  
  SearchViewModel();
  final AddressGenerator _addressProvider = new AddressGenerator();

  String validate(String value){
    if(value.isEmpty) return 'Please write a bin';
    if(value == null) return 'Please write a bin';
    if(value.contains(filterLetters)) return 'Please write a bin';
    if(value.length < 6) return 'The bin can\'t be less than 6 char';
    //if(value.substring(0,1) == '1' || value.substring(0,1) == '2') return 'Invalid bin';

    return null;
  }

  Future getBinInfo() async {
    if(validate(binController.value.text) != null) return;
    if(isLoading == true) return;
    isLoading = true;
    notifyListeners();
    final CCModelView response = await BinProvider.getBinData(binController.text);
    final String postCode      = await _addressProvider.getPostalFromCountryISO(response.isoCountry);
    response.postalCode = postCode ?? '-';
    isLoading = false;
    notifyListeners();

    binController.clear();
    if(response == null){
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('[X] Invalid Bin ${binController.text} '),
        )
      );
      return;
    }
    navigator.currentState.push(
      MaterialPageRoute(
        builder: (BuildContext context) => HomeView(ccmodel: response,),
      )
    );

  }


}