import 'package:admin_app/pages/splash_screen.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /// Set Device orientation
  final bool _isPhone = Device.get().isPhone;
  SharedPreferences pref = await SharedPreferences.getInstance();
  if(_isPhone) {Variables.portraitMood;}
  else {Variables.landscapeMood;}
  pref.setBool('isPhone', _isPhone);
  String phone = pref.getString('phone')??'';
  runApp(MyApp(phone: phone));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key,required this.phone}) : super(key: key);
  String phone;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>PublicProvider()),
        ChangeNotifierProvider(create: (_)=>DatabaseProvider())
      ],
      child: MaterialApp(
        title: 'LegalFriend',
          theme: Variables.appTheme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(phone: phone)
      ),
    );
  }
}

