import 'package:admin_app/model_class/bodli_khana_model.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/gradient_button.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:admin_app/widgets/save_pdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BiseshTribunalPage extends StatefulWidget {
  const BiseshTribunalPage({Key? key}) : super(key: key);

  @override
  _BiseshTribunalPageState createState() => _BiseshTribunalPageState();
}

class _BiseshTribunalPageState extends State<BiseshTribunalPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController _thanaNameController = TextEditingController();
  List<String> _filteredThanaList= Variables.thanaList;
  final  FocusNode _dayraFocus=FocusNode();
  bool _thanaTapped=false;
  bool _isLoading = false;
  int _counter = 0;
  String? _amoliAdalot;
  String? _jojCourt;
  final _formKey = GlobalKey<FormState>();
  final  TextEditingController _dayraNo = TextEditingController(text: '');
  final  TextEditingController _dayraNo2 = TextEditingController(text: '');
  String? _mamlaNo;
  final  TextEditingController _mamlaNo2 = TextEditingController(text: '');
  final   TextEditingController _dhara = TextEditingController(text: '');
  final   TextEditingController _nextDate = TextEditingController(text: '');
  final   TextEditingController _bicarikAdalot = TextEditingController(text: '');
  final  TextEditingController _boiNo = TextEditingController(text: '');
  final  TextEditingController _boiNo2 = TextEditingController(text: '');

  final  TextEditingController _searchBoiNo = TextEditingController(text: '');
  final  TextEditingController _searchMamlaNo = TextEditingController(text: '');
  final  TextEditingController _searchDayraNo = TextEditingController(text: '');
  String? _searchAmoliAdalot;
  String? _searchjojCourt;
  List<BodliKhanaModel> _subList = [];
  List<BodliKhanaModel> _filteredSubList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _customInit(DatabaseProvider databaseProvider) async {
    setState(() => _counter++);
    if (databaseProvider.tribunalDataList.isEmpty) {
      setState(() => _isLoading = true);
      await databaseProvider.getBiseshTribunalDataList().then((value) {
        setState(() {
          _isLoading = false;
        });
        setState(() {
          _subList = databaseProvider.tribunalDataList;
          _filteredSubList = _subList;
        });
      });
    } else {
      setState(() {
        _subList = databaseProvider.tribunalDataList;
        _filteredSubList = _subList;
      });
    }
  }

  ///SearchList builder
  void _filterList() {
    setState(() {
      if(_searchBoiNo.text.isNotEmpty && _searchMamlaNo.text.isEmpty && _searchDayraNo.text.isEmpty){
        _filteredSubList = _subList
            .where((element) => (element.jojCourt!
            .toLowerCase()
            .contains(_searchjojCourt!.toLowerCase()) &&
            element.boiNo!
                .toLowerCase()
                .contains(_searchBoiNo.text.toLowerCase()) &&
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase())))
            .toList();
      }
      else if(_searchMamlaNo.text.isNotEmpty && _searchBoiNo.text.isEmpty && _searchDayraNo.text.isEmpty){
        _filteredSubList = _subList
            .where((element) => (element.jojCourt!
            .toLowerCase()
            .contains(_searchjojCourt!.toLowerCase()) &&
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase()) &&
            element.mamlaNo!
                .toLowerCase()
                .contains(_searchMamlaNo.text.toLowerCase())
        )).toList();
      }else if(_searchDayraNo.text.isNotEmpty && _searchMamlaNo.text.isEmpty && _searchBoiNo.text.isEmpty){
        _filteredSubList = _subList
            .where((element) => (element.jojCourt!
            .toLowerCase()
            .contains(_searchjojCourt!.toLowerCase()) &&
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase()) &&
            element.dayraNo!
                .toLowerCase()
                .contains(_searchDayraNo.text.toLowerCase())
        )).toList();
      }
      else if(_searchDayraNo.text.isEmpty && _searchMamlaNo.text.isNotEmpty && _searchBoiNo.text.isNotEmpty){
        _filteredSubList = _subList
            .where((element) => (element.jojCourt!
            .toLowerCase()
            .contains(_searchjojCourt!.toLowerCase()) &&
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase()) &&
            element.mamlaNo!
                .toLowerCase()
                .contains(_searchMamlaNo.text.toLowerCase()) &&
            element.boiNo!
                .toLowerCase()
                .contains(_searchBoiNo.text.toLowerCase())
        )).toList();
      }
      else if(_searchDayraNo.text.isNotEmpty && _searchMamlaNo.text.isEmpty && _searchBoiNo.text.isNotEmpty){
        _filteredSubList = _subList
            .where((element) => (element.jojCourt!
            .toLowerCase()
            .contains(_searchjojCourt!.toLowerCase()) &&
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase()) &&
            element.dayraNo!
                .toLowerCase()
                .contains(_searchDayraNo.text.toLowerCase()) &&
            element.boiNo!
                .toLowerCase()
                .contains(_searchBoiNo.text.toLowerCase())
        )).toList();
      }
      else{
        _filteredSubList = _subList
            .where((element) => (element.jojCourt!
            .toLowerCase()
            .contains(_searchjojCourt!.toLowerCase()) &&
            element.boiNo!
                .toLowerCase()
                .contains(_searchBoiNo.text.toLowerCase()) &&
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase()) &&
            element.mamlaNo!
                .toLowerCase()
                .contains(_searchMamlaNo.text.toLowerCase()) &&
            element.dayraNo!
                .toLowerCase()
                .contains(_searchDayraNo.text.toLowerCase())))
            .toList();
      }

    });
  }

  void _clearFilter() {
    setState(() {
      _searchBoiNo.clear();
      _searchMamlaNo.clear();
      _searchDayraNo.clear();
      _searchAmoliAdalot = null;
      _searchjojCourt = null;
      _filteredSubList = _subList;
    });
  }

  Future<void> _refreshData(DatabaseProvider databaseProvider) async {
    setState(() => _isLoading = true);
    await databaseProvider.getBiseshTribunalDataList().then((value) {
      setState(() {
        _subList = databaseProvider.tribunalDataList;
        _filteredSubList = _subList;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size = publicProvider.size;
    if (_counter == 0) _customInit(databaseProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Variables.bisesTribunal),
        elevation: 00,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('মোট:- ${_filteredSubList.length}'),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(controller: _tabController, tabs: [
            Tab(
                child: Text('বিশেষ ট্রাইব্যুনাল ড্যাটালিষ্ট',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
            Tab(
                child: Text('ডাটা এন্ট্রি ড্যাশবোর্ড',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
          ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              _allDataWidget(size, publicProvider, databaseProvider),
              _dataEntryWidget(size, publicProvider, databaseProvider),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _allDataWidget(double size, PublicProvider publicProvider,
          DatabaseProvider databaseProvider) =>
      Column(
        children: [
          ///Search Header
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size*.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Joj Court Dropdown
                      Text(
                        '${Variables.jojCourt}- ',
                        textAlign: TextAlign.end,
                        style: formTextStyle(size),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade800, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              value: _searchjojCourt,
                              hint: Text(Variables.dropHint,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:size*.04,
                                  )),
                              items: Variables.jojCourtList.map((category) {
                                return DropdownMenuItem(
                                  child: Text(
                                    category,
                                    style: formTextStyle(size),
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (String? newValue) =>
                                  setState(() => _searchjojCourt = newValue),
                              dropdownColor: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      ///Amoli Adalot Dropdown
                      Text(
                        ' ${Variables.amoliAdalot}- ',
                        textAlign: TextAlign.end,
                        style: formTextStyle(size),
                      ),
                      Expanded(
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.grey.shade800, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(5))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              value: _searchAmoliAdalot,
                              hint: Text(Variables.dropHint,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size*.04,
                                  )),
                              items: Variables.amoliAdalotList.map((category) {
                                return DropdownMenuItem(
                                  child: Text(
                                    category,
                                    style: formTextStyle(size),
                                  ),
                                  value: category,
                                );
                              }).toList(),
                              onChanged: (String? newValue) =>
                                  setState(() => _searchAmoliAdalot = newValue),
                              dropdownColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size*.04),

                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Boi No
                      Text(
                        '${Variables.boiNo}- ',
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: size* .04,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'hindSiliguri'),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _searchBoiNo,
                          decoration: boxFormDecoration(size).copyWith(
                            hintText: '০৩/২০২০',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size* .01,
                                horizontal: size* .018),
                          ),
                        ),
                      ),

                      ///Mamla No
                      Text(
                        ' ${Variables.mamlaNo}- ',
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: size* .04,
                            fontWeight: FontWeight.w400),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _searchMamlaNo,
                          decoration: boxFormDecoration(size).copyWith(
                            hintText: '০৩/২০২০',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size* .01,
                                horizontal: size * .018),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size*.04),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Dayra No
                      Text(
                        '${Variables.bishesDayraNo}- ',
                        style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: size* .04,
                            fontWeight: FontWeight.w400),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _searchDayraNo,
                          decoration: boxFormDecoration(size).copyWith(
                            hintText: '০৩/২০২০',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size* .01,
                                horizontal: size* .018),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///Download Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size* .008),
                        child: OutlinedButton(
                          onPressed: ()async{
                            if(_filteredSubList.isNotEmpty) {
                              _filterPdfData(databaseProvider, publicProvider,size);
                            } else {
                              showToast('No Data to save PDF');
                            }
                          },
                          child: const Icon(Icons.save_alt,color: Colors.blueGrey),
                        ),
                      ),

                      ///Reload Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size* .008),
                        child: OutlinedButton(
                          onPressed: () => _refreshData(databaseProvider),
                          child: const Icon(Icons.refresh),
                        ),
                      ),

                      ///Clear Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size* .008),
                        child: OutlinedButton(
                          onPressed: () => _clearFilter(),
                          child: const Icon(Icons.clear, color: Colors.redAccent),
                        ),
                      ),
                      ///Search Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size* .008),
                        child: OutlinedButton(
                          onPressed: () => _filterList(),
                          child: const Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          _isLoading
              ? Center(child: spinCircle())
              : _filteredSubList.isNotEmpty
              ? Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: _filteredSubList.length,
                itemBuilder: (context, index) =>  Card(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(size*.02,size*.02,size*.02,0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: formTextStyle(size),
                            children: <TextSpan>[
                              const TextSpan(text: '${Variables.bishesDayraNo}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].dayraNo}\n'),
                              const TextSpan(text: '${Variables.mamlaNo}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].mamlaNo}\n'),
                              const TextSpan(text: '${Variables.dhara}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].pokkhoDhara}\n'),
                              const TextSpan(text: '${Variables.porobortiTarikh}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].porobortiTarikh}\n'),
                              const TextSpan(text: '${Variables.bicaricAdalot}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].bicarikAdalot}\n'),
                              const TextSpan(text: '${Variables.amoliAdalot}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].amoliAdalot}\n'),
                              const TextSpan(text: '${Variables.mamlarDhoron}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].mamlarDhoron}\n'),
                              const TextSpan(text: '${Variables.boiNo}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].boiNo}\n'),
                              const TextSpan(text: '${Variables.jojCourt}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${_filteredSubList[index].jojCourt}'),
                            ],
                          ),
                        ),

                        ///Update & Delete Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text('আপডেট',
                                  style: TextStyle(fontSize: size*.04)),
                              onPressed: (){},
                            ),
                            TextButton(
                                child: Text('ডিলিট',
                                    style: TextStyle(color: Colors.redAccent,fontSize: size*.04)
                                ),
                                onPressed: (){
                                  showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ClassicGeneralDialogWidget(
                                        titleText: 'Delete This Data?',
                                        positiveText: 'YES',
                                        negativeText: 'NO',
                                        negativeTextStyle: TextStyle(
                                            color: Colors.green,
                                            fontSize: size*.04),
                                        positiveTextStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: size*.04),
                                        onPositiveClick: () async{
                                          showLoadingDialog(context);
                                          await databaseProvider.deleteData(_filteredSubList[index].id!).then((value)async{
                                            if(value){
                                              await databaseProvider.getNIActDataList();
                                              closeLoadingDialog(context);
                                              closeLoadingDialog(context);
                                              showToast('Data Deleted Success');
                                            }else{
                                              closeLoadingDialog(context);
                                              closeLoadingDialog(context);
                                              showToast('Failed! Try Again');
                                            }
                                          });
                                        },
                                        onNegativeClick: () => Navigator.of(context).pop(),
                                      );
                                    },
                                    animationType: DialogTransitionType.slideFromTopFade,
                                    curve: Curves.fastOutSlowIn,
                                    duration: const Duration(milliseconds: 500),
                                  );
                                }
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))
              : Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text('কোন ডেটা নেই!',
                      style: TextStyle(
                          fontSize: size* .04,
                          color: const Color(0xffF5B454))),
                  TextButton(
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        await databaseProvider.getMadokDataList().then((value) {
                          setState(() => _isLoading = false);
                        });
                      },
                      child: Text(
                        'রিফ্রেশ করুন',
                        style: TextStyle(fontSize: size* .04),
                      ))
                ],
              ))
        ],
      );

  Widget _dataEntryWidget(double size, PublicProvider publicProvider,
          DatabaseProvider databaseProvider) =>
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size*.04),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size* .02),
                Text(
                  '${Variables.mamlarDhoron} - ${Variables.bisesTribunal}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size* .05,
                      color: Variables.textColor,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: size* .04),

                ///boi No
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${Variables.boiNo} ',
                        style: formTextStyle(size),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _boiNo,
                        autofocus: true,
                        focusNode: FocusNode(canRequestFocus: true),
                        validator: (val) => val!.isEmpty
                            ? '${Variables.boiNo} প্রদান করুন'
                            : null,
                        //keyboardType: TextInputType.number,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '৩',
                        ),
                      ),
                    ),
                    Text(' / ',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: size* .06),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _boiNo2,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.boiNo} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.text,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '২০১৯',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///JojCourt Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Variables.jojCourt} ',
                      style: formTextStyle(size),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade800, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,
                            isExpanded: true,
                            value: _jojCourt,
                            hint: Text(Variables.dropHint,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size* .04,
                                )),
                            items: Variables.jojCourtList.map((category) {
                              return DropdownMenuItem(
                                child: Text(
                                  category,
                                  style: formTextStyle(size),
                                ),
                                value: category,
                              );
                            }).toList(),
                            onChanged: (String? newValue) =>
                                setState(() => _jojCourt = newValue),
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///Amoli Adalot Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Variables.amoliAdalot} ',
                      style: formTextStyle(size),
                    ),
                    Expanded(
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade800, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isDense: true,
                            isExpanded: true,
                            value: _amoliAdalot,
                            hint: Text(Variables.dropHint,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size* .04,
                                )),
                            items: Variables.amoliAdalotList.map((category) {
                              return DropdownMenuItem(
                                child: Text(
                                  category,
                                  style: formTextStyle(size),
                                ),
                                value: category,
                              );
                            }).toList(),
                            onChanged: (String? newValue) =>
                                setState(() => _amoliAdalot = newValue),
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///Dayra No
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Variables.bishesDayraNo} ',
                      style: formTextStyle(size),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _dayraNo,
                        focusNode: _dayraFocus,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.dayraNo} প্রদান করুন'
                            : null,
                        //keyboardType: TextInputType.number,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '১৮৩৯৩',
                        ),
                      ),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: size*.06),
                    ),
                    SizedBox(
                      width: size* .24,
                      child: TextFormField(
                        controller: _dayraNo2,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.dayraNo} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.text,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '২০২০',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///Mamla No
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Variables.mamlaNo} ',
                      style: formTextStyle(size),
                    ),
                    ///Search Dropdown
                    Expanded(
                      child: Container(
                        padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade800, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller:_thanaNameController,
                              onChanged: (val){
                                setState(() {
                                  _thanaTapped=true;
                                  _filteredThanaList = Variables.thanaList.where((element) =>
                                      element.toLowerCase().contains(_thanaNameController.text.toLowerCase())).toList();
                                });
                              },
                              onTap: (){
                                setState(()=> _thanaTapped=!_thanaTapped);
                              },
                              validator: (val) => val!.isEmpty
                                  ?'থানার নাম প্রদান করুন'
                                  :null,
                              keyboardType: TextInputType.text,
                              style: formTextStyle(size).copyWith(color: Colors.grey.shade800),
                              decoration: InputDecoration(
                                  hintText:'থানার নাম',
                                  isDense: true,
                                  hintStyle:formTextStyle(size).copyWith(color: Colors.grey),
                                  errorStyle: formTextStyle(size).copyWith(color: Colors.red,fontSize: size*.04),
                                  border: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                  )
                              ),
                            ),

                            _thanaTapped? SizedBox(
                              height: 100.0,
                              child: ListView.builder(
                                itemCount: _filteredThanaList.length,
                                itemBuilder: (context,index)=>InkWell(
                                    onTap: (){
                                      setState((){
                                        _thanaTapped=!_thanaTapped;
                                        _thanaNameController.text=_filteredThanaList[index];
                                        _mamlaNo=_filteredThanaList[index];
                                        print(_mamlaNo=_filteredThanaList[index]);
                                      });
                                    },
                                    child: Text(_filteredThanaList[index],
                                      style: formTextStyle(size).copyWith(color: Colors.grey.shade600),)),
                              ),
                            ):Container(),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      ' - ',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: size* .04,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _mamlaNo2,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.crMamlaNo} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Variables.textColor,
                            fontSize: size* .04),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '৪(৮)২১',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size * .05),

                ///Dhara
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${Variables.dhara} ',
                        style: TextStyle(
                            fontSize: size* .04,
                            color: Variables.textColor)),
                    Expanded(
                      child: TextFormField(
                        controller: _dhara,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.dhara} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.text,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '৩৬(১) এর ১০(গ),৪১',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///poroborti tarikh
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${Variables.porobortiTang} ',
                        style: TextStyle(
                            fontSize: size*.04,
                            color: Variables.textColor)),
                    Expanded(
                      child: TextFormField(
                        controller: _nextDate,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.porobortiTarikh} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.number,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '০৪/০৮/২০২১',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///Bicarik adalot
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${Variables.bicaricAdalot} ',
                        style: TextStyle(
                            fontSize: size* .04,
                            color: Variables.textColor)),
                    Expanded(
                      child: TextFormField(
                        controller: _bicarikAdalot,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.bicaricAdalot} প্রদান করুন'
                            : null,
                        //keyboardType: TextInputType.number,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '৫ম যুগ্ম মহানগর দায়রা জজ আদালত',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                _isLoading
                    ? Center(child: spinCircle())
                    : GradientButton(
                  onPressed: () {
                    _saveData(databaseProvider);
                  },
                  child: Text(Variables.save,
                      style: TextStyle(
                          fontSize: size * .04)),
                  height: size * .11,
                  width: size* .7,
                  borderRadius: 5,
                  gradientColors: [
                    Colors.green.shade800,
                    Colors.green.shade700,
                  ],
                ),
                SizedBox(height: size* .05),
              ],
            ),
          ),
        ),
      );

  Future<void> _saveData(DatabaseProvider databaseProvider) async {
    if (_formKey.currentState!.validate()) {
      if (_amoliAdalot != null && _jojCourt != null && _mamlaNo != null) {
        setState(() => _isLoading = true);
        var uuid = const Uuid();
        String id = uuid.v1();
        String date = DateFormat("dd-MM-yyyy").format(
            DateTime.fromMillisecondsSinceEpoch(
                DateTime.now().millisecondsSinceEpoch));
        Map<String, String> map = {
          'id': id,
          'dayra_no': '${_dayraNo.text}/${_dayraNo2.text}',
          'mamla_no': '$_mamlaNo-${_mamlaNo2.text}',
          'pokkho_dhara': _dhara.text,
          'poroborti_tarikh': _nextDate.text,
          'bicarik_adalot': _bicarikAdalot.text,
          'amoli_adalot': _amoliAdalot!,
          'joj_court': _jojCourt!,
          'mamlar_dhoron': Variables.bisesTribunal,
          'boi_no': '${_boiNo.text}/${_boiNo2.text}',
          'entry_date': date
        };
        await databaseProvider.saveData(map).then((value) {
          if (value) {
            _dayraNo.clear();
            //_dayraNo2.clear();
            _mamlaNo2.clear();
            _dhara.clear();
            _nextDate.clear();
            //_bicarikAdalot.clear();
            _thanaNameController.clear();
            _dayraFocus.requestFocus();
            showToast('Data Saved');
            setState(() => _isLoading = false);
          } else {
            showToast('Data Insert Failed! Try Again');
            setState(() => _isLoading = false);
          }
        });
      } else
        showToast('সকল ফর্ম পূরন করুন');
    }

  }

  void _filterPdfData(DatabaseProvider databaseProvider, PublicProvider publicProvider,double size){
    TextEditingController _pdfDayra1=TextEditingController(text: '');
    TextEditingController _pdfDayra2=TextEditingController(text: '');
    TextEditingController _pdfBoiNo=TextEditingController(text: '');
    String? _pdfAmoliAdalot;
    String? _pdfJojCourt;
    final _formKey = GlobalKey<FormState>();
    List<BodliKhanaModel> pdfDataList=[];

    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (_){
        return AlertDialog(
            scrollable: true,
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState){
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: size*.04),

                      ///joj Court
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Variables.jojCourt}- ',
                            style: formTextStyle(size)),
                          Expanded(
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade800, width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isDense: true,
                                  isExpanded: true,
                                  value: _pdfJojCourt,
                                  hint: Text(Variables.dropHint,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: size* .04,
                                      )),
                                  items: Variables.jojCourtList.map((category) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        category,
                                        style: formTextStyle(size),
                                      ),
                                      value: category,
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() => _pdfJojCourt = newValue!);
                                    print(_pdfJojCourt);},
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size*.04),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Amoli Adalot
                          Text(
                              '${Variables.amoliAdalot}- ',
                              style: formTextStyle(size)),
                          Expanded(
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.grey.shade800, width: 1),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isDense: true,
                                  isExpanded: true,
                                  value: _pdfAmoliAdalot,
                                  hint: Text(Variables.dropHint,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: size* .04,
                                      )),
                                  items: Variables.amoliAdalotList.map((category) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        category,
                                        style: formTextStyle(size),
                                      ),
                                      value: category,
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() => _pdfAmoliAdalot = newValue!);
                                    print(_pdfAmoliAdalot);},
                                  dropdownColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size*.04),

                      ///Boi no
                      Row(
                        children: [
                          Text('বই নং- ',style: formTextStyle(size)),
                          Expanded(
                            child: TextFormField(
                              controller: _pdfBoiNo,
                              validator: (val)=>val!.isEmpty?'Enter Data':null,
                              decoration: boxFormDecoration(size).copyWith(
                                hintText: '১/২০২১',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size* .01,
                                    horizontal: size* .018),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size*.04),

                      ///Dayra NO
                      Row(
                        children: [
                          Text('${Variables.bishesDayraNo} ',style: formTextStyle(size)),
                          Expanded(
                            child: TextFormField(
                              controller: _pdfDayra1,
                              validator: (val)=>val!.isEmpty?'Enter Data':null,
                              decoration: boxFormDecoration(size).copyWith(
                                hintText: '৫০১/২০২১',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size * .01,
                                    horizontal: size* .018),
                              ),
                            ),
                          ),
                          const Text(' - '),
                          Expanded(
                            child: TextFormField(
                              controller: _pdfDayra2,
                              validator: (val)=>val!.isEmpty?'Enter Data':null,
                              decoration: boxFormDecoration(size).copyWith(
                                hintText: '৬০১/২০২১',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size* .01,
                                    horizontal: size* .018),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size*.04),

                      ///Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  for(int i=0; i< _filteredSubList.length; i++){
                                    if(
                                    int.parse(databaseProvider.bnToEnNumberConvert(_filteredSubList[i].dayraNo!))>=
                                        int.parse(databaseProvider.bnToEnNumberConvert(_pdfDayra1.text))
                                        && int.parse(databaseProvider.bnToEnNumberConvert(_filteredSubList[i].dayraNo!))<=
                                        int.parse(databaseProvider.bnToEnNumberConvert(_pdfDayra2.text))
                                        && _filteredSubList[i].jojCourt! == _pdfJojCourt
                                        && _filteredSubList[i].amoliAdalot! == _pdfAmoliAdalot
                                        && _filteredSubList[i].boiNo! == _pdfBoiNo.text
                                    ){
                                      pdfDataList.add(_filteredSubList[i]);
                                    }
                                  }
                                  if(pdfDataList.isNotEmpty) {
                                    SavePDF.savePdf(pdfDataList, Variables.bisesTribunal,context);
                                  } else {
                                    showToast('কোন ডেটা খুজে পাওয়া যায়নি');
                                  }

                                }
                              },
                              child: const Text('ডাউনলোড')
                          ),

                          ElevatedButton(
                            onPressed: ()=>Navigator.pop(context),
                            child: const Text('বাতিল'),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            )
        );
      },
      animationType: DialogTransitionType.slideFromTopFade,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );

  }
}