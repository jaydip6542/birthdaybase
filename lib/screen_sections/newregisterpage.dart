import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/repositories/signupotp_repository.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:toast/toast.dart';


import 'newotpscreen.dart';


class NewRegisterpage extends StatefulWidget {


  @override
  _NewRegisterpageState createState() => _NewRegisterpageState();
}

class _NewRegisterpageState extends State<NewRegisterpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String _register_by = "email";


   String name;
   String phone;

  onPressSignUp(String name,phone) async {



    var signupotpResponse = await SignupOtpRepository().getSignupOtpResponse(
        name,phone);

    if (signupotpResponse.success == false) {
      ToastComponent.showDialog(signupotpResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      ToastComponent.showDialog(signupotpResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      int intValue = signupotpResponse.userId;
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
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(

                          margin: EdgeInsets.only(left: 20,top: 10,right: 10),
                          height: 50,
                          width: MediaQuery.of(context).size.width-40,

                          child: Center(
                            child: Text(
                              'SIGN Up',
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
                                      child:  TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          labelText: 'Enter Store Name',
                                        ),
                                        validator: (val){
                                          if (val.length == 0)
                                            return "Enter Store Name";
                                          else if (val.length <= 1)
                                            return "Your Store Name should be more then 1 char long";
                                          else
                                            return null;
                                        },
                                        onSaved: (val)=>name=val,
                                      ),
                                    )
                                ),

                                Container(
                                    margin: EdgeInsets.only(left: 20,top: 10,right: 20),
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child:  TextFormField(
                                        maxLength: 10,
                                        controller: mobileController,
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
                                            return "Your Mobile Number should be more then 6 char long";
                                          else
                                            return null;
                                        },
                                        onSaved: (val)=>phone=val,
                                      ),
                                    )
                                ),




                                //sigin
                                GestureDetector(
                                  onTap: (){


                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      onPressSignUp(name,phone);
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
                                        'SIGN Up',
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
