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
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class NIActPage extends StatefulWidget {
  const NIActPage({Key? key}) : super(key: key);

  @override
  _NIActPageState createState() => _NIActPageState();
}

class _NIActPageState extends State<NIActPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _amoliAdalot;
  String? _jojCourt;
  int _counter = 0;
  final FocusNode _dayraFocus=FocusNode();

  final TextEditingController _dayraNo = TextEditingController(text: '');
  final TextEditingController _dayraNo2 = TextEditingController(text: '');
  final TextEditingController _crMamlaNo = TextEditingController(text: '');
  final TextEditingController _crMamlaNo2 = TextEditingController(text: '');
  final  TextEditingController _badi = TextEditingController(text: '');
  final TextEditingController _bibadi = TextEditingController(text: '');
  final  TextEditingController _nextDate = TextEditingController(text: '');
  final  TextEditingController _bicarikAdalot = TextEditingController(text: '');
  final  TextEditingController _boiNo = TextEditingController(text: '');
  final TextEditingController _boiNo2 = TextEditingController(text: '');

  final TextEditingController _searchBoiNo = TextEditingController(text: '');
  final TextEditingController _searchMamlaNo = TextEditingController(text: '');
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
    _counter++;
    if (databaseProvider.niActDataList.isEmpty) {
      setState(() => _isLoading = true);
      await databaseProvider.getNIActDataList().then((value) {
        setState(() {
          _isLoading = false;
        });
        setState(() {
          _subList = databaseProvider.niActDataList;
          _filteredSubList = _subList;
        });
      });
    } else {
      setState(() {
        _subList = databaseProvider.niActDataList;
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
            element.amoliAdalot!
                .toLowerCase()
                .contains(_searchAmoliAdalot!.toLowerCase()) &&
            element.boiNo!
                .toLowerCase()
                .contains(_searchBoiNo.text.toLowerCase())

        )).toList();
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
    await databaseProvider.getNIActDataList().then((value) {
      setState(() {
        _subList = databaseProvider.niActDataList;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Variables.nIAct),
        elevation: 00,
      ),
      body: Column(
        children: [
          TabBar(controller: _tabController, tabs: [
            Tab(
                child: Text('এন.আই.এ্যাক্ট ড্যাটালিষ্ট',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
            Tab(
                child: Text('ডাটা এন্ট্রি ড্যাশবোর্ড',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'hindSiliguri',
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

  Widget _allDataWidget(double size, PublicProvider publicProvider,DatabaseProvider databaseProvider) =>
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

                      ///Cr Mamla No
                      Text(
                        ' ${Variables.crMamlaNo}- ',
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
                        '${Variables.dayraNo}- ',
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
                      ///Search Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size* .008),
                        child: OutlinedButton(
                          onPressed: () => _filterList(),
                          child: const Icon(Icons.search, color: Colors.grey),
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

                      ///Reload Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size* .008),
                        child: OutlinedButton(
                          onPressed: () => _refreshData(databaseProvider),
                          child: const Icon(Icons.refresh),
                        ),
                      ),

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
                    ],
                  ),
                )
              ],
            ),
          ),

          ///Table Body
          _isLoading
              ? Center(child: spinCircle())
              : _filteredSubList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: _filteredSubList.length,
                        itemBuilder: (context, index) => Container(color: Colors.green,),
                      ),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('কোন ডেটা নেই!',
                            style: TextStyle(
                                fontSize: size* .04,
                                color: const Color(0xffF5B454))),
                        TextButton(
                            onPressed: () async {
                              setState(() => _isLoading = true);
                              await databaseProvider
                                  .getNIActDataList()
                                  .then((value) {
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


  Widget _dataEntryWidget(double size, PublicProvider publicProvider,DatabaseProvider databaseProvider) =>
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
                  '${Variables.mamlarDhoron} - ${Variables.nIAct}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: size* .05,
                      color: Variables.textColor,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: size* .05),

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
                      '${Variables.dayraNo} ',
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

                ///CR Mamla No
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Variables.crMamlaNo} ',
                      style: formTextStyle(size),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _crMamlaNo,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.crMamlaNo} প্রদান করুন'
                            : null,
                        //keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Variables.textColor,
                            fontSize: size* .04),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '২৯২৫',
                        ),
                      ),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: size* .06),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _crMamlaNo2,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.crMamlaNo} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Variables.textColor,
                            fontSize: size * .04),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '২০১৯',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size* .05),

                ///Pokkhogoner Nam
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${Variables.pokkhogonerNam} ',
                        style: TextStyle(
                            fontSize: size* .04,
                            color: Variables.textColor)),
                    Expanded(
                      child: TextFormField(
                        controller: _badi,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.pokkhogonerNam} প্রদান করুন'
                            : null,
                        //keyboardType: TextInputType.text,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: 'মোঃ রহিম',
                        ),
                      ),
                    ),
                    Text(
                      ' ${Variables.banam} ',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: size* .04),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _bibadi,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.pokkhogonerNam} প্রদান করুন'
                            : null,
                        keyboardType: TextInputType.text,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: 'করিম শাহ',
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
                            fontSize: size* .04,
                            color: Variables.textColor)),
                    Expanded(
                      child: TextFormField(
                        controller: _nextDate,
                        validator: (val) => val!.isEmpty
                            ? '${Variables.porobortiTarikh} প্রদান করুন'
                            : null,
                        //keyboardType: TextInputType.number,
                        style: formTextStyle(size),
                        decoration: boxFormDecoration(size).copyWith(
                          hintText: '০৪/০৮/২০২১',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size*.05),

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
                                fontSize: size* .04,fontWeight: FontWeight.bold)),
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
      if (_amoliAdalot != null) {
        setState(() => _isLoading = true);
        var uuid = const Uuid();
        String id = uuid.v1();
        String date = DateFormat("dd-MM-yyyy").format(
            DateTime.fromMillisecondsSinceEpoch(
                DateTime.now().millisecondsSinceEpoch));
        Map<String, String> map = {
          'id': id,
          'dayra_no': '${_dayraNo.text}/${_dayraNo2.text}',
          'mamla_no': '${_crMamlaNo.text}/${_crMamlaNo2.text}',
          'pokkho_dhara': '${_badi.text} বনাম ${_bibadi.text}',
          'poroborti_tarikh': _nextDate.text,
          'bicarik_adalot': _bicarikAdalot.text,
          'amoli_adalot': _amoliAdalot!,
          'joj_court': _jojCourt!,
          'mamlar_dhoron': Variables.nIAct,
          'boi_no': '${_boiNo.text}/${_boiNo2.text}',
          'entry_date': date
        };
        await databaseProvider.saveData(map).then((value) {
          if (value) {
            _dayraNo.clear();
            //_dayraNo2.clear();
            _crMamlaNo.clear();
            _crMamlaNo2.clear();
            _badi.clear();
            _bibadi.clear();
            _nextDate.clear();
            //_bicarikAdalot.clear();
            _dayraFocus.requestFocus();
            showToast('Data Saved');
            setState(() => _isLoading = false);
          } else {
            showToast('Data Insert Failed! Try Again');
            setState(() => _isLoading = false);
          }
        });
      } else {
        showToast('${Variables.amoliAdalot} প্রদান করুন');
      }
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

                      ///joj amoli
                      Row(
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

                          ///Amoli Adalot Dropdown
                          Text(
                            '  ${Variables.amoliAdalot}- ',
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
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
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
                          Text('দায়রা নং- ',style: formTextStyle(size)),
                          Expanded(
                            child: TextFormField(
                              controller: _pdfDayra1,
                              validator: (val)=>val!.isEmpty?'Enter Data':null,
                              decoration: boxFormDecoration(size).copyWith(
                                hintText: '৫০১/২০২১',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size* .01,
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
                                    SavePDF.savePdf(pdfDataList,Variables.nIAct,context);
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
