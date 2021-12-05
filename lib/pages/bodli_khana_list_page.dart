import 'package:admin_app/pages/bodli_khana/madok_dondobidhi_page.dart';
import 'package:admin_app/pages/bodli_khana/ni_act_page.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bodli_khana/bisesh_tribunal_page.dart';
import 'dashboard_page.dart';

class BodliKhanaListPage extends StatelessWidget {
  const BodliKhanaListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size = publicProvider.size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(Variables.bodliKhana),
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: Variables.bodlikhanaList.length,
        itemBuilder: (_,index)=>InkWell(
            onTap: (){
              if(index==0) Navigator.push(context, MaterialPageRoute(builder: (context)=>const NIActPage()));
              if(index==1) Navigator.push(context, MaterialPageRoute(builder: (context)=>const MadokDondobidhiPage()));
              if(index==2) Navigator.push(context, MaterialPageRoute(builder: (context)=>const BiseshTribunalPage()));
            },
            child: Container(
              height: size*.3,
              margin: EdgeInsets.symmetric(horizontal: size*.04,vertical: size*.04),
              padding: EdgeInsets.all(size*.02),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(size*.04))
              ),
              child: Text(Variables.bodlikhanaList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: size*.05,
                    fontWeight: FontWeight.bold
                ),),
            ),
            borderRadius: BorderRadius.all(Radius.circular(size*.04))
        ),
      ),
    );
  }
}
