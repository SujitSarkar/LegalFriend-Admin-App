import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/gradient_button.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final TextEditingController _oldPassword= TextEditingController();
  final TextEditingController _newPassword= TextEditingController();
  final TextEditingController _confirmPassword= TextEditingController();
  bool _isLoading=false;
  bool _obscure=true;
  bool _obscure2=true;
  bool _obscure3=true;

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size = publicProvider.size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Variables.changePass),
        elevation: 00,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: size*.05),
              ///Title
              Text("এডমিন পাসওয়ার্ড পরিবর্তন করুন",
                  style: TextStyle(fontSize: size*.05,
                      color: Variables.textColor,
                      fontWeight: FontWeight.bold)),
              const Divider(),
              SizedBox(height: size*.05),

              TextFormField(
                controller: _oldPassword,
                obscureText: _obscure,
                style: TextStyle(
                    fontSize: size*.04
                ),
                decoration: boxFormDecoration(size).copyWith(
                    labelText: 'পুরানো পাসওয়ার্ড',
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscure = !_obscure;
                      });
                    }, icon: Icon(_obscure? CupertinoIcons.eye_slash:CupertinoIcons.eye))
                ),
              ),
              SizedBox(height: size*.05),

              TextFormField(
                controller: _newPassword,
                obscureText: _obscure2,
                style: TextStyle(fontSize: size*.04),
                decoration: boxFormDecoration(size).copyWith(
                    labelText: 'নতুন পাসওয়ার্ড',
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscure2 = !_obscure2;
                      });
                    }, icon: Icon(_obscure2? CupertinoIcons.eye_slash:CupertinoIcons.eye))
                ),
              ),
              SizedBox(height: size*.05),

              TextFormField(
                controller: _confirmPassword,
                obscureText: _obscure3,
                style: TextStyle(fontSize: size*.04),
                decoration: boxFormDecoration(size).copyWith(
                    labelText: 'কনফার্ম পাসওয়ার্ড',
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _obscure3 = !_obscure3;
                      });
                    }, icon: Icon(_obscure3? CupertinoIcons.eye_slash:CupertinoIcons.eye))
                ),
              ),
              SizedBox(height: size*.05),

              _isLoading? spinCircle(): GradientButton(
                  child: Text('পরিবর্তন করুন',
                      style: TextStyle(fontSize: size*.05,color: Colors.white)),
                  onPressed: ()async{
                    _changePassword(databaseProvider);
                  },
                  height: size * .11,
                  width: size* .7,
                  borderRadius: 5,
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

  void _changePassword(DatabaseProvider databaseProvider)async{
    if(_oldPassword.text.isNotEmpty && _newPassword.text.isNotEmpty
        && _confirmPassword.text.isNotEmpty){
      if(_newPassword.text == _confirmPassword.text){
        setState(()=> _isLoading=true);
        await databaseProvider.validateOldPassword(_oldPassword.text).then((value)async{
          if(value){
            await databaseProvider.changePassword(_confirmPassword.text).then((value){
              if(value){
                setState(()=> _isLoading=false);
                showToast('সফল হয়েছে');
                _oldPassword.clear();
                _newPassword.clear();
                _confirmPassword.clear();
              }else{
                setState(()=> _isLoading=false);
                showToast('ব্যর্থ হয়েছে! আবার চেষ্টা করুন');
              }
            });
          }else{
            setState(()=> _isLoading=false);
            showToast('পুরানো পাসওয়ার্ড ভুল');
          }
        });
      }else {
        showToast('পাসওয়ার্ড দুটি মিলতে হবে');
      }
    }else {
      showToast('ফর্ম পুরন করুন');
    }
  }

}
