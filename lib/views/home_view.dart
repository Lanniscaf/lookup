import 'package:flutter/material.dart';
import 'package:lookup/styles/fonts_styles.dart';
import 'package:lookup/view-model/ccmodel_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';



class HomeView extends StatelessWidget {

  final CCModelView _modelView = CCModelView();
  HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details', style: TextStyle(color: Colors.grey),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Icon(Icons.arrow_back_ios, color: Colors.grey,),
      ),
      body: ViewModelBuilder<CCModelView>.nonReactive(
        viewModelBuilder: () => _modelView,
        builder: (context, model, widget) => 
        ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget> [
            _cardItem(context, model),
            _cardDetails(context, model)
          ],
        ),
      ),
    );
  }

  Widget _cardItem(BuildContext context, CCModelView model) {
    final Size _sizing = MediaQuery.of(context).size;
    final Widget _card = ResponsiveBuilder(
      builder: (context, sizing) {
        return Stack(
          children: [
            Container(
              width : sizing.localWidgetSize.width * 0.8,
              height: sizing.localWidgetSize.height * 0.9,
              child: Image(
                image: AssetImage('assets/images/ccard.png'),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: sizing.localWidgetSize.width * 0.06,
              top: sizing.localWidgetSize.height * 0.17,
              child: Text(model.type, style: CREDITCARDTEXT,)
            ),
            
            Positioned(
              left: sizing.localWidgetSize.width * 0.06,
              bottom: sizing.localWidgetSize.height * 0.1,
              child: Text(model.bank, style: CREDITCARDTEXT.copyWith(fontSize: 17.0),)
            ),

            Positioned(
              left: sizing.localWidgetSize.width * 0.08,
              bottom: sizing.localWidgetSize.height * 0.22,
              child: Text(model.ccnumber, style: CREDITCARDTEXT.copyWith(letterSpacing: 2.0),)
            ),
              
          ],
        );
      }
    );
    return Container(
      width: _sizing.width,
      height: _sizing.height * 0.33,
      alignment: Alignment.topCenter,
      child: _card,
    );
  }

  Widget _cardDetails(BuildContext context, CCModelView model) {
    final Widget divider = Divider(thickness: 1.5,);
    return Column(
      children: [
        divider,
        _tile('Issuing Country Name', model.country),
        divider,
        _tile('Card Brand', model.brand),
        divider,
        _tile('Card Type', model.country),
        divider,
        _tile('Card Level', model.country),
        divider,
        _tile('Issuing Bank', model.country),
        divider,
        _tile('Ussuers Website', model.country),
        divider,
        _tile('Issuers Contact', model.country),
        divider,
        _tile('Bin', model.country),
        divider,
        _tile('Valid', model.country),
        divider,
      ],
    );
  }
  _tile(String title, String value) => Container(
    height: 29,
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ SizedBox(width: 15.0,), Text(title), Expanded(child: Container(),),Text(value), SizedBox(width: 15.0,)],
    ),
  );

}