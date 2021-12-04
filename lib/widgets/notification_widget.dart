import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message){
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 16,
  );
}

Widget spinCircle()=>
    const SpinKitCircle(
      color: Colors.green,
      size: 50.0,
    );

void showLoadingDialog(BuildContext context)=>
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context)=>const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      scrollable: true,
      content: Center(child: CircularProgressIndicator()),
    ));

void closeLoadingDialog(BuildContext context)=>Navigator.pop(context);
