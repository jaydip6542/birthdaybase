import 'dart:io';

import 'package:active_ecommerce_flutter/other_config.dart';
import 'package:active_ecommerce_flutter/repositories/signupotp_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/splash.dart';
import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_value/shared_value.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'app_config.dart';
import 'package:active_ecommerce_flutter/services/push_notification_service.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:active_ecommerce_flutter/providers/locale_provider.dart';
import 'package:active_ecommerce_flutter/services/navigation_service.dart';
import 'lang_config.dart';


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  fetch_user() async {
    var userByTokenResponse = await SignupOtpRepository().getUserByTokenResponse();
    print(is_logged_in.$);

    if (userByTokenResponse.result == true) {
      is_logged_in.$ = true;
      is_logged_in.save();

      user_id.$ = userByTokenResponse.id;
      user_id.save();
      user_name.$ = userByTokenResponse.name;
      user_name.save();
      print(userByTokenResponse.name);
      print(user_name.$);
      user_email.$ = userByTokenResponse.email;
      user_email.save();
      user_phone.$ = userByTokenResponse.phone;
      user_phone.save();
      avatar_original.$ = userByTokenResponse.avatar_original;
      avatar_original.save();
    }
  }

  app_language.load();
  app_mobile_language.load();
  app_language_rtl.load();

  access_token.load().whenComplete(() {
    fetch_user();
  });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

    runApp(
      SharedValue.wrapApp(
        MyApp(),
      ),
    );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  PackageInfo _packageInfo = PackageInfo(
    appName: AppConfig.app_name,
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
   String PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=birth.day.bash';

  var two = 10;
  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
          .getString('force_update_current_version')
          .trim()
          .replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }
    }  catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    super.initState();
    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    _initPackageInfo();

    if (OtherConfig.USE_PUSH_NOTIFICATION) {
      Future.delayed(Duration(milliseconds: 100), () async {
        PushNotificationService().initialise();
      });
    }
  }
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
      // print(_packageInfo.appName);
      // print(_packageInfo.buildNumber);
      // print(_packageInfo.version);
      // print(_packageInfo.packageName);

      var one = int.parse(_packageInfo.buildNumber);

      if(one  < two){
        print('1212');
      } else {
        print(one);
      }

    });
  }



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ],
        child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
          return MaterialApp(
            builder: OneContext().builder,
            navigatorKey: OneContext().navigator.key,
            title: AppConfig.app_name,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: MyTheme.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              accentColor: MyTheme.accent_color,
              /*textTheme: TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(fontSize: 12.0),
            )*/
              //
              // the below code is getting fonts from http
              textTheme: GoogleFonts.sourceSansProTextTheme(textTheme).copyWith(
                bodyText1:
                    GoogleFonts.sourceSansPro(textStyle: textTheme.bodyText1),
                bodyText2: GoogleFonts.sourceSansPro(
                    textStyle: textTheme.bodyText2, fontSize: 12),
              ),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: provider.locale,
            supportedLocales: LangConfig().supportedLocales(),
            home: Splash(),
            //home: Main(),
          );
        }));
  }
  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () {},
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
