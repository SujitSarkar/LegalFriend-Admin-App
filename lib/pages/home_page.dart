import 'package:admin_app/pages/bodli_khana_list_page.dart';
import 'package:admin_app/pages/dashboard_page.dart';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final PublicProvider publicProvider = Provider.of<PublicProvider>(context);
    final DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    final double size=publicProvider.size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:Image.asset('assets/splash_image.png',
            fit: BoxFit.fitWidth,height: 50),
      ),
      body: _bodyUI(publicProvider, databaseProvider, size),
    );
  }

  Widget _bodyUI(PublicProvider publicProvider, DatabaseProvider databaseProvider,double size)=>SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: size*.03,vertical: size*.04),
      child: GridView.builder(
        shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: size*.02,
            mainAxisSpacing: size*.02),
        itemCount: Variables.homeGridItem.length,
        itemBuilder: (_,index)=>InkWell(
          onTap: (){
            if(index==0) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const DashBoardPage()));
            } else if(index==1) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BodliKhanaListPage()));
            }
          },
          child: Container(
            padding: EdgeInsets.all(size*.02),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(size*.04))
            ),
            child: Text(Variables.homeGridItem[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: size*.045,
              fontWeight: FontWeight.bold
            ),),
          ),
            borderRadius: BorderRadius.all(Radius.circular(size*.04))
        ),
          ),
    ),
  );
}
