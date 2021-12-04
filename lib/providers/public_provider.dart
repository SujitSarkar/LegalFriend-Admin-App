import 'package:admin_app/model_class/bodli_khana_model.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicProvider extends ChangeNotifier {
  SharedPreferences? preferences;
  bool _isPhone = true;
  get isPhone=>_isPhone;

  bool _isAdmin = false;
  get isAdmin=>_isAdmin;

  double _size = 0.0;
  get size=>_size;

  String _category = '';
  String get category => _category;

  BodliKhanaModel? _bodliKhanaModel = BodliKhanaModel();
  BodliKhanaModel get bodliKhanaModel => _bodliKhanaModel!;

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  set bodliKhanaModel(BodliKhanaModel model) {
    model = BodliKhanaModel();
    _bodliKhanaModel = model;
    notifyListeners();
  }

  Future<void> iniatializeApp(BuildContext context) async {
    preferences = await SharedPreferences.getInstance();
    _isPhone = preferences!.getBool('isPhone')!;
    if (_isPhone) {
      _size=MediaQuery.of(context).size.width;
    } else {
      _size=MediaQuery.of(context).size.height;
    }
    adminCheck();
    print('isPhone: $_isPhone');
    print('Size: $_size');
    notifyListeners();
  }

  void adminCheck() {
    _isAdmin= preferences!.getBool('admin')??false;
    print('isAdmin: $_isAdmin');
    notifyListeners();
  }


  String crToggle(){
    if(_category==Variables.nIAct) {
      return Variables.crMamlaNo;
    } else {
      return Variables.mamlaNo;
    }
  }
  String crHintToggle(){
    if(_category==Variables.nIAct) {
      return '২৯২৫/২০১৯';
    } else {
      return 'মতিঝিল-৪(৮)২০২০';
    }
  }
  String pokkhoDharaToggle(){
    if(_category==Variables.nIAct) {
      return 'পক্ষগণের নামঃ ';
    } else {
      return 'ধারাঃ ';
    }
  }
  String pokkhoDharahintToggle(){
    if(_category==Variables.nIAct) {
      return 'মোঃ শাহ আলম বানাম আব্দুল আহাদ';
    } else {
      return '৩৬(১) এর ১০(গ),৪১';
    }
  }

}
