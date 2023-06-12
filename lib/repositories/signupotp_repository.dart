import 'dart:convert';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/newsignup_response.dart';
import 'package:active_ecommerce_flutter/data_model/user_by_token.dart';
import 'package:active_ecommerce_flutter/data_model/otp_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupOtpRepository{

  Future<NewSignupResponse> getSignupOtpResponse(
      @required String name,
      @required String phone
      ) async {
    var post_body = jsonEncode({
      "name": "$name",
      "phone": "$phone"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/signupOtp");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json"
        },
        body: post_body);

    return newSignupResponseFromJson(response.body);
  }


  Future<OtpResponse> getverifyotpResponse(
      @required String user_id,
      @required String otp) async {
    var post_body = jsonEncode({
      "user_id": "$user_id",
      "otp": "$otp"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/verifyLoginOtp");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body
    );
    print(response.body);

    return otpResponseFromJson(response.body);
  }


  Future<NewSignupResponse> getverifyloginotpResponse(
      @required String mobile) async {
    var post_body = jsonEncode({
      "mobile": "$mobile"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/auth/sentOTP");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body);

    return newSignupResponseFromJson(response.body);
  }


  Future<UserByTokenResponse> getUserByTokenResponse() async {
    var post_body = jsonEncode({"access_token": "${access_token.$}"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/get-user-by-access_token");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        },
        body: post_body);
    print(response.body);
    return userByTokenResponseFromJson(response.body);
  }

}