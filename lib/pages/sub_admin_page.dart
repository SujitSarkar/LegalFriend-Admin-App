import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/form_decoration.dart';
import 'package:admin_app/widgets/gradient_button.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SubAdminPage extends StatefulWidget {
  const SubAdminPage({Key? key}) : super(key: key);
  @override
  _SubAdminPageState createState() => _SubAdminPageState();
}

class _SubAdminPageState extends State<SubAdminPage> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  int _counter=0;
  bool _isUpdate=false;
  bool _isDelete=false;
  bool _isLoading=false;
  final TextEditingController _name= TextEditingController(text: '');
  final TextEditingController _password= TextEditingController(text: '');
  final TextEditingController _confirmPassword= TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _customInit(DatabaseProvider databaseProvider) async {
    setState(() => _counter++);

    if(databaseProvider.subAdminList.isEmpty){
      setState(() => _isLoading=true);
      await databaseProvider.getSubAdminList().then((value){
        setState(() => _isLoading=false);
      });
    }
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
        title: const Text(Variables.subAdmin),
        elevation: 00,
      ),
      body: Column(
        children: [
          TabBar(controller: _tabController, tabs: [
            Tab(child: Text('সাব-এডমিন লিস্ট',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
            Tab(child: Text('সাব-এডমিন নিবন্ধন',
                    style: TextStyle(
                        fontSize: size * .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
          ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              _showSubAdmin(databaseProvider,size),
              _addNewSubAdmin(databaseProvider, size)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _showSubAdmin(DatabaseProvider databaseProvider,double size)=>Column(
    children: [
      SizedBox(height: size*.04),
      ///Table Body
      _isLoading
          ? Center(child: spinCircle())
          : databaseProvider.subAdminList.isNotEmpty
          ? Expanded(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: databaseProvider.subAdminList.length,
          itemBuilder: (context, index) => Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(size*.02,size*.02,size*.02,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: formTextStyle(size),
                      children: <TextSpan>[
                        const TextSpan(text: 'ইউজারনেম: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${databaseProvider.subAdminList[index].name}\n'),
                        const TextSpan(text: 'পাসওয়ার্ড: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${databaseProvider.subAdminList[index].password}\n'),
                        const TextSpan(text: 'আপডেট: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${databaseProvider.subAdminList[index].canUpdate}\n'),
                        const TextSpan(text: 'ডিলিট: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${databaseProvider.subAdminList[index].canDelete}'),

                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        child: Text('ডিলিট',
                            style: TextStyle(color: Colors.redAccent,fontSize: size*.04)
                        ),
                        onPressed: (){
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return ClassicGeneralDialogWidget(
                                titleText: 'Delete Sub-Admin?',
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
                                  await databaseProvider.deleteSubAdmin(databaseProvider.subAdminList[index].id!).then((value)async{
                                    if(value){
                                      await databaseProvider.getSubAdminList();
                                      closeLoadingDialog(context);
                                      closeLoadingDialog(context);
                                      showToast('Sub-Admin Deleted Success');
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
                  )

                ],
              ),
            ),
          ),
        ),
      ) : Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text('কোন সাব-এডমিন নেই!',
                  style: TextStyle(
                      fontSize: size* .04,
                      color: const Color(0xffF5B454))),
              TextButton(
                  onPressed: () async {
                    setState(() => _isLoading = true);
                    await databaseProvider
                        .getSubAdminList()
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

  Widget _addNewSubAdmin(DatabaseProvider databaseProvider, double size)=>SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size*.04),
          ///Title
          Text("নতুন সাব-এডমিন নিবন্ধন করুন",
              style: TextStyle(fontSize: size*.04,
                  color: Variables.textColor,
              fontWeight: FontWeight.bold)),
          const Divider(color: Colors.grey),
          SizedBox(height: size*.05),

          ///CheckBox
          _checkBoxBuilder(size, 'ডেটা আপডেট করতে পারবে'),
          _checkBoxBuilder(size, 'ডেটা ডিলিট করতে পারবে'),
          SizedBox(height: size*.05),

          ///Text Field
          _textFieldBuilder(size, 'ইউজারনেম'),
          SizedBox(height: size*.05),
          _textFieldBuilder(size, 'পাসওয়ার্ড'),
          SizedBox(height: size*.05),
          _textFieldBuilder(size, 'কনফার্ম পাসওয়ার্ড'),
          SizedBox(height: size*.06),

          _isLoading? spinCircle(): GradientButton(
              child: Text('নিবন্ধন করুন',
                  style: TextStyle(fontSize: size*.05,color: Colors.white)),
              onPressed: ()async=> _submitNewSubAdmin(databaseProvider),
              height: size * .11,
              width: size* .7,
              borderRadius: 5,
              gradientColors: [
                Theme.of(context).primaryColor,
                Colors.teal.shade300
              ])
        ],
      ),
    ),
  );

  Widget _checkBoxBuilder(double size, String title)=>Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Checkbox(
          value: title=='ডেটা আপডেট করতে পারবে'
              ?_isUpdate
              :_isDelete,
          onChanged: (val){
            setState(() {
              if(title=='ডেটা আপডেট করতে পারবে') {
                _isUpdate=val!;
              } else {
                _isDelete=val!;
              }
            });
          },
      ),
      Text(title,
          style: TextStyle(fontSize: size*.04,
              color: Variables.textColor))
    ],
  );

  Widget _textFieldBuilder(double size, String hint)=>TextFormField(
    controller: hint=='ইউজারনেম'
        ?_name
        :hint=='পাসওয়ার্ড'
        ?_password
        :_confirmPassword,
    style: TextStyle(fontSize: size*.04),
    decoration: boxFormDecoration(size).copyWith(
      labelText: hint,
    ),
  );
  
  void _submitNewSubAdmin(DatabaseProvider databaseProvider)async{
    if(_name.text.isNotEmpty && _password.text.isNotEmpty && _confirmPassword.text.isNotEmpty){
      if(_password.text == _confirmPassword.text){
        setState(()=>_isLoading=true);
        var uuid = const Uuid();
        String id = uuid.v1();
        Map<String,dynamic> map = {
          'id': id,
          'name': _name.text,
          'password': _password.text,
          'can_delete': _isDelete,
          'can_update': _isUpdate
        };
        databaseProvider.addNewSubAdmin(map).then((value)async{
          if(value){
            await databaseProvider.getSubAdminList();
            showToast('নিবন্ধন সম্পন্ন হয়েছে');
            setState(()=>_isLoading=false);
            _name.clear();
            _password.clear();
            _confirmPassword.clear();
          }else{
            showToast('নিবন্ধন অসম্পন্ন হয়েছে');
            setState(()=>_isLoading=false);
          }
        });
      }else {
        showToast('পাসওয়ার্ড দুটি মিলতে হবে');
      }
    }else {
      showToast('ফর্ম পুরন করুন');
    }
  }
}
