// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:legalfriend_admin/providers/database_provider.dart';
// import 'package:legalfriend_admin/providers/public_provider.dart';
// import 'package:legalfriend_admin/variables/static_variables.dart';
// import 'package:legalfriend_admin/widgets/form_decoration.dart';
// import 'package:legalfriend_admin/widgets/gradient_button.dart';
// import 'package:legalfriend_admin/widgets/notification_widget.dart';
// import 'package:provider/provider.dart';
//
// class DataUpdatePage extends StatefulWidget {
//   @override
//   _DataUpdatePageState createState() => _DataUpdatePageState();
// }
//
// class _DataUpdatePageState extends State<DataUpdatePage> {
//   final _formKey= GlobalKey<FormState>();
//   bool _isLoading=false;
//   int _counter=0;
//   String? _amoliAdalot;
//   String? _jojCourt;
//   TextEditingController _dayraNo =TextEditingController(text: '');
//   TextEditingController _mamlaNo =TextEditingController(text: '');
//   TextEditingController _pokkho_dhara =TextEditingController(text: '');
//   TextEditingController _nextDate =TextEditingController(text: '');
//   TextEditingController _bicarikAdalot =TextEditingController(text: '');
//   TextEditingController _boiNo =TextEditingController(text: '');
//
//   void _customInit(PublicProvider publicProvider){
//     setState(()=> _counter++);
//     _dayraNo = TextEditingController(text: publicProvider.bodliKhanaModel.dayraNo);
//     _mamlaNo = TextEditingController(text: publicProvider.bodliKhanaModel.mamlaNo);
//     _pokkho_dhara = TextEditingController(text: publicProvider.bodliKhanaModel.pokkhoDhara);
//     _nextDate = TextEditingController(text: publicProvider.bodliKhanaModel.porobortiTarikh);
//     _bicarikAdalot = TextEditingController(text: publicProvider.bodliKhanaModel.bicarikAdalot);
//     _boiNo = TextEditingController(text: publicProvider.bodliKhanaModel.boiNo);
//     _amoliAdalot = publicProvider.bodliKhanaModel.amoliAdalot;
//     _jojCourt = publicProvider.bodliKhanaModel.jojCourt;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
//     final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
//     if(_counter==0) _customInit(publicProvider);
//
//     return _dataUpdateUI(size, publicProvider, databaseProvider);
//   }
//
//
//   Widget _dataUpdateUI(Size size, PublicProvider publicProvider,DatabaseProvider databaseProvider)=>RawKeyboardListener(
//     focusNode: FocusNode(),
//     autofocus: true,
//     onKey: (event){
//       if(event.isKeyPressed(LogicalKeyboardKey.enter)){
//         _updateData(publicProvider, databaseProvider);
//       }
//     },
//     child: Container(
//       width: publicProvider.pageWidth(size),
//       color: Colors.grey[100],
//       child: Center(
//         child: Container(
//           width: size.width*.65,
//           height: size.height*.8,
//           margin: EdgeInsets.symmetric(vertical: size.height*.04),
//           decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 5,
//                     offset: Offset(1,5)
//                 )
//               ]
//           ),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: size.height*.02),
//                   Text('${Variables.mamlarDhoron} - ${publicProvider.category}',textAlign: TextAlign.center,style: TextStyle(
//                       fontSize: size.height * .023,
//                       color: Colors.grey[900],
//                       fontFamily: 'hindSiliguri',
//                       fontWeight: FontWeight.w500,
//                       decoration: TextDecoration.underline),),
//                   SizedBox(height: size.height*.04),
//
//                   ///boi No
//                   Container(
//                       width: size.width*.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width*.1,
//                             alignment: Alignment.centerRight,
//                             child: Text(Variables.boiNo,style: TextStyle(
//                                 fontSize: size.height * .022,
//                                 color: Colors.grey[900],fontFamily: 'hindSiliguri')),
//                           ),
//                           Container(
//                             width: size.width*.495,
//                             child: TextFormField(
//                               controller: _boiNo,
//                               onEditingComplete: (){},
//                               keyboardType: TextInputType.text,
//                               validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
//                               style: formTextStyle(size),
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: '০৪/২০২১',
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   SizedBox(height:  size.height*.01),
//
//                   ///Amoli Adalot Dropdown
//                   Container(
//                     width: size.width*.65,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: size.width*.1,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical:size.height * .02,),
//                           child: Text(Variables.amoliAdalot,
//                             textAlign: TextAlign.end,
//                             style: formTextStyle(size),
//                           ),
//                         ),
//                         Container(
//                           width: size.width*.494,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade800,width: 1),
//                               borderRadius: BorderRadius.all(Radius.circular(5))
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               isDense: true,
//                               isExpanded: true,
//                               value:_amoliAdalot,
//                               hint: Text(Variables.dropHint,style: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'hindSiliguri',
//                                 fontSize: size.height*.022,)),
//                               items:Variables.amoliAdalotList.map((category){
//                                 return DropdownMenuItem(
//                                   child: Text(category, style: formTextStyle(size),
//                                   ),
//                                   value: category,
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue)=> setState(()=>
//                               _amoliAdalot = newValue),
//                               dropdownColor: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//
//                   ///JojCourt Dropdown
//                   Container(
//                     width: size.width*.65,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: size.width*.1,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical:size.height * .02,),
//                           child: Text(Variables.jojCourt,
//                             textAlign: TextAlign.end,
//                             style: formTextStyle(size),
//                           ),
//                         ),
//                         Container(
//                           width: size.width*.494,
//                           padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade800,width: 1),
//                               borderRadius: BorderRadius.all(Radius.circular(5))
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton(
//                               isDense: true,
//                               isExpanded: true,
//                               value:_jojCourt,
//                               hint: Text('${Variables.jojCourt} নির্বাচন করুন',style: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'hindSiliguri',
//                                 fontSize: size.height*.022,)),
//                               items:Variables.jojCourtList.map((category){
//                                 return DropdownMenuItem(
//                                   child: Text(category, style: formTextStyle(size),
//                                   ),
//                                   value: category,
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue)=> setState(()=>
//                               _jojCourt = newValue),
//                               dropdownColor: Colors.white,
//                             ),
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: size.height*.01),
//
//                   ///Dayra No
//                   Container(
//                       width: size.width*.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width*.1,
//                             alignment: Alignment.centerRight,
//                             child: Text(Variables.dayraNo,style: TextStyle(
//                                 fontSize: size.height * .022,
//                                 color: Colors.grey[900],fontFamily: 'hindSiliguri')),
//                           ),
//                           Container(
//                             width: size.width*.495,
//                             child: TextFormField(
//                               controller: _dayraNo,
//                               onEditingComplete: (){},
//                               keyboardType: TextInputType.text,
//                               validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
//                               style: formTextStyle(size),
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: '১৮৩৯৩/২০২০',
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   SizedBox(height:  size.height*.02),
//
//                   ///Mamla No
//                   Container(
//                       width: size.width*.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width*.1,
//                             alignment: Alignment.centerRight,
//                             child: Text(publicProvider.crToggle(),
//                                 style: TextStyle(
//                                 fontSize: size.height * .022,
//                                 color: Colors.grey[900],fontFamily: 'hindSiliguri')),
//                           ),
//                           Container(
//                             width: size.width*.495,
//                             child: TextFormField(
//                               controller: _mamlaNo,
//                               onEditingComplete: (){},
//                               keyboardType: TextInputType.text,
//                               validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
//                               style: formTextStyle(size),
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: publicProvider.crHintToggle(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   SizedBox(height:  size.height*.02),
//
//                   ///Pokkhogoner_Nam / Dhara
//                   Container(
//                       width: size.width*.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width*.1,
//                             alignment: Alignment.centerRight,
//                             child: Text(publicProvider.pokkhoDharaToggle(),
//                                 style: TextStyle(
//                                 fontSize: size.height * .022,
//                                 color: Colors.grey[900],fontFamily: 'hindSiliguri')),
//                           ),
//                           Container(
//                             width: size.width*.495,
//                             child: TextFormField(
//                               controller: _pokkho_dhara,
//                               keyboardType: TextInputType.text,
//                               onEditingComplete: (){},
//                               validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
//                               style: formTextStyle(size),
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: publicProvider.pokkhoDharahintToggle(),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   SizedBox(height:  size.height*.02),
//
//                   ///poroborti tarikh
//                   Container(
//                       width: size.width*.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width*.1,
//                             alignment: Alignment.centerRight,
//                             child: Text(Variables.porobortiTang,style: TextStyle(
//                                 fontSize: size.height * .022,
//                                 color: Colors.grey[900],fontFamily: 'hindSiliguri')),
//                           ),
//                           Container(
//                             width: size.width*.495,
//                             child: TextFormField(
//                               controller: _nextDate,
//                               keyboardType: TextInputType.text,
//                               onEditingComplete: (){},
//                               validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
//                               style: formTextStyle(size),
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: '০৪/০৮/২০২১',
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   SizedBox(height:  size.height*.02),
//
//                   ///Bicarik adalot
//                   Container(
//                       width: size.width*.6,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: size.width*.1,
//                             alignment: Alignment.centerRight,
//                             child: Text(Variables.bicaricAdalot,style: TextStyle(
//                                 fontSize: size.height * .022,
//                                 color: Colors.grey[900],fontFamily: 'hindSiliguri')),
//                           ),
//                           Container(
//                             width: size.width*.495,
//                             child: TextFormField(
//                               controller: _bicarikAdalot,
//                               keyboardType: TextInputType.text,
//                               onEditingComplete: (){},
//                               validator: (val)=>val!.isEmpty?'${Variables.bicaricAdalot} প্রদান করুন':null,
//                               style: formTextStyle(size),
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: '৫ম যুগ্ম মহানগর দায়রা জজ আদালত',
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                   ),
//                   SizedBox(height:  size.height*.04),
//
//                   _isLoading
//                       ? Center(child: spinCircle())
//                       : GradientButton(
//                     onPressed: ()=> _updateData(publicProvider, databaseProvider),
//                     child: Text('আপডেট করুন', style: TextStyle(
//                         fontSize: size.height * .022,fontFamily: 'hindSiliguri')),
//                     height: size.height * .05,
//                     width: size.height*.5,
//                     borderRadius: 5,
//                     gradientColors: [
//                       Colors.green.shade800,
//                       Colors.green.shade700,
//                     ],
//                   ),
//                   SizedBox(height:  size.height*.04),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
//
//   Future<void> _updateData(PublicProvider publicProvider, DatabaseProvider databaseProvider)async{
//
//     if(_formKey.currentState!.validate()){
//       if(_amoliAdalot!=null){
//         setState(()=>_isLoading=true);
//         Map<String,String> map = {
//           'dayra_no': _dayraNo.text,
//           'mamla_no': _mamlaNo.text,
//           'pokkho_dhara': _pokkho_dhara.text,
//           'poroborti_tarikh': _nextDate.text,
//           'bicarik_adalot': _bicarikAdalot.text,
//           'amoli_adalot': _amoliAdalot!,
//           'boi_no': _boiNo.text,
//           'joj_court': _jojCourt!
//         };
//         await databaseProvider.updateData(publicProvider.bodliKhanaModel.id!, map).then((value)async{
//           if(value){
//             await databaseProvider.getBodliKhanaDataList();
//             showToast('Data Updated',Colors.green.shade800);
//             publicProvider.subCategory=publicProvider.previousPage;
//             setState(()=>_isLoading=false);
//           }else{
//             showToast('Data Update Failed! Try Again',Colors.green.shade800);
//             setState(()=>_isLoading=false);
//           }
//         });
//       }else showToast('${Variables.amoliAdalot} আপডেট করুন',Colors.green.shade800);
//     }
//   }
//
// }
