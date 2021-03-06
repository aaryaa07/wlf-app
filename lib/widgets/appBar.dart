import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wlf/res/strings.dart';
import 'package:wlf/util/scaler.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool _visible;

  MyAppBar(this._visible);

  num height = 8.35 * SizeConfig.heightSizeMultiplier;

  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _MyAppBarState extends State<MyAppBar> {
  ImageProvider logo = AssetImage(loginPageLogoImage);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: AnimatedOpacity(
        opacity: widget._visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 180),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 1.45 * SizeConfig.heightSizeMultiplier),
                  Image.asset(
                    loginPageLogoImage,
                    height: 5.01 * SizeConfig.heightSizeMultiplier,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
