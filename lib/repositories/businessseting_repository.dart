import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/business_setting_response.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/brand_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class BusinessSeting {

  Future<BusinessSetingResponse> getbusinessseting() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/business-settings");
    final response =
    await http.get(url,headers: {
      "Authorization": "Bearer ${access_token.$}",
      "Content-Type": "application/json",
    });

    return businessSetingResponseFromJson(response.body);
  }



}