import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/orderdeleteresponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/address_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_add_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_location_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_make_default_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_in_cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/city_response.dart';
import 'package:active_ecommerce_flutter/data_model/state_response.dart';
import 'package:active_ecommerce_flutter/data_model/country_response.dart';
import 'package:active_ecommerce_flutter/data_model/shipping_cost_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class OrderDeleteRepository {

  Future<OrderDeleteResponse> getOrderDeleteResponse(
      @required int id
      ) async {
    Uri url =
    Uri.parse("${AppConfig.BASE_URL}/order/destroy/${id}");
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    print(response.body);

    return orderDeleteResponseFromJson(response.body);
  }

}