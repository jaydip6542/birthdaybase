import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class AuthHelper {
  setUserData(loginResponse) {
    print(loginResponse);
    if (loginResponse.result == true) {
      is_logged_in.$ = true;
      is_logged_in.save();
      print( is_logged_in.$);
      access_token.$ = loginResponse.accessToken;
      access_token.save();
      user_id.$ = loginResponse.user.id;
      user_id.save();
      print(loginResponse.user.name);
      user_name.$ = loginResponse.user.name;
      user_name.save();
      user_email.$ = loginResponse.user.email;
      user_email.save();
      user_phone.$ = loginResponse.user.phone;
      user_phone.save();
       // avatar_original.$ = loginResponse.user.avatar_original;
       // avatar_original.save();
    }
  }

  clearUserData() {

      is_logged_in.$ = false;
      is_logged_in.save();
      access_token.$ = "";
      access_token.save();
      user_id.$ = 0;
      user_id.save();
      user_name.$ = "";
      user_name.save();
      user_phone.$ = "";
      user_phone.save();
      avatar_original.$ = "";
      avatar_original.save();
  }
}
