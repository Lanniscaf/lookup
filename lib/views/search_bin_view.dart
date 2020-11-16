import 'package:flutter/material.dart';
import 'package:lookup/styles/constants.dart';
import 'package:lookup/model/search_viewmodel.dart';
import 'package:lookup/widgets/credit_card.dart';
import 'package:stacked/stacked.dart';

class SearchBin extends StatelessWidget {
  
  SearchBin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscrollNotification) {
          overscrollNotification.disallowGlow();
          return true;
        },
        child: buildScrollableSearch(context)
      )
    );
  }

  Widget buildScrollableSearch(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/bg.jpg'))),
      child: ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: ()=> SearchViewModel(),
        builder:(context, model, _) => CustomScrollView(
          slivers: [
            SliverAppBar(  
              backgroundColor: Colors.transparent,
              title: Text('Lookup', style: TextStyle(color: Colors.white54),),
              elevation: 0.0,
              centerTitle: true,
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 4,
                        child: Transform.rotate(angle: -0.1, child: CreditCard())
                      
                      ),
                      CreditCard(),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.19,
                        left: 14,
                        child: _form(model, context),
                      ),
                    ],
                  ),
                    _button(model),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _form(SearchViewModel model, BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Form(
              child: TextFormField(
                maxLength: 6,
                autofocus: true,
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: model.validate,
                controller: model.binController,
                decoration: INPUTSEARCH,
                onFieldSubmitted: (string) => model.getBinInfo(),
                style: Orange,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _button(SearchViewModel model){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: RaisedButton(
        color: Colors.lightBlueAccent,
        child: (!model.isLoading) ? Text('Buscar') : Container(width: 20, height: 20, alignment: Alignment.center, child: CircularProgressIndicator()),
        onPressed: model.getBinInfo,
      ),
    );
  }
}