
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/repositories/signupotp_repository.dart';
import 'package:active_ecommerce_flutter/screen_sections/newregisterpage.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:toast/toast.dart';

import 'newotpscreen.dart';



class NewLogin extends StatefulWidget {

  @override
  _NewLoginState createState() => _NewLoginState();
}

class _NewLoginState extends State<NewLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
   String mobile;


    onPresslogin(String mobile) async {

    var loginotpResponse = await SignupOtpRepository().getverifyloginotpResponse(mobile);

    if (loginotpResponse.success == false) {
      ToastComponent.showDialog(loginotpResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(loginotpResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      int intValue = loginotpResponse.userId;
      String stringValue = intValue.toString();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NewOtpScreen(
            userid:stringValue
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: _screen_width * (3 / 4),
              child: Image.asset(
                  "assets/splash_login_registration_background_image.png"),
            ),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 15),
                        child: Center(
                          child: Container(
                            width:200,
                            height: 200,
                            child:
                            Image.asset(  "assets/newlog.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ),
                      Container(

                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                            'Mobile Number',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18)
                        ),

                      ),
                      Container(
                        child:  Form(
                          key: _formKey,
                        child: Column(
                          children: <Widget>[

                            Container(
                                margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child:  TextFormField(
                                    controller: mobileController,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      labelText: 'Enter Mobile Number',
                                    ),
                                    validator: (val){
                                      if (val.length == 0)
                                        return "Enter Mobile Number";
                                      else if (val.length <= 9)
                                        return "Your Mobile Number should be more then 10 char long";
                                      else
                                        return null;
                                    },
                                    onSaved: (val)=>mobile=val,
                                  ),
                                )
                            ),

                            //sigin
                            GestureDetector(
                              onTap: (){


                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  onPresslogin(mobile);
                                }
                              },
                              child: Container(

                                margin: EdgeInsets.only(left: 20,top: 20,right: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width-40,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color:Color(0xA3000000),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: Offset(4,4)
                                      ),
                                      BoxShadow(
                                          color:Colors.white,
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: Offset(-4,-4)
                                      ),
                                    ]
                                ),
                                child: Center(
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600

                                    ),
                                  ),
                                ),
                              ),

                            ),

                            //new account
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return NewRegisterpage();
                                }));
                              },
                              child: Container(

                                margin: EdgeInsets.only(left: 20,top: 20,right: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width-40,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color:Color(0xA3000000),
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: Offset(4,4)
                                      ),
                                      BoxShadow(
                                          color:Colors.white,
                                          spreadRadius: 2,
                                          blurRadius: 8,
                                          offset: Offset(-4,-4)
                                      ),
                                    ]
                                ),
                                child: Center(
                                  child: Text(
                                    'No account yet?Create one',
                                    style: TextStyle(
                                        letterSpacing: 1.5,
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600

                                    ),
                                  ),
                                ),
                              ),

                            ),


                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height-600),
                              height: 50,
                              width: MediaQuery.of(context).size.width,

                              child: Center(
                                child: Text(
                                  'Indian Leading Stationery B2B Portal',
                                  style: TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600

                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                        )
                      ),

                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
