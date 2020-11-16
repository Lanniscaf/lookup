import 'package:flutter/material.dart';
import 'package:lookup/model/ccmodel_view.dart';
import 'package:lookup/styles/fonts_styles.dart';
import 'package:responsive_builder/responsive_builder.dart';


class CreditCard extends StatelessWidget {
  final CCModelView model;
  
  
  CreditCard({Key key, CCModelView cardModel}) : model= cardModel, super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final Size _sizing = MediaQuery.of(context).size;
    final Widget _card = ResponsiveBuilder(
      builder: (context, sizing) {
        return Stack(
          children: [
            Container(
              width : sizing.localWidgetSize.width * 0.8,
              height: sizing.localWidgetSize.height * 0.9,
              child: Image(
                // * Here goes the skin
                image: AssetImage('assets/images/ccard.png'),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: sizing.localWidgetSize.width * 0.06,
              top: sizing.localWidgetSize.height * 0.17,
              child: (model !=null)? Text(model.type, style: CREDITCARDTEXT,): Container()
            ),
            
            Positioned(
              left: sizing.localWidgetSize.width * 0.06,
              bottom: sizing.localWidgetSize.height * 0.1,
              child: (model !=null)? Container(width: sizing.localWidgetSize.width * 0.7, child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(model.bank, style: CREDITCARDTEXT.copyWith(fontSize: 17.0),))): Container()
            ),

            Positioned(
              left: sizing.localWidgetSize.width * 0.08,
              bottom: sizing.localWidgetSize.height * 0.22,
              child: (model !=null)? Text(model.numberFix, style: CREDITCARDTEXT.copyWith(letterSpacing: 2.0),) : Container()
            ),

            Positioned(
              right: 10,
              top: sizing.localWidgetSize.height * 0.13,
              child: (model !=null)? Container(
                constraints: BoxConstraints(minWidth: 50, minHeight: 50, maxWidth: 100, maxHeight: 100),
                width : sizing.localWidgetSize.width * 0.2,
                height: sizing.localWidgetSize.height * 0.2,
                alignment: Alignment.center,
                child: Image(
                  image: _getLogoByCard(model.getType),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.medium,
                ),
              ) : Container(),
            )
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

    // ? Returns the Logo of current cardtype
  ImageProvider _getLogoByCard(CardType cardType) {
    // !
    switch(cardType){
      case CardType.Mastercard:
        return AssetImage('assets/images/mastercard.png');
        break;
      
      case CardType.Visa:
        return AssetImage('assets/images/visa.png');
        break;
      
      case CardType.Amex:
        return AssetImage('assets/images/amex.png');
        break;
      
      case CardType.Unknown:
        return AssetImage('assets/images/norecognition.png');
        break;

      default:
        return null;
        break;
    }
  }

}