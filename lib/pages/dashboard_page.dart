import 'package:admin_app/pages/bodli_khana/bisesh_tribunal_page.dart';
import 'package:admin_app/pages/bodli_khana/madok_dondobidhi_page.dart';
import 'package:admin_app/pages/bodli_khana/ni_act_page.dart';
import 'package:admin_app/pages/register_grahok_talika.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _counter=0;
  bool _isLoading=true;

  Future<void> _customInit(DatabaseProvider databaseProvider,BuildContext context)async{
    _counter++;
    if(databaseProvider.registerUserList.isEmpty) await databaseProvider.getRegisterUserList();
    if(databaseProvider.niActDataList.isEmpty) await databaseProvider.getNIActDataList();
    if(databaseProvider.madokDataList.isEmpty) await databaseProvider.getMadokDataList();
    if(databaseProvider.tribunalDataList.isEmpty) await databaseProvider.getBiseshTribunalDataList();
    setState(()=> _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size = publicProvider.size;

    if(_counter==0) _customInit(databaseProvider,context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Variables.dashboard),
        elevation: 0.0,
      ),
      body: _isLoading
          ? Center(child: spinCircle())
          : Container(
        color: Colors.grey.shade50,
        alignment: Alignment.center,
        child:ListView(
            scrollDirection: Axis.vertical,

            children: [
              _gridViewTile(publicProvider,size,'রেজিস্টার\nগ্রাহক',Colors.purple,
                  'মোট সংখ্যা','নতুন','${databaseProvider.registerUserList.length}','${databaseProvider.newRegisterUser}'),
              _gridViewTile(publicProvider,size,'এন.আই.\nএ্যাক্ট',Colors.red,
                  'মোট সংখ্যা','নতুন','${databaseProvider.niActDataList.length}','${databaseProvider.newNIActData}'),
              _gridViewTile(publicProvider,size,'মাদক/\nদন্ডবিধি',Colors.green,
                  'মোট সংখ্যা','নতুন','${databaseProvider.madokDataList.length}','${databaseProvider.newMadokData}'),
              _gridViewTile(publicProvider,size,'বিশেষ\nট্রাইব্যুনাল',Colors.yellow.shade800,
                  'মোট সংখ্যা','নতুন','${databaseProvider.tribunalDataList.length}','${databaseProvider.newTribunalData}'),
            ]
        ),
      ),
    );
  }

  Widget _gridViewTile(PublicProvider publicProvider,double size,String title, Color bgColor,
      String heading1, String heading2, String h1Data, String h2Data){
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: size*.05,left: size*.05,right: size*.05),
          padding: EdgeInsets.symmetric(horizontal: size*.02,vertical: size*.02),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(heading1,style: TextStyle(color: Colors.grey,fontSize: size*.04,fontWeight: FontWeight.w400),),
                  Text(h1Data,style: TextStyle(color: Variables.textColor,fontSize: size*.05,fontWeight: FontWeight.w400)),
                  SizedBox(height: size*.04),
                  Text(heading2,style: TextStyle(color: Colors.grey,fontSize: size*.04,fontWeight: FontWeight.w400),),
                  Text(h2Data,style: TextStyle(color: Variables.textColor,fontSize: size*.05,fontWeight: FontWeight.w400)),
                  const Divider(height: 3,color: Colors.grey),
                ],
              ),
              TextButton(
                  onPressed: (){
                    if(title=='রেজিস্টার\nগ্রাহক'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterGrahokTalika()));
                    }
                    else if(title=='এন.আই.\nএ্যাক্ট'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const NIActPage()));
                    }
                    else if(title=='মাদক/\nদন্ডবিধি'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const MadokDondobidhiPage()));
                    }
                    else if(title=='বিশেষ\nট্রাইব্যুনাল'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const BiseshTribunalPage()));
                    }
                  },
                  child: Text('View All',style: TextStyle(fontSize: size*.04,fontWeight: FontWeight.w400))
              )
            ],
          ),
        ),
        Positioned(
          left: size*.05,
          top: size*.05,
          child: Container(
            height: size*.2,
            width: size*.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade500, blurRadius: 10)
                ]
            ),
            child: Text(title,style:TextStyle(color: Colors.white,fontWeight:FontWeight.w500, fontSize: size*.04)),
          ),
        )
      ],
    );
  }
}
