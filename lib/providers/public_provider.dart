import 'package:admin_app/model_class/bodli_khana_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicProvider extends ChangeNotifier {
  SharedPreferences? preferences;
  bool _isPhone = true;
  get isPhone=>_isPhone;

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
    print('isPhone: $_isPhone');
    print('Size: $_size');
    notifyListeners();
  }

}
