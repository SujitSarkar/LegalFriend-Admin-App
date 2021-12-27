import 'dart:io';
import 'package:admin_app/model_class/bodli_khana_model.dart';
import 'package:admin_app/model_class/payment_info_model.dart';
import 'package:admin_app/model_class/register_user_model.dart';
import 'package:admin_app/model_class/sub_admin_model.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier{

  String _noticeBoardImageLink='';

  final List<BodliKhanaModel> _niActDataList = [];
  final List<BodliKhanaModel> _madokDataList = [];
  final List<BodliKhanaModel> _tribunalDataList = [];
  final List<RegisterUserModel> _registerUserList=[];
  final List<PaymentInfoModel> _paymentInfoList=[];
  final List<SubAdminModel> _subAdminList=[];
  int _newNIActData=0;
  int _newMadokData=0;
  int _newTribunalData=0;
  int _newRegisterUser=0;

  get noticeBoardImageLink=> _noticeBoardImageLink;
  get niActDataList=> _niActDataList;
  get madokDataList=> _madokDataList;
  get tribunalDataList=> _tribunalDataList;
  get newNIActData=> _newNIActData;
  get newMadokData=> _newMadokData;
  get newTribunalData=> _newTribunalData;
  get newRegisterUser=> _newRegisterUser;
  get registerUserList=> _registerUserList;
  get paymentInfoList=> _paymentInfoList;
  get subAdminList=> _subAdminList;

  bool _isAdmin = false;
  get isAdmin=>_isAdmin;

  bool _canUpdate = false;
  get canUpdate=>_canUpdate;

  bool _canDelete = false;
  get canDelete=>_canDelete;

  Future<bool> getNoticeBoardImageLink()async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('NoticeBoard').get();
      final List<QueryDocumentSnapshot> image = snapshot.docs;
      if(image.isNotEmpty) _noticeBoardImageLink= image[0].get('image_link');
      notifyListeners();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> deleteNoticeBoardImageLink()async{
    try{
      await firebase_storage.FirebaseStorage.instance.ref().child('NoticeBoard')
          .child('noticeBoard_123456789').delete();
      await FirebaseFirestore.instance.collection('NoticeBoard').doc('noticeBoard_123456789').delete();
      _noticeBoardImageLink='';
      notifyListeners();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }
  
  Future<void> getRegisterUserList()async{
    final String todayDate = DateFormat("dd-MM-yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch));
    try{
      List<RegisterUserModel> _tempUserList=[];
      Set<String> _userPhoneSet = {};
      List<String> _userPhoneList=[];
      await FirebaseFirestore.instance.collection('UserArchiveData')
          .orderBy('save_date',descending: true).get().then((snapshot){
        _registerUserList.clear();
        _newRegisterUser=0;
        for (var element in snapshot.docChanges) {
          RegisterUserModel model = RegisterUserModel(
            userPhone: element.doc['user_phone'],
            userName: element.doc['user_name'],
            userAddress: element.doc['user_address'],
            saveDate: element.doc['save_date']
          );
          _tempUserList.add(model);
          _userPhoneSet.add(element.doc['user_phone']);
        }
      });
      _userPhoneList.addAll(_userPhoneSet);
      for(int i=0; i<_userPhoneList.length;i++){
        if(_tempUserList[i].userPhone==_userPhoneList[i]){
          _registerUserList.add(_tempUserList[i]);
          if(todayDate==_tempUserList[i].saveDate) _newRegisterUser++;
        }
      }
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<bool> saveData(Map<String,String> map)async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('BodliKhana')
          .where('mamlar_dhoron', isEqualTo: map['mamlar_dhoron'])
          .where('dayra_no', isEqualTo: map['dayra_no']).get();
      final List<QueryDocumentSnapshot> user = snapshot.docs;
      if(user.isEmpty){
        await FirebaseFirestore.instance.collection('BodliKhana').doc(map['id']).set(map);
        return true;
      }else{
        showToast('ডুপ্লিকেট দায়রা নং');
        return false;
      }
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  // Future<void> getBodliKhanaDataList()async{
  //   final String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
  //   try{
  //     await FirebaseFirestore.instance.collection('BodliKhana').get().then((snapshot){
  //       _bodliKhanaList.clear();
  //       _niActDataList.clear();
  //       _madokDataList.clear();
  //       _tribunalDataList.clear();
  //       _newNIActData=0;
  //       _newMadokData=0;
  //       _newTribunalData=0;
  //       for (var element in snapshot.docChanges) {
  //         BodliKhanaModel bodliKhanaModel = BodliKhanaModel(
  //           id: element.doc['id'],
  //           amoliAdalot: element.doc['amoli_adalot'],
  //           bicarikAdalot: element.doc['bicarik_adalot'],
  //           boiNo: element.doc['boi_no'],
  //           dayraNo: element.doc['dayra_no'],
  //           entryDate: element.doc['entry_date'],
  //           mamlaNo: element.doc['mamla_no'],
  //           mamlarDhoron: element.doc['mamlar_dhoron'],
  //           pokkhoDhara: element.doc['pokkho_dhara'],
  //           porobortiTarikh: element.doc['poroborti_tarikh'],
  //           jojCourt: element.doc['joj_court']
  //         );
  //         _bodliKhanaList.add(bodliKhanaModel);
  //       }
  //     });
  //     ///Sorting Data
  //     _bodliKhanaList.sort((a,b)=>  int.parse(bnToEnNumberConvert(a.dayraNo!))
  //         .compareTo(int.parse(bnToEnNumberConvert(b.dayraNo!))));
  //
  //     //_bodliKhanaList.sort((a,b)=>  a.dayraNo.compareTo(b.dayraNo ));
  //
  //     for(int i=0; i<_bodliKhanaList.length; i++){
  //       if(_bodliKhanaList[i].mamlarDhoron==Variables.nIAct){
  //         _niActDataList.add(_bodliKhanaList[i]);
  //         if(_bodliKhanaList[i].entryDate==todayDate) _newNIActData++;
  //       }
  //       else if(_bodliKhanaList[i].mamlarDhoron==Variables.madokDondobidhi){
  //         _madokDataList.add(_bodliKhanaList[i]);
  //         if(_bodliKhanaList[i].entryDate==todayDate) _newMadokData++;
  //       }
  //       else if(_bodliKhanaList[i].mamlarDhoron==Variables.bisesTribunal){
  //         _tribunalDataList.add(_bodliKhanaList[i]);
  //         if(_bodliKhanaList[i].entryDate==todayDate) _newTribunalData++;
  //       }
  //     }
  //     notifyListeners();
  //   }catch(error){
  //     showToast(error.toString());
  //   }
  // }

  Future<void> getNIActDataList()async{
    final String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    try{
      await FirebaseFirestore.instance.collection('BodliKhana').where('mamlar_dhoron',isEqualTo: Variables.nIAct).get().then((snapshot){
        _niActDataList.clear();
        _newNIActData=0;
        for (var element in snapshot.docChanges) {
          BodliKhanaModel bodliKhanaModel = BodliKhanaModel(
              id: element.doc['id'],
              amoliAdalot: element.doc['amoli_adalot'],
              bicarikAdalot: element.doc['bicarik_adalot'],
              boiNo: element.doc['boi_no'],
              dayraNo: element.doc['dayra_no'],
              entryDate: element.doc['entry_date'],
              mamlaNo: element.doc['mamla_no'],
              mamlarDhoron: element.doc['mamlar_dhoron'],
              pokkhoDhara: element.doc['pokkho_dhara'],
              porobortiTarikh: element.doc['poroborti_tarikh'],
              jojCourt: element.doc['joj_court']
          );
          _niActDataList.add(bodliKhanaModel);
        }
      });
      ///Sorting Data
      _niActDataList.sort((a,b)=>  int.parse(bnToEnNumberConvert(a.dayraNo!))
          .compareTo(int.parse(bnToEnNumberConvert(b.dayraNo!))));

      for(int i=0; i<_niActDataList.length; i++){
        if(_niActDataList[i].entryDate==todayDate) _newNIActData++;
      }
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> getBiseshTribunalDataList()async{
    final String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    try{
      await FirebaseFirestore.instance.collection('BodliKhana').where('mamlar_dhoron',isEqualTo: Variables.bisesTribunal).get().then((snapshot){
        _tribunalDataList.clear();
        _newTribunalData=0;
        for (var element in snapshot.docChanges) {
          BodliKhanaModel bodliKhanaModel = BodliKhanaModel(
              id: element.doc['id'],
              amoliAdalot: element.doc['amoli_adalot'],
              bicarikAdalot: element.doc['bicarik_adalot'],
              boiNo: element.doc['boi_no'],
              dayraNo: element.doc['dayra_no'],
              entryDate: element.doc['entry_date'],
              mamlaNo: element.doc['mamla_no'],
              mamlarDhoron: element.doc['mamlar_dhoron'],
              pokkhoDhara: element.doc['pokkho_dhara'],
              porobortiTarikh: element.doc['poroborti_tarikh'],
              jojCourt: element.doc['joj_court']
          );
          _tribunalDataList.add(bodliKhanaModel);
        }
      });
      ///Sorting Data
      _tribunalDataList.sort((a,b)=>  int.parse(bnToEnNumberConvert(a.dayraNo!))
          .compareTo(int.parse(bnToEnNumberConvert(b.dayraNo!))));

      for(int i=0; i<_tribunalDataList.length; i++){
        if(_tribunalDataList[i].entryDate==todayDate) _newTribunalData++;
      }
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<void> getMadokDataList()async{
    final String todayDate = DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    try{
      await FirebaseFirestore.instance.collection('BodliKhana').where('mamlar_dhoron',isEqualTo: Variables.madokDondobidhi).get().then((snapshot){
        _madokDataList.clear();
        _newMadokData=0;
        for (var element in snapshot.docChanges) {
          BodliKhanaModel bodliKhanaModel = BodliKhanaModel(
              id: element.doc['id'],
              amoliAdalot: element.doc['amoli_adalot'],
              bicarikAdalot: element.doc['bicarik_adalot'],
              boiNo: element.doc['boi_no'],
              dayraNo: element.doc['dayra_no'],
              entryDate: element.doc['entry_date'],
              mamlaNo: element.doc['mamla_no'],
              mamlarDhoron: element.doc['mamlar_dhoron'],
              pokkhoDhara: element.doc['pokkho_dhara'],
              porobortiTarikh: element.doc['poroborti_tarikh'],
              jojCourt: element.doc['joj_court']
          );
          _madokDataList.add(bodliKhanaModel);
        }
      });
      ///Sorting Data
      _madokDataList.sort((a,b)=>  int.parse(bnToEnNumberConvert(a.dayraNo!))
          .compareTo(int.parse(bnToEnNumberConvert(b.dayraNo!))));

      for(int i=0; i<_madokDataList.length; i++){
        if(_madokDataList[i].entryDate==todayDate) _newMadokData++;
      }
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<bool> deleteData(String id)async{
    try{
      await FirebaseFirestore.instance.collection('BodliKhana').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> updateData(String id, Map<String, dynamic> map)async{
    WriteBatch batch = FirebaseFirestore.instance.batch();
    try{
      await FirebaseFirestore.instance.collection('BodliKhana').doc(id).update(map).then((value)async{
        ///Update User Archive
          await FirebaseFirestore.instance.collection('UserArchiveData')
              .where('data_id',isEqualTo: id).get().then((snapshot){
            for (var element in snapshot.docChanges) {
              batch.update(FirebaseFirestore.instance.collection('UserArchiveData').doc(element.doc.id), {
                'amoli_adalot': map['amoli_adalot'],
                'bicarik_adalot': map['bicarik_adalot'],
                'boi_no': map['boi_no'],
                'dayra_no': map['dayra_no'],
                'mamla_no': map['mamla_no'],
                'pokkho_dhara': map['pokkho_dhara'],
                'poroborti_tarikh': map['poroborti_tarikh'],
                'joj_court': map['joj_court']
              });
            }
            return batch.commit();
          });
      });
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> validateAdmin(String phone, String password)async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Admin')
          .where('phone', isEqualTo: phone).get();
      final List<QueryDocumentSnapshot> user = snapshot.docs;
      if(user.isNotEmpty && user[0].get('password')==password){
        _canUpdate=true;
        _canDelete=true;
        _isAdmin=true;
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }
    on SocketException{
      showToast('No Internet Connection !');
      return false;
    }
    catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> validateSubAdmin(String username, String password)async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('SubAdmin')
          .where('name', isEqualTo: username).get();
      final List<QueryDocumentSnapshot> user = snapshot.docs;
      if(user.isNotEmpty && user[0].get('password')==password){
        _canUpdate=user[0].get('can_update');
        _canDelete=user[0].get('can_delete');
        _isAdmin=false;
        notifyListeners();
        return true;
      }else{
        return false;
      }
    }
    on SocketException{
      showToast('No Internet Connection !');
      return false;
    }
    catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> validateOldPassword(String password)async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Admin')
          .where('password', isEqualTo: password).get();
      final List<QueryDocumentSnapshot> user = snapshot.docs;
      if(user.isNotEmpty){
        return true;
      }else{
        return false;
      }
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<bool> changePassword(String password)async{
    try{
      await FirebaseFirestore.instance.collection('Admin').doc('Xo7uBvq0LHOf6mAfIfY9').update({
        'password': password
      });
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  Future<void> getPaymentInfoList()async{
    try{
      await FirebaseFirestore.instance.collection('ArchivePaymentInfo').get().then((snapshot){
       _paymentInfoList.clear();
        for (var element in snapshot.docChanges) {
          PaymentInfoModel model = PaymentInfoModel(
              wmxId: element.doc['wmx_id'],
              refId: element.doc['ref_id'],
              token: element.doc['token'],
              userPhone: element.doc['user_phone'],
              merchantReqAmount: element.doc['merchant_req_amount'],
              merchantRefId: element.doc['merchant_ref_id'],
              merchantCurrency: element.doc['merchant_currency'],
              merchantAmountBdt: element.doc['merchant_amount_bdt'],
              conversionRate: element.doc['conversion_rate'],
              serviceRatio: element.doc['service_ratio'],
              wmxChargeBdt: element.doc['wmx_charge_bdt'],
              emiRatio: element.doc['emi_ratio'],
              emiCharge: element.doc['emi_charge'],
              bankAmountBdt: element.doc['bank_amount_bdt'],
              discountBdt: element.doc['discount_bdt'],
              merchantOrderId: element.doc['merchant_order_id'],
              requestIp: element.doc['request_ip'],
              cardDetails: element.doc['card_details'],
              isForeign: element.doc['is_foreign'],
              paymentCard: element.doc['payment_card'],
              cardCode: element.doc['card_code'],
              paymentMethod: element.doc['payment_method'],
              initTime: element.doc['init_time'],
              txnTime: element.doc['txn_time'],
          );
          _paymentInfoList.add(model);

        }
      });
      notifyListeners();
    }catch(error){
      showToast(error.toString());
    }
  }

  Future<bool> addNewSubAdmin(Map<String,dynamic> map)async{
    try{
      await FirebaseFirestore.instance.collection('SubAdmin').doc(map['id']).set(map);
      return Future.value(true);
    }catch(error){
      showToast(error.toString());
      return Future.value(false);
    }
  }

  Future<bool> getSubAdminList()async{
    try{
      await FirebaseFirestore.instance.collection('SubAdmin').get().then((snapshot){
        _subAdminList.clear();
        for (var element in snapshot.docChanges) {
          SubAdminModel model = SubAdminModel(
            id: element.doc['id'],
            name: element.doc['name'],
            canDelete: element.doc['can_delete'],
            canUpdate: element.doc['can_update'],
            password: element.doc['password'],
          );
          _subAdminList.add(model);
        }
        notifyListeners();
      });
      return Future.value(true);
    }catch(error){
      showToast(error.toString());
      return Future.value(false);
    }
  }

  Future<bool> deleteSubAdmin(String id)async{
    try{
      await FirebaseFirestore.instance.collection('SubAdmin').doc(id).delete();
      return true;
    }catch(error){
      showToast(error.toString());
      return false;
    }
  }

  String bnToEnNumberConvert(String bnString){
    String enString = bnString.replaceAll('০', '0').replaceAll('১', '1').replaceAll('২', '2')
        .replaceAll('৩', '3').replaceAll('৪', '4').replaceAll('৫', '5')
        .replaceAll('৬', '6').replaceAll('৭', '7').replaceAll('৮', '8')
        .replaceAll('৯', '9').replaceAll('/', '').replaceAll(' ', '')
        .replaceAll("'", '').replaceAll('"', '').replaceAll('-', '')
        .replaceAll('_', '').replaceAll('\\', '').replaceAll('+', '')
        .replaceAll('-', '').replaceAll('*', '').replaceAll('&', '').replaceAll('^', '')
        .replaceAll('%', '').replaceAll('\$', '').replaceAll('#', '').replaceAll('@', '')
        .replaceAll('!', '').replaceAll(',', '').replaceAll('.', '').replaceAll('?', '')
        .replaceAll('(', '').replaceAll(')', '').replaceAll('=', '').replaceAll('~', '')
        .replaceAll('`', '').replaceAll('এ', '').replaceAll('{', '').replaceAll('}', '')
        .replaceAll('[', '').replaceAll(']', '').replaceAll('বি', '');
    return enString;
  }
}