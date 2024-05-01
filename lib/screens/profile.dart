import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
        child: Column(
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
                      CircleAvatar(
                        radius: kSpacingUnit.w * 15,
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                      ),
                      SizedBox(height: kSpacingUnit.w*2),
                      Text('Mohammed SLATNIA', style: kTitleTextStyle),
                      SizedBox(height: kSpacingUnit.w*2),

                      ElevatedButton(
                        onPressed: () {
                          // Handle button tap
                          // Add your code here to define what happens when the button is tapped
                          // For example, navigate to another screen, update state, etc.
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: kSpacingUnit.w * 1.5,
                            horizontal: kSpacingUnit.w * 12.5,
                          ),
                          primary: Color.fromRGBO(0, 170, 91, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kSpacingUnit.w * 0.8),
                          ),
                        ),
                        child: Text(
                          'Modifier',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      SizedBox(height: kSpacingUnit.w * 2),
                      Text(
                        'Nom: Mohammed SLATNIA',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: kSpacingUnit.w * 1),
                      Text(
                        'Email: example@gmail.com',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}