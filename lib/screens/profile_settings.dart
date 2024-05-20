
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';

class ProfileSettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileSettingsScreenState();
  }
}

class ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyLarge;
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
                        ],
                      ),
                    ),

                    SizedBox(height: kSpacingUnit.w*2),
                    Text('Mohammed SLATNIA', style: kTitleTextStyle),
                    SizedBox(height: kSpacingUnit.w*2),


                    SizedBox(height: kSpacingUnit.w*2),

                    TextButton(
                      onPressed: () {
                        // Handle button tap
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: kSpacingUnit.w * 1.5,
                          horizontal: kSpacingUnit.w * 10,
                        ),
                        backgroundColor: Color(0xFFEEEEEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kSpacingUnit.w * 0.8),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            LineAwesomeIcons.user,
                            size: kSpacingUnit.w * 2.5,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Profile',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Spacer(),

                        ],
                      ),
                    ),

                    SizedBox(height: kSpacingUnit.w * 1),

                    TextButton(
                      onPressed: () {
                        // Handle button tap
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: kSpacingUnit.w * 1.5,
                          horizontal: kSpacingUnit.w * 10,
                        ),
                        backgroundColor: Color(0xFFEEEEEE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kSpacingUnit.w * 0.8),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[

                          SizedBox(width: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Historique',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Spacer(),

                          
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
