
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../constants.dart';
import 'profile.dart';
import 'profile_editing.dart';
import 'login.dart';
import 'home.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: listView(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        "Notifications",
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
        },
      ),
      backgroundColor: Color.fromRGBO(37, 86, 162, 1),

    );
  }
  Widget listView() {

    return ListView.separated(

      itemBuilder: (context, index) {
        return listViewItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 15);
      },
      itemCount: 5,
    );
  }

  Widget listViewItem(int index){
    return Container(

      margin: EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(index),
                  timeAndData(index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon(){
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(Icons.notifications, size: 20, color: Colors.grey.shade700,),
    );
  }

  Widget message(int index){
    double textSize = 14;
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text:'Admin',
          style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
              fontWeight: FontWeight.bold),

        children: [
          TextSpan(
            text: " Veuillez vous présenter à l'administration",
          style: TextStyle(
            fontWeight: FontWeight.w400,
        )
      )
        ]
        )
      ),
    );
  }

Widget timeAndData(int index){
    return Container(
      margin: EdgeInsets.only(top:5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('23-01-2021', style: TextStyle(fontSize: 10.0),),
          Text('07:01', style: TextStyle(fontSize: 10.0),)
        ],
      ),
    );
}
}
