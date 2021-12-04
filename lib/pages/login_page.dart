import 'package:admin_app/pages/home_page.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/gradient_button.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:admin_app/widgets/page_routing_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);
  @override
  _LogInPageState createState() => _LogInPageState();
}
class _LogInPageState extends State<LogInPage> {
  final TextEditingController _phone= TextEditingController();
  final TextEditingController _password= TextEditingController();
  bool _isLoading=false;
  bool _obscure=true;
  int _radioValue=0;

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size=publicProvider.size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.28),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/splash_image.png',height: size*.2),
                  Text('Admin',
                      style: TextStyle(fontSize: size*.07,color: Colors.blue,fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(height: size*.04),

              ///Username
              TextFormField(
                controller: _phone,
                style: TextStyle(
                    fontSize: size*.045
                ),
                decoration: boxFormDecoration(size).copyWith(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: size*.04),

              ///Password
              TextFormField(
                controller: _password,
                obscureText: _obscure,
                style: TextStyle(
                    fontSize: size*.045
                ),
                decoration: boxFormDecoration(size).copyWith(
                    labelText: 'Password',
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscure = !_obscure;
                      });
                    }, icon: Icon(_obscure? CupertinoIcons.eye_slash:CupertinoIcons.eye))
                ),
              ),
              SizedBox(height: size*.01),

              ///Radio Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(value: 1, groupValue: _radioValue, onChanged: (int? val){
                        setState(()=>_radioValue=val!);
                      }),
                      Text('Admin', style: TextStyle(fontSize: size* .04))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(value: 2, groupValue: _radioValue, onChanged: (int? val){
                        setState(()=>_radioValue=val!);
                      }),
                      Text('Sub-Admin', style: TextStyle(fontSize: size* .04))
                    ],
                  )
                ],
              ),
              SizedBox(height: size*.03),

              _isLoading? spinCircle(): GradientButton(
                  child: Text('Log In',
                      style: TextStyle(fontSize: size*.05,color: Colors.white,fontWeight: FontWeight.bold)),
                  onPressed: (){
                    _login(databaseProvider,publicProvider);
                  },
                  borderRadius: 3.0,
                  height: size*.11,
                  width: size*.6,
                  gradientColors: [
                    Theme.of(context).primaryColor,
                    Colors.teal.shade300
                  ])
            ],
          ),
        ),
      ),
    );
  }

  void _login(DatabaseProvider databaseProvider,PublicProvider publicProvider)async{
    if(_phone.text.isNotEmpty){
      if( _password.text.isNotEmpty){
        if(_radioValue!=0){
          ///For Admin Login
          if(_radioValue==1){
            setState(()=> _isLoading=true);
            databaseProvider.validateAdmin(_phone.text,_password.text).then((value)async{
              if(value){
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString('phone', _phone.text);
                pref.setBool('admin', true);
                publicProvider.adminCheck();
                setState(()=> _isLoading=false);
                Navigator.pushAndRemoveUntil(context,AnimationPageRoute(navigateTo: const HomePage()), (route) => false);
              }else{
                setState(()=> _isLoading=false);
                showToast('Wrong username or password');
              }
            });
          }
          ///For Sub-Admin Login
          else if(_radioValue==2){
            setState(()=> _isLoading=true);
            databaseProvider.validateSubAdmin(_phone.text, _password.text).then((value)async{
              if(value){
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString('phone', _phone.text);
                pref.setBool('admin', false);
                publicProvider.adminCheck();
                setState(()=> _isLoading=false);
                Navigator.pushAndRemoveUntil(context, AnimationPageRoute(navigateTo: const HomePage()), (route) => false);
              }else{
                setState(()=> _isLoading=false);
                showToast('Wrong username or password');
              }
            });
          }
        }else {showToast('Select Admin or Sub-Admin');}
      }else {showToast('Enter Password');}
    }else {showToast('Enter Username');}
  }
}
