//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:intl/intl.dart';
// import 'package:legalfriend_admin/model_class/bodli_khana_model.dart';
// import 'package:legalfriend_admin/providers/database_provider.dart';
// import 'package:legalfriend_admin/providers/public_provider.dart';
// import 'package:legalfriend_admin/variables/static_variables.dart';
// import 'package:legalfriend_admin/widgets/form_decoration.dart';
// import 'package:legalfriend_admin/widgets/gradient_button.dart';
// import 'package:legalfriend_admin/widgets/notification_widget.dart';
// import 'package:legalfriend_admin/widgets/save_pdf.dart';
// import 'package:legalfriend_admin/widgets/table_body_tile.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';
//
// class BiseshTribunalPage extends StatefulWidget {
//   @override
//   _BiseshTribunalPageState createState() => _BiseshTribunalPageState();
// }
//
// class _BiseshTribunalPageState extends State<BiseshTribunalPage>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//   ScrollController _scrollController =ScrollController();
//   TextEditingController _thanaNameController = TextEditingController();
//   List<String> _filteredThanaList= Variables.thanaList;
//   FocusNode _dayraFocus=FocusNode();
//   bool _thanaTapped=false;
//   bool _isLoading = false;
//   int _counter = 0;
//   String? _amoliAdalot;
//   String? _jojCourt;
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _dayraNo = TextEditingController(text: '');
//   TextEditingController _dayraNo2 = TextEditingController(text: '');
//   String? _mamlaNo;
//   TextEditingController _mamlaNo2 = TextEditingController(text: '');
//   TextEditingController _dhara = TextEditingController(text: '');
//   TextEditingController _nextDate = TextEditingController(text: '');
//   TextEditingController _bicarikAdalot = TextEditingController(text: '');
//   TextEditingController _boiNo = TextEditingController(text: '');
//   TextEditingController _boiNo2 = TextEditingController(text: '');
//
//   TextEditingController _searchBoiNo = TextEditingController(text: '');
//   TextEditingController _searchMamlaNo = TextEditingController(text: '');
//   TextEditingController _searchDayraNo = TextEditingController(text: '');
//   String? _searchAmoliAdalot;
//   String? _searchjojCourt;
//   List<BodliKhanaModel> _subList = [];
//   List<BodliKhanaModel> _filteredSubList = [];
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//
//   Future<void> _customInit(DatabaseProvider databaseProvider) async {
//     setState(() => _counter++);
//     if (databaseProvider.bodliKhanaList.isEmpty) {
//       setState(() => _isLoading = true);
//       await databaseProvider.getBodliKhanaDataList().then((value) {
//         setState(() {
//           _isLoading = false;
//         });
//         setState(() {
//           _subList = databaseProvider.tribunalDataList;
//           _filteredSubList = _subList;
//         });
//       });
//     } else {
//       setState(() {
//         _subList = databaseProvider.tribunalDataList;
//         _filteredSubList = _subList;
//       });
//     }
//   }
//
//   ///SearchList builder
//   void _filterList() {
//     setState(() {
//       if(_searchBoiNo.text.isNotEmpty && _searchMamlaNo.text.isEmpty && _searchDayraNo.text.isEmpty){
//         _filteredSubList = _subList
//             .where((element) => (element.jojCourt!
//             .toLowerCase()
//             .contains(_searchjojCourt!.toLowerCase()) &&
//             element.boiNo!
//                 .toLowerCase()
//                 .contains(_searchBoiNo.text.toLowerCase()) &&
//             element.amoliAdalot!
//                 .toLowerCase()
//                 .contains(_searchAmoliAdalot!.toLowerCase())))
//             .toList();
//       }
//       else if(_searchMamlaNo.text.isNotEmpty && _searchBoiNo.text.isEmpty && _searchDayraNo.text.isEmpty){
//         _filteredSubList = _subList
//             .where((element) => (element.jojCourt!
//             .toLowerCase()
//             .contains(_searchjojCourt!.toLowerCase()) &&
//             element.amoliAdalot!
//                 .toLowerCase()
//                 .contains(_searchAmoliAdalot!.toLowerCase()) &&
//             element.mamlaNo!
//                 .toLowerCase()
//                 .contains(_searchMamlaNo.text.toLowerCase())
//         )).toList();
//       }else if(_searchDayraNo.text.isNotEmpty && _searchMamlaNo.text.isEmpty && _searchBoiNo.text.isEmpty){
//         _filteredSubList = _subList
//             .where((element) => (element.jojCourt!
//             .toLowerCase()
//             .contains(_searchjojCourt!.toLowerCase()) &&
//             element.amoliAdalot!
//                 .toLowerCase()
//                 .contains(_searchAmoliAdalot!.toLowerCase()) &&
//             element.dayraNo!
//                 .toLowerCase()
//                 .contains(_searchDayraNo.text.toLowerCase())
//         )).toList();
//       }
//       else if(_searchDayraNo.text.isEmpty && _searchMamlaNo.text.isNotEmpty && _searchBoiNo.text.isNotEmpty){
//         _filteredSubList = _subList
//             .where((element) => (element.jojCourt!
//             .toLowerCase()
//             .contains(_searchjojCourt!.toLowerCase()) &&
//             element.amoliAdalot!
//                 .toLowerCase()
//                 .contains(_searchAmoliAdalot!.toLowerCase()) &&
//             element.mamlaNo!
//                 .toLowerCase()
//                 .contains(_searchMamlaNo.text.toLowerCase()) &&
//             element.boiNo!
//                 .toLowerCase()
//                 .contains(_searchBoiNo.text.toLowerCase())
//         )).toList();
//       }
//       else if(_searchDayraNo.text.isNotEmpty && _searchMamlaNo.text.isEmpty && _searchBoiNo.text.isNotEmpty){
//         _filteredSubList = _subList
//             .where((element) => (element.jojCourt!
//             .toLowerCase()
//             .contains(_searchjojCourt!.toLowerCase()) &&
//             element.amoliAdalot!
//                 .toLowerCase()
//                 .contains(_searchAmoliAdalot!.toLowerCase()) &&
//             element.dayraNo!
//                 .toLowerCase()
//                 .contains(_searchDayraNo.text.toLowerCase()) &&
//             element.boiNo!
//                 .toLowerCase()
//                 .contains(_searchBoiNo.text.toLowerCase())
//         )).toList();
//       }
//       else{
//         _filteredSubList = _subList
//             .where((element) => (element.jojCourt!
//             .toLowerCase()
//             .contains(_searchjojCourt!.toLowerCase()) &&
//             element.boiNo!
//                 .toLowerCase()
//                 .contains(_searchBoiNo.text.toLowerCase()) &&
//             element.amoliAdalot!
//                 .toLowerCase()
//                 .contains(_searchAmoliAdalot!.toLowerCase()) &&
//             element.mamlaNo!
//                 .toLowerCase()
//                 .contains(_searchMamlaNo.text.toLowerCase()) &&
//             element.dayraNo!
//                 .toLowerCase()
//                 .contains(_searchDayraNo.text.toLowerCase())))
//             .toList();
//       }
//
//     });
//   }
//
//   void _clearFilter() {
//     setState(() {
//       _searchBoiNo.clear();
//       _searchMamlaNo.clear();
//       _searchDayraNo.clear();
//       _searchAmoliAdalot = null;
//       _searchjojCourt = null;
//       _filteredSubList = _subList;
//     });
//   }
//
//   Future<void> _refreshData(DatabaseProvider databaseProvider) async {
//     setState(() => _isLoading = true);
//     await databaseProvider.getBodliKhanaDataList().then((value) {
//       setState(() {
//         _subList = databaseProvider.tribunalDataList;
//         _filteredSubList = _subList;
//         _isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
//     final DatabaseProvider databaseProvider =
//         Provider.of<DatabaseProvider>(context);
//     if (_counter == 0) _customInit(databaseProvider);
//
//     return Container(
//       width: publicProvider.pageWidth(size),
//       color: Colors.grey[100],
//       child: Column(
//         children: [
//           TabBar(controller: _tabController, tabs: [
//             Tab(
//                 child: Text('বিশেষ ট্রাইব্যুনাল ড্যাটালিষ্ট',
//                     style: TextStyle(
//                         fontSize: size.height * .023,
//                         color: Theme.of(context).primaryColor,
//                         fontFamily: 'hindSiliguri',
//                         fontWeight: FontWeight.bold))),
//             Tab(
//                 child: Text('ডাটা এন্ট্রি ড্যাশবোর্ড',
//                     style: TextStyle(
//                         fontSize: size.height * .023,
//                         color: Theme.of(context).primaryColor,
//                         fontFamily: 'hindSiliguri',
//                         fontWeight: FontWeight.bold))),
//           ]),
//           Expanded(
//             child: TabBarView(controller: _tabController, children: [
//               _allDataWidget(size, publicProvider, databaseProvider),
//               _dataEntryWidget(size, publicProvider, databaseProvider),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _allDataWidget(Size size, PublicProvider publicProvider,
//           DatabaseProvider databaseProvider) =>
//       RawKeyboardListener(
//         focusNode: FocusNode(),
//         autofocus: true,
//         onKey: (event){
//           var offset = _scrollController.offset;
//           if(event.isKeyPressed(LogicalKeyboardKey.arrowUp)){
//             setState(() {
//               if (kReleaseMode) {
//                 _scrollController.animateTo(offset - 100, duration: Duration(milliseconds: 30), curve: Curves.ease);
//               } else {
//                 _scrollController.animateTo(offset - 100, duration: Duration(milliseconds: 30), curve: Curves.ease);
//               }
//             });
//           }
//           else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
//             setState(() {
//               if (kReleaseMode) {
//                 _scrollController.animateTo(offset + 100, duration: Duration(milliseconds: 30), curve: Curves.ease);
//               } else {
//                 _scrollController.animateTo(offset + 100, duration: Duration(milliseconds: 30), curve: Curves.ease);
//               }
//             });
//           }
//         },
//         child: Column(
//           children: [
//             ///Search Header
//             Container(
//               width: publicProvider.pageWidth(size),
//               height: 85,
//               margin: EdgeInsets.only(top: 10),
//               child: Column(
//                 children: [
//
//                   Padding(
//                     padding:  EdgeInsets.symmetric(horizontal: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ///Joj Court Dropdown
//                         Text(
//                           '${Variables.jojCourt}- ',
//                           textAlign: TextAlign.end,
//                           style: formTextStyle(size),
//                         ),
//                         Expanded(
//                           child: Container(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//                             decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.grey.shade800, width: 1),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(5))),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 isDense: true,
//                                 isExpanded: true,
//                                 value: _searchjojCourt,
//                                 hint: Text(Variables.dropHint,
//                                   style: formTextStyle(size).copyWith(color: Colors.grey)),
//                                 items: Variables.jojCourtList.map((category) {
//                                   return DropdownMenuItem(
//                                     child: Text(
//                                       category,
//                                         style: formTextStyle(size).copyWith(color: Colors.grey.shade800),
//                                     ),
//                                     value: category,
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) =>
//                                     setState(() => _searchjojCourt = newValue),
//                                 dropdownColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         ///Amoli Adalot Dropdown
//                         Text(
//                           '  ${Variables.amoliAdalot}-',
//                           textAlign: TextAlign.end,
//                             style: formTextStyle(size).copyWith(color: Colors.grey.shade800),
//                         ),
//                         Expanded(
//                           child: Container(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//                             decoration: BoxDecoration(
//                                 border:
//                                 Border.all(color: Colors.grey.shade800, width: 1),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(5))),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 isDense: true,
//                                 isExpanded: true,
//                                 value: _searchAmoliAdalot,
//                                 hint: Text(Variables.dropHint,
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontFamily: 'hindSiliguri',
//                                       fontSize: size.height * .022,
//                                     )),
//                                 items: Variables.amoliAdalotList.map((category) {
//                                   return DropdownMenuItem(
//                                     child: Text(
//                                       category,
//                                       style: formTextStyle(size),
//                                     ),
//                                     value: category,
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) =>
//                                     setState(() => _searchAmoliAdalot = newValue),
//                                 dropdownColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//
//                   Padding(
//                     padding:  EdgeInsets.symmetric(horizontal: 15),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         ///Boi No
//                         Text(
//                           '  ${Variables.boiNo}-',
//                           style: TextStyle(
//                               color: Colors.grey.shade900,
//                               fontSize: size.height * .022,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: 'hindSiliguri'),
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             controller: _searchBoiNo,
//                             decoration: boxFormDecoration(size).copyWith(
//                               hintText: '০৩/২০২০',
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: size.height * .01,
//                                   horizontal: size.height * .018),
//                             ),
//                           ),
//                         ),
//
//                         ///Mamla No
//                         Text(
//                           ' ${Variables.mamlaNo}-',
//                           style: TextStyle(
//                               color: Colors.grey.shade900,
//                               fontSize: size.height * .022,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: 'hindSiliguri'),
//                         ),
//                         Expanded(
//                             child: TextFormField(
//                               controller: _searchMamlaNo,
//                               decoration: boxFormDecoration(size).copyWith(
//                                 hintText: 'মতিঝিল-৪(৮)২১',
//                                 contentPadding: EdgeInsets.symmetric(
//                                     vertical: size.height * .01,
//                                     horizontal: size.height * .018),
//                               ),
//                             )),
//
//                         ///Dayra No
//                         Text(
//                           '  ${Variables.bishesDayraNo}-',
//                           style: TextStyle(
//                               color: Colors.grey.shade900,
//                               fontSize: size.height * .022,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: 'hindSiliguri'),
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             controller: _searchDayraNo,
//                             decoration: boxFormDecoration(size).copyWith(
//                               hintText: '০৬/২০২১',
//                               contentPadding: EdgeInsets.symmetric(
//                                   vertical: size.height * .01,
//                                   horizontal: size.height * .018),
//                             ),
//                           ),
//                         ),
//
//                         ///Search Button
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: size.height * .008),
//                           child: OutlinedButton(
//                             onPressed: () => _filterList(),
//                             child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: size.height * .008),
//                                 child: Icon(Icons.search, color: Colors.grey)),
//                           ),
//                         ),
//
//                         ///Clear Button
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: size.height * .008),
//                           child: OutlinedButton(
//                             onPressed: () => _clearFilter(),
//                             child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: size.height * .008),
//                                 child:
//                                 Icon(Icons.clear, color: Colors.redAccent)),
//                           ),
//                         ),
//
//                         ///Reload Button
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: size.height * .008),
//                           child: OutlinedButton(
//                             onPressed: () => _refreshData(databaseProvider),
//                             child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: size.height * .008),
//                                 child: Icon(Icons.refresh)),
//                           ),
//                         ),
//                         ///Download Button
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: size.height * .008),
//                           child: OutlinedButton(
//                             onPressed: ()async{
//                               if(_filteredSubList.isNotEmpty)
//                               _filterPdfData(databaseProvider, publicProvider, size);
//                               else showToast('No Data to save PDF',Colors.green.shade800);
//                             },
//                             child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: size.height * .008),
//                                 child: Icon(Icons.save_alt,color: Colors.blueGrey)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Divider(),
//
//             ///Table Header
//             Container(
//               height: 50,
//               margin: EdgeInsets.only(top: 10),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       _tableHeaderBuilder(size, Variables.bishesDayraNo),
//                       _tableHeaderBuilder(size, Variables.mamlaNo),
//                       _tableHeaderBuilder(size, Variables.dhara),
//                       _tableHeaderBuilder(size, Variables.porobortiTang),
//                       _tableHeaderBuilder(size, Variables.bicaricAdalot),
//                       _tableHeaderBuilder(size, Variables.amoliAdalot),
//                       _tableHeaderBuilder(size, Variables.mamlarDhoron),
//                       _tableHeaderBuilder(size, Variables.boiNo),
//                       _tableHeaderBuilder(size, Variables.jojCourt),
//                       _tableHeaderBuilder(size, ''),
//                     ],
//                   ),
//                   Divider(color: Colors.grey.shade800,height: 5.0)
//                 ],
//               ),
//             ),
//
//             ///Table Body
//             _isLoading
//                 ? Padding(
//                     padding: EdgeInsets.only(top: 100),
//                     child: Center(child: spinCircle()),
//                   )
//                 : _filteredSubList.isNotEmpty
//                     ? Expanded(
//                         child: Scrollbar(
//                           controller: _scrollController,
//                           isAlwaysShown: true,
//                           showTrackOnHover: true,
//                           child: ListView.builder(
//                             controller: _scrollController,
//                             //shrinkWrap: true,
//                             physics: ClampingScrollPhysics(),
//                             itemCount: _filteredSubList.length,
//                             itemBuilder: (context, index) => TableBodyTile(
//                                 index: index, dataList: _filteredSubList),
//                           ),
//                         ),
//                       )
//                     : Center(
//                         child: Column(
//                         children: [
//                           SizedBox(height: 100),
//                           Text('কোন ডেটা নেই!',
//                               style: TextStyle(
//                                   fontFamily: 'hindSiliguri',
//                                   fontSize: size.height * .026,
//                                   color: Color(0xffF5B454))),
//                           TextButton(
//                               onPressed: () async {
//                                 setState(() => _isLoading = true);
//                                 await databaseProvider
//                                     .getBodliKhanaDataList()
//                                     .then((value) {
//                                   setState(() => _isLoading = false);
//                                 });
//                               },
//                               child: Text(
//                                 'রিফ্রেশ করুন',
//                                 style: TextStyle(
//                                   fontFamily: 'hindSiliguri',
//                                   fontSize: size.height * .021,
//                                 ),
//                               ))
//                         ],
//                       ))
//           ],
//         ),
//       );
//
//   Widget _tableHeaderBuilder(Size size, String tableHeader) {
//     return Expanded(
//       child: Container(
//         alignment: Alignment.center,
//         child: Text(
//           tableHeader,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               color: Colors.grey.shade900,
//               fontSize: size.height * .022,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'hindSiliguri'),
//         ),
//       ),
//     );
//   }
//
//   Widget _dataEntryWidget(Size size, PublicProvider publicProvider,
//           DatabaseProvider databaseProvider) =>
//       RawKeyboardListener(
//         focusNode: FocusNode(),
//         autofocus: true,
//         onKey: (event){
//           if(event.isKeyPressed(LogicalKeyboardKey.enter)){
//             _saveData(databaseProvider);
//           }
//         },
//         child: Center(
//           child: Container(
//             width: size.width * .65,
//             height: size.height * .8,
//             margin: EdgeInsets.symmetric(vertical: size.height * .04),
//             decoration: BoxDecoration(color: Colors.white, boxShadow: [
//               BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(1, 5))
//             ]),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(height: size.height * .02),
//                     Text(
//                       '${Variables.mamlarDhoron} - ${Variables.bisesTribunal}',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: size.height * .023,
//                           color: Colors.grey[900],
//                           fontFamily: 'hindSiliguri',
//                           fontWeight: FontWeight.w500,
//                           decoration: TextDecoration.underline),
//                     ),
//                     SizedBox(height: size.height * .04),
//
//                     ///boi No
//                     Container(
//                         width: size.width * .6,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: size.width * .1,
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 Variables.boiNo,
//                                 style: formTextStyle(size),
//                               ),
//                             ),
//                             Container(
//                               width: size.width * .24,
//                               child: TextFormField(
//                                 controller: _boiNo,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.boiNo} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '৩',
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               '/',
//                               style: TextStyle(
//                                   color: Colors.grey[900],
//                                   fontSize: size.height * .022,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'hindSiliguri'),
//                             ),
//                             Container(
//                               width: size.width * .24,
//                               child: TextFormField(
//                                 controller: _boiNo2,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.boiNo} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '২০২১',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                     SizedBox(height: size.height * .01),
//
//                     ///JojCourt Dropdown
//                     Container(
//                       width: size.width * .65,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: size.width * .1,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: size.height * .02,
//                             ),
//                             child: Text(
//                               Variables.jojCourt,
//                               textAlign: TextAlign.end,
//                               style: formTextStyle(size),
//                             ),
//                           ),
//                           Container(
//                             width: size.width * .494,
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                                 border:
//                                     Border.all(color: Colors.grey.shade800, width: 1),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5))),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 isDense: true,
//                                 isExpanded: true,
//                                 value: _jojCourt,
//                                 menuMaxHeight: 300.0,
//                                 itemHeight: 50,
//                                 hint: Text(Variables.dropHint,
//                                   style: formTextStyle(size).copyWith(color: Colors.grey)),
//                                 items: Variables.jojCourtList.map((category) {
//                                   return DropdownMenuItem(
//                                     child: Text(
//                                       category,
//                                       style: formTextStyle(size),
//                                     ),
//                                     value: category,
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) =>
//                                     setState(() => _jojCourt = newValue),
//                                 dropdownColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     ///Amoli Adalot Dropdown
//                     Container(
//                       width: size.width * .65,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: size.width * .1,
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10,
//                               vertical: size.height * .02,
//                             ),
//                             child: Text(
//                               Variables.amoliAdalot,
//                               textAlign: TextAlign.end,
//                               style: formTextStyle(size),
//                             ),
//                           ),
//                           Container(
//                             width: size.width * .494,
//                             padding:
//                                 EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                             decoration: BoxDecoration(
//                                 border:
//                                     Border.all(color: Colors.grey.shade800, width: 1),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5))),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 isDense: true,
//                                 isExpanded: true,
//                                 value: _amoliAdalot,
//                                 hint: Text(Variables.dropHint,
//                                   style: formTextStyle(size).copyWith(color: Colors.grey)),
//                                 items: Variables.amoliAdalotList.map((category) {
//                                   return DropdownMenuItem(
//                                     child: Text(
//                                       category,
//                                       style: formTextStyle(size),
//                                     ),
//                                     value: category,
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) =>
//                                     setState(() => _amoliAdalot = newValue),
//                                 dropdownColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: size.height * .01),
//
//                     ///Dayra No
//                     Container(
//                         width: size.width * .6,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: size.width * .1,
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 '${Variables.bishesDayraNo}- ',
//                                 style: formTextStyle(size),
//                               ),
//                             ),
//                             Container(
//                               width: size.width * .24,
//                               child: TextFormField(
//                                 controller: _dayraNo,
//                                 focusNode: _dayraFocus,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.bishesDayraNo} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '১৮৩৯৩',
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               '/',
//                               style: TextStyle(
//                                   color: Colors.grey[900],
//                                   fontSize: size.height * .022,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'hindSiliguri'),
//                             ),
//                             Container(
//                               width: size.width * .24,
//                               child: TextFormField(
//                                 controller: _dayraNo2,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.bishesDayraNo} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '২০২০',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                     ),
//                     SizedBox(height: size.height * .02),
//
//                     /// Mamla No
//                     Container(
//                         width: size.width * .6,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: size.width * .1,
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 Variables.mamlaNo,
//                                 style: formTextStyle(size).copyWith(color: Colors.grey.shade800),
//                               ),
//                             ),
//
//                             ///Search Dropdown
//                             Container(
//                               width: size.width * .24,
//                               padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey.shade800, width: 1),
//                                   borderRadius: BorderRadius.all(Radius.circular(5))),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   TextFormField(
//                                     controller:_thanaNameController,
//                                     onChanged: (val){
//                                       setState(() {
//                                         _thanaTapped=true;
//                                         _filteredThanaList = Variables.thanaList.where((element) =>
//                                             element.toLowerCase().contains(_thanaNameController.text.toLowerCase())).toList();
//                                       });
//                                     },
//                                     onTap: (){
//                                       setState(()=> _thanaTapped=!_thanaTapped);
//                                     },
//                                     onEditingComplete: (){},
//                                     validator: (val) => val!.isEmpty
//                                         ?'থানার নাম প্রদান করুন'
//                                         :null,
//                                     keyboardType: TextInputType.text,
//                                     style: formTextStyle(size),
//                                     decoration: InputDecoration(
//                                         hintText:'থানার নাম',
//                                         isDense: true,
//                                         hintStyle:formTextStyle(size).copyWith(color: Colors.grey),
//                                         errorStyle: formTextStyle(size).copyWith(color: Colors.red,fontSize: size.height*.02),
//                                         border: UnderlineInputBorder(
//                                             borderSide: BorderSide.none
//                                         )
//                                     ),
//                                   ),
//
//                                   _thanaTapped? Container(
//                                     height: 100.0,
//                                     child: ListView.builder(
//                                       itemCount: _filteredThanaList.length,
//                                       itemBuilder: (context,index)=>InkWell(
//                                           onTap: (){
//                                             setState((){
//                                               _thanaTapped=!_thanaTapped;
//                                               _thanaNameController.text=_filteredThanaList[index];
//                                               _mamlaNo=_filteredThanaList[index];
//                                               print(_mamlaNo=_filteredThanaList[index]);
//                                             });
//                                           },
//                                           child: Text(_filteredThanaList[index],
//                                             style: formTextStyle(size).copyWith(color: Colors.grey.shade600),)),
//                                     ),
//                                   ):Container(),
//                                 ],
//                               ),
//                             ),
//
//                             Text(
//                               '-',
//                               style: TextStyle(
//                                   color: Colors.grey[900],
//                                   fontSize: size.height * .022,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'hindSiliguri'),
//                             ),
//                             Container(
//                               width: size.width * .24,
//                               child: TextFormField(
//                                 controller: _mamlaNo2,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.crMamlaNo} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '৪(৮)২১',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                     SizedBox(height: size.height * .02),
//
//                     ///Dhara
//                     Container(
//                         width: size.width * .6,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: size.width * .1,
//                               alignment: Alignment.centerRight,
//                               child: Text(Variables.dhara,
//                                 style: formTextStyle(size)),
//                             ),
//                             Container(
//                               width: size.width * .495,
//                               child: TextFormField(
//                                 controller: _dhara,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.dhara} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '৩৬(১) এর ১০(গ),৪১',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                     ),
//                     SizedBox(height: size.height * .02),
//
//                     ///poroborti tarikh
//                     Container(
//                         width: size.width * .6,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: size.width * .1,
//                               alignment: Alignment.centerRight,
//                               child: Text(Variables.porobortiTang,
//                                 style: formTextStyle(size)),
//                             ),
//                             Container(
//                               width: size.width * .495,
//                               child: TextFormField(
//                                 controller: _nextDate,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.porobortiTarikh} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '০৪/০৮/২০২১',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                     SizedBox(height: size.height * .02),
//
//                     ///Bicarik adalot
//                     Container(
//                         width: size.width * .6,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: size.width * .1,
//                               alignment: Alignment.centerRight,
//                               child: Text(Variables.bicaricAdalot,
//                                 style: formTextStyle(size)),
//                             ),
//                             Container(
//                               width: size.width * .495,
//                               child: TextFormField(
//                                 controller: _bicarikAdalot,
//                                 onEditingComplete: (){},
//                                 validator: (val) => val!.isEmpty
//                                     ? '${Variables.bicaricAdalot} প্রদান করুন'
//                                     : null,
//                                 keyboardType: TextInputType.text,
//                                 style: formTextStyle(size),
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '৫ম যুগ্ম মহানগর দায়রা জজ আদালত',
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                     SizedBox(height: size.height * .04),
//
//                     _isLoading
//                         ? Center(child: spinCircle())
//                         : GradientButton(
//                             onPressed: () {
//                               _saveData(databaseProvider);
//                             },
//                             child: Text(Variables.save,
//                               style: formTextStyle(size).copyWith(color: Colors.white)),
//                             height: size.height * .05,
//                             width: size.height * .5,
//                             borderRadius: 5,
//                             gradientColors: [
//                               Colors.green.shade800,
//                               Colors.green.shade700,
//                             ],
//                           ),
//                     SizedBox(height: size.height * .04),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//
//   Future<void> _saveData(DatabaseProvider databaseProvider) async {
//     if (_formKey.currentState!.validate()) {
//       if (_amoliAdalot != null && _jojCourt != null && _mamlaNo != null) {
//         setState(() => _isLoading = true);
//         var uuid = Uuid();
//         String id = uuid.v1();
//         String date = DateFormat("dd-MM-yyyy").format(
//             DateTime.fromMillisecondsSinceEpoch(
//                 DateTime.now().millisecondsSinceEpoch));
//         Map<String, String> map = {
//           'id': id,
//           'dayra_no': '${_dayraNo.text}/${_dayraNo2.text}',
//           'mamla_no': '$_mamlaNo-${_mamlaNo2.text}',
//           'pokkho_dhara': _dhara.text,
//           'poroborti_tarikh': _nextDate.text,
//           'bicarik_adalot': _bicarikAdalot.text,
//           'amoli_adalot': _amoliAdalot!,
//           'joj_court': _jojCourt!,
//           'mamlar_dhoron': '${Variables.bisesTribunal}',
//           'boi_no': '${_boiNo.text}/${_boiNo2.text}',
//           'entry_date': date
//         };
//         await databaseProvider.saveData(map).then((value) {
//           if (value) {
//             _dayraNo.clear();
//             //_dayraNo2.clear();
//             _mamlaNo2.clear();
//             _dhara.clear();
//             _nextDate.clear();
//             //_bicarikAdalot.clear();
//             _thanaNameController.clear();
//             _dayraFocus.requestFocus();
//             showToast('Data Saved',Colors.green.shade800);
//             setState(() => _isLoading = false);
//           } else {
//             showToast('Data Insert Failed! Try Again',Colors.green.shade800);
//             setState(() => _isLoading = false);
//           }
//         });
//       } else
//         showToast(
//             'সকল ফর্ম পূরন করুন',Colors.green.shade800);
//     }
//
//   }
//
//   void _filterPdfData(DatabaseProvider databaseProvider, PublicProvider publicProvider,Size size){
//     TextEditingController _pdfDayra1=TextEditingController(text: '');
//     TextEditingController _pdfDayra2=TextEditingController(text: '');
//     TextEditingController _pdfBoiNo=TextEditingController(text: '');
//     String? _pdfAmoliAdalot;
//     String? _pdfJojCourt;
//     final _formKey = GlobalKey<FormState>();
//     List<BodliKhanaModel> pdfDataList=[];
//
//     showAnimatedDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_){
//         return AlertDialog(
//             scrollable: true,
//             content: StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState){
//                 return Container(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         SizedBox(height: size.height*.04),
//
//                         ///joj amoli
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             ///Joj Court Dropdown
//                             Text(
//                               '${Variables.jojCourt}- ',
//                               textAlign: TextAlign.end,
//                               style: formTextStyle(size),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding:
//                                 EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey.shade800, width: 1),
//                                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton(
//                                     isDense: true,
//                                     isExpanded: true,
//                                     value: _pdfJojCourt,
//                                     hint: Text(Variables.dropHint,
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontFamily: 'hindSiliguri',
//                                           fontSize: size.height * .022,
//                                         )),
//                                     items: Variables.jojCourtList.map((category) {
//                                       return DropdownMenuItem(
//                                         child: Text(
//                                           category,
//                                           style: formTextStyle(size),
//                                         ),
//                                         value: category,
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       setState(() => _pdfJojCourt = newValue!);
//                                       print(_pdfJojCourt);},
//                                     dropdownColor: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             ///Amoli Adalot Dropdown
//                             Text(
//                               '  ${Variables.amoliAdalot}- ',
//                               textAlign: TextAlign.end,
//                               style: formTextStyle(size),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 padding:
//                                 EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//                                 decoration: BoxDecoration(
//                                     border:
//                                     Border.all(color: Colors.grey.shade800, width: 1),
//                                     borderRadius:
//                                     BorderRadius.all(Radius.circular(5))),
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton(
//                                     isDense: true,
//                                     isExpanded: true,
//                                     value: _pdfAmoliAdalot,
//                                     hint: Text(Variables.dropHint,
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontFamily: 'hindSiliguri',
//                                           fontSize: size.height * .022,
//                                         )),
//                                     items: Variables.amoliAdalotList.map((category) {
//                                       return DropdownMenuItem(
//                                         child: Text(
//                                           category,
//                                           style: formTextStyle(size),
//                                         ),
//                                         value: category,
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       setState(() => _pdfAmoliAdalot = newValue!);
//                                       print(_pdfAmoliAdalot);},
//                                     dropdownColor: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: size.height*.04),
//
//                         ///Boi no
//                         Row(
//                           children: [
//                             Text('বই নং- ',style: formTextStyle(size)),
//                             Expanded(
//                               child: TextFormField(
//                                 controller: _pdfBoiNo,
//                                 validator: (val)=>val!.isEmpty?'Enter Data':null,
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '১/২০২১',
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: size.height * .01,
//                                       horizontal: size.height * .018),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: size.height*.04),
//
//                         ///Dayra NO
//                         Row(
//                           children: [
//                             Text('দায়রা নং- ',style: formTextStyle(size)),
//                             Expanded(
//                               child: TextFormField(
//                                 controller: _pdfDayra1,
//                                 validator: (val)=>val!.isEmpty?'Enter Data':null,
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '৫০১/২০২১',
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: size.height * .01,
//                                       horizontal: size.height * .018),
//                                 ),
//                               ),
//                             ),
//                             Text(' - '),
//                             Expanded(
//                               child: TextFormField(
//                                 controller: _pdfDayra2,
//                                 validator: (val)=>val!.isEmpty?'Enter Data':null,
//                                 decoration: boxFormDecoration(size).copyWith(
//                                   hintText: '৬০১/২০২১',
//                                   contentPadding: EdgeInsets.symmetric(
//                                       vertical: size.height * .01,
//                                       horizontal: size.height * .018),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: size.height*.04),
//
//                         ///Button
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton(
//                                 onPressed: (){
//                                   if(_formKey.currentState!.validate()){
//                                     for(int i=0; i< _filteredSubList.length; i++){
//                                       if(
//                                       int.parse(databaseProvider.bnToEnNumberConvert(_filteredSubList[i].dayraNo!))>=
//                                           int.parse(databaseProvider.bnToEnNumberConvert(_pdfDayra1.text))
//                                           && int.parse(databaseProvider.bnToEnNumberConvert(_filteredSubList[i].dayraNo!))<=
//                                           int.parse(databaseProvider.bnToEnNumberConvert(_pdfDayra2.text))
//                                           && _filteredSubList[i].jojCourt! == _pdfJojCourt
//                                           && _filteredSubList[i].amoliAdalot! == _pdfAmoliAdalot
//                                           && _filteredSubList[i].boiNo! == _pdfBoiNo.text
//                                       ){
//                                         pdfDataList.add(_filteredSubList[i]);
//                                       }
//                                     }
//                                     if(pdfDataList.isNotEmpty)SavePDF.savePdf(pdfDataList, publicProvider.subCategory,context);
//                                     else showToast('কোন ডেটা খুজে পাওয়া যায়নি',Colors.green);
//
//                                   }
//                                 },
//                                 child: Text('ডাউনলোড')
//                             ),
//
//                             ElevatedButton(
//                               onPressed: ()=>Navigator.pop(context),
//                               child: Text('বাতিল'),
//                               style: ButtonStyle(
//                                   backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             )
//         );
//       },
//       animationType: DialogTransitionType.slideFromTopFade,
//       curve: Curves.fastOutSlowIn,
//       duration: Duration(milliseconds: 500),
//     );
//
//   }
// }