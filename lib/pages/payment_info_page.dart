import 'package:admin_app/model_class/payment_info_model.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentInfoPage extends StatefulWidget {
  const PaymentInfoPage({Key? key}) : super(key: key);
  @override
  _PaymentInfoPageState createState() => _PaymentInfoPageState();
}

class _PaymentInfoPageState extends State<PaymentInfoPage> {
  int _counter=0;
  bool _isLoading=false;
  List<PaymentInfoModel> _subList=[];
  List<PaymentInfoModel> _filteredList=[];
  final TextEditingController _searchController=TextEditingController();

  Future<void>_customInit(DatabaseProvider databaseProvider)async{
    setState(()=>_counter++);
    if(databaseProvider.paymentInfoList.isEmpty){
      setState(()=>_isLoading=true);
      await databaseProvider.getPaymentInfoList().then((value){
        setState((){
          _subList = databaseProvider.paymentInfoList;
          _filteredList= _subList;
          _isLoading=false;
        });
      });
    }else{
      setState((){
        _subList = databaseProvider.paymentInfoList;
        _filteredList= _subList;
      });
    }
  }

  Future<void> _refreshData(DatabaseProvider databaseProvider) async {
    setState(() => _isLoading = true);
    await databaseProvider.getPaymentInfoList().then((value) {
      setState(() {
        _subList = databaseProvider.paymentInfoList;
        _filteredList = _subList;
        _isLoading = false;
      });
    });
  }

  ///SearchList builder
  void _filterList(String userPhone) {
    setState(() {
      _filteredList = _subList
          .where((element) => (element.userPhone!
          .toLowerCase()
          .contains(userPhone.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size = publicProvider.size;
    if(_counter==0) _customInit(databaseProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Variables.paymentInfo),
        elevation: 00,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('মোট:- ${_filteredList.length}'),
          )
        ],
      ),
      body: Column(
        children: [
          ///Search Header
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: _filterList,
                    decoration: boxFormDecoration(size).copyWith(
                      hintText: 'মোবাইল নাম্বার দিয়ে সার্চ করুন...',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size* .01,
                          horizontal: size* .018),
                    ),
                  ),
                ),
              ),
              ///Reload Button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size* .008),
                child: OutlinedButton(
                  onPressed: () => _refreshData(databaseProvider),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size* .008),
                      child: const Icon(Icons.refresh)),
                ),
              ),
            ],
          ),

          ///Table Body
          _isLoading
              ? Center(child: spinCircle())
              : _filteredList.isNotEmpty
              ? Expanded(
            child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: _filteredList.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: EdgeInsets.all(size*.02),
                  child: RichText(
                    text: TextSpan(
                      style: formTextStyle(size),
                      children: <TextSpan>[
                        const TextSpan(text: 'মোবাইল: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].userPhone}\n'),
                        const TextSpan(text: 'ট্রাঃ আইডি: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].merchantRefId}\n'),
                        const TextSpan(text: 'পরিমান: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].merchantReqAmount} ${_filteredList [index].merchantCurrency}\n'),
                        const TextSpan(text: 'পেমেন্টের সময়: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].txnTime}'),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
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
                        await databaseProvider
                            .getPaymentInfoList()
                            .then((value) {
                          setState(() => _isLoading = false);
                        });
                      },
                      child: Text(
                        'রিফ্রেশ করুন',
                        style: TextStyle(
                          fontSize: size * .04,
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
