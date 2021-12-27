import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Variables {
  static var portraitMood =SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  static var landscapeMood =SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]);

  static final appTheme= ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'kalpurush',
      backgroundColor: Colors.white,
      canvasColor: Colors.transparent,
      textTheme:const TextTheme(
        headline1:TextStyle(fontFamily: "kalpurush"),
        headline2:TextStyle(fontFamily: "kalpurush"),
        headline3:TextStyle(fontFamily: "kalpurush"),
        headline4:TextStyle(fontFamily: "kalpurush"),
        headline5:TextStyle(fontFamily: "kalpurush"),
        headline6:TextStyle(fontFamily: "kalpurush"),
        subtitle1:TextStyle(fontFamily: "kalpurush"),
        subtitle2:TextStyle(fontFamily: "kalpurush"),
        bodyText1:TextStyle(fontFamily: "kalpurush"),
        bodyText2:TextStyle(fontFamily: "kalpurush"),
        caption:TextStyle(fontFamily: "kalpurush"),
        button:TextStyle(fontFamily: "kalpurush"),
        overline:TextStyle(fontFamily: "kalpurush"),
      ));

  static final Color textColor = Colors.grey.shade900;
  static const Color secondaryColor = Color(0xffFFC800);

  static List<String> homeGridItem=[dashboard,bodliKhana,registerGrahok,paymentInfo,noticeBoard,changePass,subAdmin,logout,''];
  static List<String> bodlikhanaList=[nIAct,madokDondobidhi,bisesTribunal];

  static const String amoliAdalot = 'আমলী আদালত';
  static const String dashboard = 'ড্যাশবোর্ড';
  static const String paymentInfo = 'পেমেন্ট ইনফরমেশন';
  static const String noticeBoard = 'নোটিশ বোর্ড';
  static const String changePass = 'পাসওয়ার্ড পরিবর্তন করুন';
  static const String subAdmin = 'সাব এডমিন';
  static const String logout = 'লগ আউট';
  static const String jojCourt = 'জজ কোর্ট';
  static const String crMamlaNo = 'সিআর মামলা নং';
  static const String mamlaNo = 'মামলা নং';
  static const String cR = 'সিআর';
  static const String sorboseshUpdateBoi = 'সর্বশেষ আপডেট বই';
  static const String porjonto = 'পর্যন্ত';
  static const String boiNo = 'বই নং';
  static const String thekeSuruHoyeche = 'থেকে শুরু হয়েছে';
  static const String dayraNo = 'দায়রা নং';
  static const String bishesDayraNo = 'বিঃ ট্রাইঃ মাঃ নং';
  static const String porobortiTarikh = 'পরবর্তী তারিখ';
  static const String bicaricAdalot = 'বিচারিক আদালত';
  static const String dukkhito = 'দুঃখিত';
  static const String konoFolafolNei = 'কোন ফলাফল নেই';
  static const String dropHint = 'নির্বাচন করুন';
  static const String mamlarDhoron = 'মামলার ধরন';
  static const String nIAct = 'এন.আই.এ্যাক্ট';
  static const String madokDondobidhi = 'মাদক/দন্ডবিধি';
  static const String bisesTribunal = 'বিশেষ ট্রাইব্যুনাল';
  static const String registerGrahok = 'রেসিস্টার গ্রাহক';
  static const String kajList = 'কাজলিষ্ট';
  static const String bodliKhana = 'বদলি খানা';
  static const String pokkhogonerNam = 'পক্ষগনের নাম';
  static const String banam = 'বনাম';
  static const String porobortiTang = 'পরবর্তী তাং';
  static const String dhara = 'ধারা';
  static const String save = 'সেইভ করুন';
  static const List<String> amoliAdalotList = ['সি.এম.এম', 'সি.জে.এস'];
  static const List<String> jojCourtList = [
    'ঢাকা',
    'চট্টগ্রাম',
    'কুমিল্লা',
    'রাজশাহী',
    'খুলনা',
    'বরিশাল',
    'রংপুর',
    'ময়মনসিংহ',
    'সিলেট',
    'কক্সবাজার'
  ];
  static final List<String> thanaList = [
    'আদাবর',
    'উত্তরখান',
    'উত্তরা পূর্ব',
    'উত্তরা পশ্চিম',
    'ওয়ারী',
    'কলাবাগান',
    'কাফরুল',
    'ক্যান্টনমেন্ট',
    'কদমতলি',
    'কোতোয়ালি',
    'কামরাঙ্গীচর',
    'খিলগাঁও',
    'খিলক্ষেত',
    'গুলশান',
    'গেন্ডারিয়া',
    'চকবাজার',
    'ডেমরা',
    'তুরাগ',
    'তেজগাঁও',
    'তেজগাঁও শিল্পাঞ্চল',
    'দক্ষিণখান',
    'দারুসসালাম',
    'ধানমন্ডি',
    'নিউমার্কেট',
    'পল্টন',
    'পল্লবি',
    'বনানী',
    'বাড্ডা',
    'বিমানবন্দর',
    'বংশাল',
    'ভাটারা',
    'ভাষানটেক',
    'মতিঝিল',
    'মিরপুর',
    'মুগদা',
    'মোহাম্মদপুর',
    'যাত্রাবাড়ী',
    'রমনা',
    'রামপুরা',
    'রুপনগর',
    'লালবাগ',
    'শাহআলি',
    'শাহজাহানপুর',
    'শাহবাগ',
    'শেরেবাংলা নগর',
    'শ্যামপুর',
    'সবুজবাগ',
    'সুত্রাপুর',
    'হাজারীবাগ',
    'হাতিরঝিল',
    'জি,আর,পি',
    'আশুলিয়া',
    'কেরানিগঞ্জ',
    'দক্ষিণ কেরানিগঞ্জ',
    'দোহার',
    'ধামরাই',
    'নবাবগঞ্জ',
    'সাভার','সি.আর'];

}