
import 'dart:io';
import 'package:admin_app/providers/database_provider.dart';
import 'package:admin_app/providers/public_provider.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:admin_app/widgets/gradient_button.dart';
import 'package:admin_app/widgets/notification_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NoticeBoardPage extends StatefulWidget {
  const NoticeBoardPage({Key? key}) : super(key: key);

  @override
  _NoticeBoardPageState createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isLoading = false;
  int _counter = 0;
  File? _imageFile;

  String name = '';
  // var data;
  // var file;
  String? error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  Future<void> _updateImage(DatabaseProvider databaseProvider) async {
    setState(() => _isLoading = true);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('NoticeBoard')
        .child('noticeBoard_123456789');
    firebase_storage.UploadTask storageUploadTask =
        storageReference.putFile(_imageFile!);
    firebase_storage.TaskSnapshot taskSnapshot;
    await storageUploadTask.then((value) async {
      taskSnapshot = value;
      await taskSnapshot.ref.getDownloadURL().then((newImageDownloadUrl) async {
        final String downloadUrl = newImageDownloadUrl;
        await FirebaseFirestore.instance
            .collection('NoticeBoard')
            .doc('noticeBoard_123456789')
            .set({
          'id': 'noticeBoard_123456789',
          'image_link': downloadUrl
        }).then((value) async {
          await databaseProvider.getNoticeBoardImageLink();
          setState(() => _isLoading = false);
          showToast('আপডেট সম্পন্ন হয়েছে');
        });
      }, onError: (error) {
        setState(() => _isLoading = false);
        showToast('আপডেট ব্যর্থ হয়েছে');
      });
    }, onError: (error) {
      setState(() => _isLoading = false);
      showToast('আপডেট ব্যর্থ হয়েছে');
    });
  }

  Future<void> _customInit(DatabaseProvider databaseProvider) async {
    setState(() => _counter++);
    if (databaseProvider.noticeBoardImageLink.isEmpty) {
      setState(() => _isLoading = true);
      await databaseProvider.getNoticeBoardImageLink().then((value) {
        setState(() => _isLoading = false);
      });
    }
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
        title: const Text(Variables.noticeBoard),
        elevation: 00,
      ),
      body: Column(
        children: [
          TabBar(controller: _tabController, tabs: [
            Tab(
                child: Text('নোটিশ বোর্ড',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
            Tab(
                child: Text('আপডেট নোটিশ বোর্ড',
                    style: TextStyle(
                        fontSize: size* .04,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))),
          ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              _showNoticeBoard(size, databaseProvider),
              _updateNoticeBoard(size, databaseProvider)
            ]),
          ),
        ],
      ),
    );
  }

  Widget _showNoticeBoard(double size, DatabaseProvider databaseProvider) =>
      _isLoading
          ? spinCircle()
          : databaseProvider.noticeBoardImageLink.isNotEmpty
              ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*.6,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: databaseProvider.noticeBoardImageLink,
                                placeholder: (context, url) => Center(child: spinCircle()),
                                errorWidget: (context, url, error) => const Icon(Icons.info_outline),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: 5.0,
                              right: 5.0,
                              child: IconButton(
                                onPressed: () {
                                  showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return ClassicGeneralDialogWidget(
                                        titleText: 'Delete This Notice?',
                                        positiveText: 'YES',
                                        negativeText: 'NO',
                                        negativeTextStyle: TextStyle(
                                            color: Colors.green,
                                            fontSize: size*.04
                                        ),
                                        positiveTextStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: size*.04
                                        ),
                                        onPositiveClick: () async{
                                          showLoadingDialog(context);
                                          await databaseProvider.deleteNoticeBoardImageLink().then((value)async{
                                            if(value){
                                              closeLoadingDialog(context);
                                              closeLoadingDialog(context);
                                              showToast('Notice Deleted Success');
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
                                },
                                icon: const Icon(Icons.delete,
                                    color: Colors.red, size: 35,
                                    semanticLabel: 'Add Image'),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
              : Center(
                child: Text(
                    'কোন নোটিশ নেই !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: size* .05,
                        color: const Color(0xffF0A732)),
                  ),
              );

  Widget _updateNoticeBoard(double size, DatabaseProvider databaseProvider) =>
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                        height: MediaQuery.of(context).size.height*.6,
                        width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: _imageFile !=null
                          ? Image.file(_imageFile!)
                          :Image.asset('assets/add_photo.png',fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height*.6,
                          width: MediaQuery.of(context).size.width),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  Positioned(
                    top: 5.0,
                    right: 5.0,
                    child: IconButton(
                      onPressed: ()async{
                        final ImagePicker _picker = ImagePicker();
                       final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
                       setState(() {
                         _imageFile = File(_image!.path);
                       });
                      },
                      icon: Icon(Icons.camera_alt_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 35,
                          semanticLabel: 'Add Image'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size* .04),
              _isLoading
                  ? spinCircle()
                  : GradientButton(
                      child: Text('আপডেট',
                          style: TextStyle(
                              fontSize: size* .05,
                              color: Colors.white)),
                      onPressed: (){
                        _imageFile!=null? _updateImage(databaseProvider):showToast('Select an Image');},
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
}
