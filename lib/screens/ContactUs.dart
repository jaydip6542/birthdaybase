import 'package:flutter/material.dart';

import '../my_theme.dart';
import 'main.dart';


class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key key, this.from_checkout = false}) : super(key: key);
  final bool from_checkout;


  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              width: 100,
              height: 80,
              child: Text(
                'Do You Have a question?A complaint? Or do you'
                    ' need help while completing a transaction on '
                    ' thestationerybox.in? Any quires regarding '
                    ' your orders,account,registration reach us on:',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset("assets/order.png",
                        height: 16, color: Colors.redAccent),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Mail:',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Text(
                      'info@birthdaybash.in',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset("assets/order.png",
                        height: 16, color: Colors.redAccent),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Call:',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Text(
                      ' +917984079900',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset("assets/order.png",
                        height: 16, color: Colors.redAccent),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'WhatsApp:',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Text(
                      ' 7984079900',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Text(
                'call us between 11am to 7pm Monday to Saturday',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),

    );
  }

  buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(104.0),
      child: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            new Container(),
          ],
          elevation: 0.0,
          titleSpacing: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
            child: Column(
              children: [
                Padding(
                  padding: MediaQuery.of(context).viewPadding.top >
                      30 //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
                      ? const EdgeInsets.only(top: 36.0)
                      : const EdgeInsets.only(top: 14.0),
                  child: buildTopAppBarContainer(),
                ),

              ],
            ),
          )),
    );
  }


  Container buildTopAppBarContainer() {
    return Container(
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
              onPressed: () {
                if (widget.from_checkout) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Main();
                  }));
                } else {
                  return Navigator.of(context).pop();
                }
              },
            ),
          ),
          Text(
           "Contact Us" ,
            style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
          ),
        ],
      ),
    );
  }




}
