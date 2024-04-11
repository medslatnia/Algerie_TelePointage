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

                  SizedBox(height: kSpacingUnit.w*2),
                  Text('Mohammed SLATNIA', style: kTitleTextStyle),
                  SizedBox(height: kSpacingUnit.w*2),

                  TextButton(
                    onPressed: () {
                      // Handle button tap
                      // Add your code here to define what happens when the button is tapped
                      // For example, navigate to another screen, update state, etc.
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: kSpacingUnit.w * 1.5,
                        horizontal: kSpacingUnit.w * 12.5,
                      ),
                      backgroundColor: Color.fromRGBO(0, 170, 91, 1),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nom: Mohammed SLATNIA',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: kSpacingUnit.w * 1),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email: example@gmail.com',
                    style: TextStyle(fontSize: 16),

              ),
              )]),
  )],
        ),
      ],
    ),
  );
}
}
