import 'package:flutter/material.dart';
import 'package:lookup/styles/fonts_styles.dart';
import 'package:lookup/model/ccmodel_view.dart';
import 'package:lookup/widgets/credit_card.dart';
import 'package:stacked/stacked.dart';



class HomeView extends StatelessWidget {

  final CCModelView _modelView;
  HomeView({@required CCModelView ccmodel, Key key}) : this._modelView = ccmodel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text('Details', style: TextStyle(color: Colors.grey),),
                floating: true,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.grey,),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ViewModelBuilder<CCModelView>.nonReactive(
                      viewModelBuilder: () => _modelView,
                      builder: (context, model, widget) => 
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CreditCard(cardModel: model,),
                            _cardDetails(context, model)
                          ],
                        )
                    ),
                  ]
                ),
              )
            ], 
          ),
        ),
      ),
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
        _tile('Card Type', model.type),
        divider,
        _tile('Card Level', model.level),
        divider,
        _tile('Issuing Bank', model.bank),
        divider,
        _tile('Ussuers Website', model.website),
        divider,
        _tile('Issuers Contact', model.number),
        divider,
        _tile('Bin', model.bin),
        divider,
        _tile('Valid', model.valid.toString().toUpperCase()),
        divider,
        _tile('Postal Code', model.postalCode),
        divider,
      ],
    );
  }
  _tile(String title, String value) => Container(
    constraints: BoxConstraints(
      minHeight: 29
    ),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [ SizedBox(width: 15.0,), SelectableText(title, style: LISTCREDITTEXT.copyWith(color: Colors.grey)), Expanded(child: Container(),),Container(width: 160, alignment: Alignment.centerRight, child: SelectableText(value, style: LISTCREDITTEXT, textAlign: TextAlign.right,)), SizedBox(width: 15.0,)],
    ),
  );


}