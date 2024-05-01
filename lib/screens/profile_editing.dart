import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';

class ProfileEditingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileEditingScreenState();
  }
}

class ProfileEditingScreenState extends State<ProfileEditingScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme
        .of(context)
        .textTheme
        .headline6;
    ScreenUtil.init(
      context,
      designSize: Size(340, 700),
      minTextAdapt: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(37, 86, 162, 1),
      ),

      body: Column(
        children: <Widget>[
          SizedBox(height: kSpacingUnit.w * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: kSpacingUnit.w * 2),
              //Icon(
              //LineAwesomeIcons.arrow_left,
              //size: ScreenUtil().setSp(kSpacingUnit.w * 3),
              //),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: kSpacingUnit.w * 13,
                      width: kSpacingUnit.w * 13,
                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: kSpacingUnit.w * 15,
                              backgroundImage: AssetImage(
                                  'assets/images/avatar.png'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: kSpacingUnit.w * 2.5,
                              width: kSpacingUnit.w * 2.5,
                              margin: EdgeInsets.only(top: kSpacingUnit.w * 7),
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .hintColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LineAwesomeIcons.pen,
                                color: kDarkPrimaryColor,
                                size: ScreenUtil().setSp(kSpacingUnit.w * 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
