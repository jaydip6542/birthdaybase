import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:active_ecommerce_flutter/repositories/profile_repository.dart';
import 'package:active_ecommerce_flutter/repositories/signupotp_repository.dart';
import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../other_config.dart';


class NewOtpScreen extends StatefulWidget {

  String userid;
  NewOtpScreen({Key key,
     this.userid,

  }) : super(key: key);
  @override
  _NewOtpScreenState createState() => _NewOtpScreenState();
}

class _NewOtpScreenState extends State<NewOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  String otp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   print(widget.userid);
  }


  onPressOtp(String otp) async {


    print(otp);
    var loginResponse = await SignupOtpRepository().getverifyotpResponse(
      widget.userid, otp);


    if (loginResponse.result == false) {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      print(loginResponse);
    } else {
      ToastComponent.showDialog(loginResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      print(loginResponse);

      AuthHelper().setUserData(loginResponse);
      print(loginResponse);
      if (OtherConfig.USE_PUSH_NOTIFICATION) {
        final FirebaseMessaging _fcm = FirebaseMessaging.instance;

        await _fcm.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );

        String fcmToken = await _fcm.getToken();

        if (fcmToken != null) {
          print("--fcm token--");
          print(fcmToken);
          if (is_logged_in.$ == true) {
            // update device token
            var deviceTokenUpdateResponse = await ProfileRepository().getDeviceTokenUpdateResponse(fcmToken);
          }
        }
      }

      // setState(() async {
      //
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.setBool('is_logged_in', true);
      //
      // });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Main();
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
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(

                          margin: EdgeInsets.only(left: 20,top: 10,right: 10),
                          height: 50,
                          width: MediaQuery.of(context).size.width-40,

                          child: Center(
                            child: Text(
                              'Sit back & Relax! while we verify your'
                                  'mobile number.',
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

                      ),
                      Container(
                          child:  Form(
                            key: _formKey,
                            child: Column(
                                children: <Widget>[

                                  Container(
                                      margin: EdgeInsets.only(left: 20,top: 20,right: 20),
                                      height: 80,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child:   TextFormField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          controller: otpController,
                                          maxLength: 6,
                                          cursorColor: Theme.of(context).primaryColor,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              counterText: '',
                                              hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                                            labelText: 'Enter OTP  Number',
                                          ),
                                          validator: (val){
                                            if (val.length == 0)
                                              return "Enter Mobile Number";
                                            else if (val.length <= 5)
                                              return "Your Mobile Number should be more then 6 char long";
                                            else
                                              return null;
                                          },
                                          onSaved: (val)=>otp=val,
                                        ),
                                      )
                                  ),





                                  //sigin
                                  GestureDetector(
                                    onTap: (){


                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        onPressOtp(otp);
                                      }
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      //   return Home();
                                      // }));
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
                                          'Submit',
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

                                ]





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
