import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ! TODO: CLEAN AND REFACTOR THIS CODE ! IS VERY UNCLEAN AND UNOPTIMIZED

class SideMenu extends StatefulWidget {
  
  SideMenu({Key key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {

  final _animationDuration = Duration(milliseconds: 250);
  StreamController<bool> isSideBarOpenedSt = new StreamController();
  double yPosition;
  double width;
  double panSP;
  AnimationController _animation;

  @override
  void initState() {
    this._animation = AnimationController(vsync: this, duration: _animationDuration);
    super.initState();
  }

  @override
  void dispose() {
    _animation?.dispose();
    isSideBarOpenedSt?.close();
    super.dispose();
  }

  void panUPD(DragUpdateDetails i) {
    if(i.globalPosition.dx >= 100  && i.delta.dx > 1){
      setState(() {
        this.openDrawer();
      });
    }
    if(i.delta.dx < -1 && panSP > 100 + i.globalPosition.dx){
      setState(() {
        this.openDrawer(reverse: true);
      });
      return;
    }
    setState(() {
        this.yPosition += - i.delta.dx;
      });
    if(i.globalPosition.dx <= 133){
      setState(() {
        this.yPosition += - i.delta.dx;
      });
      return;
    }
    
  }

  
  void f(BuildContext context){
    if(this.yPosition != null) return;
    setState(() {
      this.yPosition = MediaQuery.of(context).size.width - 42;
      this.width = MediaQuery.of(context).size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    f(context);
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<bool>(
      stream: isSideBarOpenedSt.stream,
      initialData: false,
      builder:(context, s) => AnimatedPositioned(
        top: 0,
        left: (s.data) ? 0 : - size.width,
        bottom: 0,
        right: (s.data) ? 0 : yPosition,
        duration: _animationDuration,
        child: GestureDetector(
          onTap: (s.data)? () => openDrawer(reverse: true): null,
          onPanUpdate: panUPD,
          onPanStart: (i){
            setState(() {
              this.panSP=i.globalPosition.dx;
            });
          },
          onPanEnd: (i){
            Velocity speed = i.velocity;
            if(speed.pixelsPerSecond.dx < - 670 && _animation.status == AnimationStatus.completed){
              setState(() {
                this.yPosition = this.width - 42;
              });
              openDrawer(reverse: true);
            }
            if(speed.pixelsPerSecond.dx > 670 && _animation.status == AnimationStatus.dismissed){
              setState(() {
                this.yPosition = this.width - 42;
              });
              openDrawer();
            }
            if(this._animation.status != AnimationStatus.completed){
              setState(() {
                this.yPosition = this.width - 42;
              });
            }
            if(_animation.status == AnimationStatus.completed){
              this.yPosition = this.width - 42;
            }
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff141c2c),
                        Color(0xff181c2c),
                      ],
                      
                    ),
                    border: Border(),
                  ),
                  child: _SideMenuItems(),
                ),
              ),
              Align(
                alignment: Alignment(1,-0.76),
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: s.data? null : DrawerCustomClipper(),
                      child: Container(
                        height: double.infinity,
                        width: 40,
                        color: Colors.transparent,
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.1,
                      child: GestureDetector(
                        onTap: onIconPressed,
                        child: ClipPath(
                          clipper: CustomClipperInvisibleDrawer(),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 100,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xff181c2c),
                              border: Border(),
                            ),
                            child: AnimatedIcon(
                              progress: _animation.view,
                              icon: AnimatedIcons.menu_close,
                              color: Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onIconPressed({bool reverse = false}) {
    if(!reverse) this.yPosition = this.width - 42;
    FocusScope.of(context).unfocus();
    final animationStatus = _animation.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if(isAnimationCompleted){
      isSideBarOpenedSt.sink.add(false);
      _animation.reverse();
    } else {
      isSideBarOpenedSt.sink.add(true);
      _animation.forward();
    }
  }
  void openDrawer({bool reverse = false}) {
    if(!reverse) this.yPosition = this.width - 42;
    FocusScope.of(context).unfocus();
    final animationStatus = _animation.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if(isAnimationCompleted && reverse){
      isSideBarOpenedSt.sink.add(false);
      _animation.reverse();
    } else if(!reverse && !isAnimationCompleted){
      isSideBarOpenedSt.sink.add(true);
      _animation.forward();
    }
  }


}


class _SideMenuItems extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          title: Text('Lookups v1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _item("Bin Lookup", FontAwesomeIcons.search, onTap: (){}),
              Divider(color: Colors.grey, endIndent: 25, indent: 5,),
              _item("Fake Adress Generator", FontAwesomeIcons.searchLocation, onTap: (){}),
              Divider(color: Colors.grey, endIndent: 25, indent: 5,),
              _item("Extrapolate CC", FontAwesomeIcons.ccVisa, onTap: (){}),
              Divider(color: Colors.grey, endIndent: 25, indent: 5,),
              _item("Generate CC", FontAwesomeIcons.random, onTap: (){}),
              Divider(color: Colors.grey, endIndent: 25, indent: 5,),
              _item("Settings", Icons.settings, onTap: (){}),
              Divider(color: Colors.grey, endIndent: 25, indent: 5,),
              _item("About & Rate", FontAwesomeIcons.info, onTap: (){}, context: context),
              Divider(color: Colors.grey, endIndent: 25, indent: 5,),
            ]
          ),
        ),
      ],
    );
  }

  _item(String title, IconData icon, {Function onTap, context}){
    if(context != null){
      return Theme(
        data: ThemeData.dark(),
        child: AboutListTile(
          child: Text('About & Licenses', style: TextStyle(color: Colors.grey),),
          applicationVersion: '0.3.4+alpha',
          applicationLegalese: '©All Rights Reserverd 2020',
          applicationName: 'Lookup',
          icon: Padding(padding: const EdgeInsets.only(left: 5), child: Icon(Icons.info, size: 23, color: Colors.grey)),
        ),
      );
    } 
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        isThreeLine: false,
        title: Text(title, style: TextStyle(color: Colors.grey),), 
        leading: FaIcon(icon, size: 22, color: Colors.grey,),
        onTap: (){ 
        },
      ),
    );
  }
}

class DrawerCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;    
  }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class CustomClipperInvisibleDrawer extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.orange;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;    
  }
  
    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}
