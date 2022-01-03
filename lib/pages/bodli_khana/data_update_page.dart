import 'package:admin_app/model_class/bodli_khana_model.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/gradient_button.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DataUpdatePage extends StatefulWidget {
  const DataUpdatePage({Key? key,required this.bodliKhanaModel,required this.fromPage,required this.index}) : super(key: key);
  final BodliKhanaModel bodliKhanaModel;
  final String fromPage;
  final int index;

  @override
  _DataUpdatePageState createState() => _DataUpdatePageState();
}

class _DataUpdatePageState extends State<DataUpdatePage> {
  final _formKey= GlobalKey<FormState>();
  bool _isLoading=false;
  int _counter=0;
  String? _amoliAdalot;
  String? _jojCourt;
  TextEditingController _dayraNo =TextEditingController(text: '');
  TextEditingController _mamlaNo =TextEditingController(text: '');
  TextEditingController _pokkho_dhara =TextEditingController(text: '');
  TextEditingController _nextDate =TextEditingController(text: '');
  TextEditingController _bicarikAdalot =TextEditingController(text: '');
  TextEditingController _boiNo =TextEditingController(text: '');

  void _customInit(PublicProvider publicProvider){
    setState(()=> _counter++);
    _dayraNo = TextEditingController(text: widget.bodliKhanaModel.dayraNo);
    _mamlaNo = TextEditingController(text: widget.bodliKhanaModel.mamlaNo);
    _pokkho_dhara = TextEditingController(text: widget.bodliKhanaModel.pokkhoDhara);
    _nextDate = TextEditingController(text: widget.bodliKhanaModel.porobortiTarikh);
    _bicarikAdalot = TextEditingController(text: widget.bodliKhanaModel.bicarikAdalot);
    _boiNo = TextEditingController(text: widget.bodliKhanaModel.boiNo);
    _amoliAdalot = widget.bodliKhanaModel.amoliAdalot;
    _jojCourt = widget.bodliKhanaModel.jojCourt;
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size=publicProvider.size;
    if(_counter==0) _customInit(publicProvider);
    return _dataUpdateUI(size, publicProvider, databaseProvider);
  }


  Widget _dataUpdateUI(double size, PublicProvider publicProvider,DatabaseProvider databaseProvider)=>Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('আপডেট ডাটা'),
      elevation: 00
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size*.04),
              Text('${Variables.mamlarDhoron} - ${widget.fromPage}',textAlign: TextAlign.center,style: TextStyle(
                  fontSize: size* .05,
                  color: Variables.textColor,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline)),
              SizedBox(height: size*.05),

              ///boi No
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${Variables.boiNo} ',style: TextStyle(
                      fontSize: size* .04,
                      color: Variables.textColor)),
                  Expanded(
                    child: TextFormField(
                      controller: _boiNo,
                      keyboardType: TextInputType.text,
                      validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
                      style: formTextStyle(size),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: '০৪/২০২১',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  size*.05),

              ///Amoli Adalot Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${Variables.amoliAdalot} ',
                    style: formTextStyle(size),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade800,width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isDense: true,
                          isExpanded: true,
                          value:_amoliAdalot,
                          hint: Text(Variables.dropHint,style: TextStyle(
                            color: Colors.grey,
                            fontSize: size*.04)),
                          items:Variables.amoliAdalotList.map((category){
                            return DropdownMenuItem(
                              child: Text(category, style: formTextStyle(size),
                              ),
                              value: category,
                            );
                          }).toList(),
                          onChanged: (String? newValue)=> setState(()=>
                          _amoliAdalot = newValue),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height:  size*.05),

              ///JojCourt Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${Variables.jojCourt} ',
                    style: formTextStyle(size),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade800,width: 1),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isDense: true,
                          isExpanded: true,
                          value:_jojCourt,
                          hint: Text('${Variables.jojCourt} নির্বাচন করুন',style: TextStyle(
                            color: Colors.grey,
                            fontSize: size*.04)),
                          items:Variables.jojCourtList.map((category){
                            return DropdownMenuItem(
                              child: Text(category, style: formTextStyle(size),
                              ),
                              value: category,
                            );
                          }).toList(),
                          onChanged: (String? newValue)=> setState(()=>
                          _jojCourt = newValue),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size*.05),

              ///Dayra No
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.fromPage==Variables.bisesTribunal
                      ?'${Variables.bishesDayraNo} '
                      :'${Variables.dayraNo} ',
                      style: TextStyle(
                      fontSize: size* .04,
                      color: Variables.textColor)),
                  Expanded(
                    child: TextFormField(
                      controller: _dayraNo,
                      keyboardType: TextInputType.text,
                      validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
                      style: formTextStyle(size),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: '১৮৩৯৩/২০২০',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  size*.05),

              ///Mamla No
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.fromPage==Variables.nIAct
                      ?'${Variables.crMamlaNo} '
                      :'${Variables.mamlaNo} ',
                      style: TextStyle(
                      fontSize: size* .04,
                      color: Variables.textColor)),
                  Expanded(
                    child: TextFormField(
                      controller: _mamlaNo,
                      keyboardType: TextInputType.text,
                      validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
                      style: formTextStyle(size),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: widget.fromPage==Variables.nIAct
                            ?'২৯২৫/২০১৯'
                            :'মতিঝিল-৪(৮)২০২০',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  size*.05),

              ///Pokkhogoner_Nam / Dhara
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.fromPage==Variables.nIAct
                      ?'${Variables.pokkhogonerNam} '
                      :'${Variables.dhara} ',
                      style: TextStyle(
                      fontSize: size* .04,
                      color: Variables.textColor)),
                  Expanded(
                    child: TextFormField(
                      controller: _pokkho_dhara,
                      keyboardType: TextInputType.text,
                      validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
                      style: formTextStyle(size),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: widget.fromPage==Variables.nIAct
                            ?'মোঃ শাহ আলম বানাম আব্দুল আহাদ'
                            :'৩৬(১) এর ১০(গ),৪১',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  size*.05),

              ///poroborti tarikh
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${Variables.porobortiTang} ',style: TextStyle(
                      fontSize: size* .04,
                      color: Variables.textColor)),
                  Expanded(
                    child: TextFormField(
                      controller: _nextDate,
                      keyboardType: TextInputType.text,
                      validator: (val)=>val!.isEmpty?'${Variables.porobortiTarikh} প্রদান করুন':null,
                      style: formTextStyle(size),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: '০৪/০৮/২০২১',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  size*.05),

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
                      keyboardType: TextInputType.text,
                      validator: (val)=>val!.isEmpty?'${Variables.bicaricAdalot} প্রদান করুন':null,
                      style: formTextStyle(size),
                      decoration: boxFormDecoration(size).copyWith(
                        hintText: '৫ম যুগ্ম মহানগর দায়রা জজ আদালত',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:  size*.05),

              _isLoading
                  ? Center(child: spinCircle())
                  : GradientButton(
                onPressed: ()=> _updateData(publicProvider, databaseProvider),
                child: Text('আপডেট করুন', style: TextStyle(
                    fontSize: size* .04)),
                borderRadius: 3.0,
                height: size*.11,
                width: size*.6,
                gradientColors: [
                  Colors.green.shade800,
                  Colors.green.shade700,
                ],
              ),
              SizedBox(height:  size*.05),
            ],
          ),
        ),
      ),
    ),
  );

  Future<void> _updateData(PublicProvider publicProvider, DatabaseProvider databaseProvider)async{
    if(_formKey.currentState!.validate()){
      if(_amoliAdalot!=null){
        setState(()=>_isLoading=true);
        Map<String,String> map = {
          'dayra_no': _dayraNo.text,
          'mamla_no': _mamlaNo.text,
          'pokkho_dhara': _pokkho_dhara.text,
          'poroborti_tarikh': _nextDate.text,
          'bicarik_adalot': _bicarikAdalot.text,
          'amoli_adalot': _amoliAdalot!,
          'boi_no': _boiNo.text,
          'joj_court': _jojCourt!
        };
        BodliKhanaModel bodliKhanaModel = BodliKhanaModel();

        bodliKhanaModel.id=widget.bodliKhanaModel.id!;
        bodliKhanaModel.amoliAdalot=_amoliAdalot!;
        bodliKhanaModel.bicarikAdalot=_bicarikAdalot.text;
        bodliKhanaModel.boiNo=_boiNo.text;
        bodliKhanaModel.dayraNo=_dayraNo.text;
        bodliKhanaModel.mamlaNo=_mamlaNo.text;
        bodliKhanaModel.pokkhoDhara=_pokkho_dhara.text;
        bodliKhanaModel.porobortiTarikh=_nextDate.text;
        bodliKhanaModel.jojCourt=_jojCourt!;
        bodliKhanaModel.mamlarDhoron=widget.bodliKhanaModel.mamlarDhoron;

        await databaseProvider.updateData(widget.bodliKhanaModel.id!, map,widget.fromPage,bodliKhanaModel,widget.index).then((value)async{
          if(value){
            showToast('Data Updated');
            setState(()=>_isLoading=false);
            Navigator.pop(context);
          }else{
            showToast('Data Update Failed! Try Again');
            setState(()=>_isLoading=false);
          }
        });
      }else {
        showToast('${Variables.amoliAdalot} আপডেট করুন');
      }
    }
  }

}
