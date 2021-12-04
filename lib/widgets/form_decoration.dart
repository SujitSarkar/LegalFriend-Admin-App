import 'package:flutter/material.dart';

InputDecoration boxFormDecoration(double size) => InputDecoration(
  hintText: '',
  contentPadding: EdgeInsets.symmetric(
      vertical: size * .02,
      horizontal: size * .04),
  //Change this value to custom as you like
  isDense: true,
  hintStyle: formTextStyle(size).copyWith(color: Colors.grey),
  labelStyle: formTextStyle(size).copyWith(color: Colors.grey),
  errorStyle: formTextStyle(size).copyWith(color: Colors.red,fontSize: size*.04),
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: Colors.grey.shade800,
          width: 1
      )
  ),
  enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: Colors.grey.shade800,
          width: 1
      )
  ),
  disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: Colors.grey.shade800,
          width: 1
      )
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: Colors.green.shade800,
          width: 2
      )
  ),
);

TextStyle formTextStyle(double size) => TextStyle(
    color: Colors.grey.shade800,
    fontSize: size*.04,
    fontWeight: FontWeight.w400,
);