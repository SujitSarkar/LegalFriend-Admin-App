import 'package:admin_app/pages/login_page.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
        const LogInPage()), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    if(publicProvider.size==0.0) publicProvider.iniatializeApp(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Image.asset('assets/splash_image.png',fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
