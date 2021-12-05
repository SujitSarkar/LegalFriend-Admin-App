import 'package:admin_app/model_class/register_user_model.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterGrahokTalika extends StatefulWidget {
  const RegisterGrahokTalika({Key? key}) : super(key: key);
  @override
  _RegisterGrahokTalikaState createState() => _RegisterGrahokTalikaState();
}

class _RegisterGrahokTalikaState extends State<RegisterGrahokTalika> {
  int _counter=0;
  bool _isLoading=false;
  List<RegisterUserModel> _subList=[];
  List<RegisterUserModel> _filteredList=[];
  final TextEditingController _searchController=TextEditingController();

  Future<void>_customInit(DatabaseProvider databaseProvider)async{
    setState(()=>_counter++);
    if(databaseProvider.registerUserList.isEmpty){
      setState(()=>_isLoading=true);
      await databaseProvider.getRegisterUserList().then((value){
        setState((){
          _subList = databaseProvider.registerUserList;
          _filteredList= _subList;
          _isLoading=false;
        });
      });
    }else{
      setState((){
        _subList = databaseProvider.registerUserList;
        _filteredList= _subList;
      });
    }
  }

  Future<void> _refreshData(DatabaseProvider databaseProvider) async {
    setState(() => _isLoading = true);
    await databaseProvider.getRegisterUserList().then((value) {
      setState(() {
        _subList = databaseProvider.registerUserList;
        _filteredList = _subList;
        _isLoading = false;
      });
    });
  }

  ///SearchList builder
  void _filterList(String name) {
    setState(() {
      _filteredList = _subList
          .where((element) => (element.userPhone!
          .toLowerCase()
          .contains(name.toLowerCase())))
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
        title: const Text(Variables.registerGrahok),
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
                      padding: EdgeInsets.symmetric(vertical: size* .008),
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
                        const TextSpan(text: 'নাম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].userName}\n'),
                        const TextSpan(text: 'মোবাইল নাম্বার: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].userPhone}\n'),
                        const TextSpan(text: 'ঠিকানা: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${_filteredList[index].userAddress}'),

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
                            .getRegisterUserList()
                            .then((value) {
                          setState(() => _isLoading = false);
                        });
                      },
                      child: Text(
                        'রিফ্রেশ করুন',
                        style: TextStyle(
                          fontSize: size* .04,
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
