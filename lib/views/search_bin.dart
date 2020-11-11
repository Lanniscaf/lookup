import 'package:flutter/material.dart';
import 'package:lookup/get_it.dart';
import 'package:lookup/styles/constants.dart';
import 'package:lookup/view-model/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchBin extends StatelessWidget {
  const SearchBin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Lookup', style: TextStyle(color: Colors.black),),
        elevation: 0.0,
        centerTitle: true,
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: ViewModelBuilder<SearchViewModel>.reactive(
          viewModelBuilder: () => SearchViewModel(),
          builder: (context, model, widget) => Column(
            children: <Widget>[
              _form(model, context),
            ],
          ),
        ),
      )
    );
  }

  _form(SearchViewModel model, BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Form(
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: model.validate,
                controller: model.binController,
                decoration: INPUTSEARCH,
              ),
            ),
          ),
          _button(model)
        ],
      ),
    );
  }

  _button(SearchViewModel model){
    return RaisedButton(
      color: Colors.lightBlueAccent,
      child: (!model.isLoading) ? Text('Buscar') : Container(width: 20, height: 20, alignment: Alignment.center, child: CircularProgressIndicator()),
      onPressed: model.getBinInfo,
    );
  }
}