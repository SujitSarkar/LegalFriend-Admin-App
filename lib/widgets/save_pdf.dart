import 'dart:typed_data';
import 'package:admin_app/model_class/bodli_khana_model.dart';
import 'package:admin_app/variables/static_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'notification_widget.dart';

class SavePDF{

  static Future<void> savePdf(List<BodliKhanaModel> dataList, String title,BuildContext context)async{
    showLoadingDialog(context);
    final pdf = pw.Document();
    var data = await rootBundle.load("assets/font/kalpurush.ttf");
    var myFont = pw.Font.ttf(data);
    var boldTextStyle = pw.TextStyle(
        font: myFont,
        fontSize: 11.0,
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.black,
    );
    var normalTextStyle = pw.TextStyle(
        font: myFont,
        fontSize: 8.0,
        fontWeight: pw.FontWeight.normal,
        color: PdfColors.black
    );

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context){
            return[
              pw.Header(
                //level: 0,
                child: pw.Text(title,textAlign:pw.TextAlign.center,style: boldTextStyle),
              ),

              ///Table Header
              pw.Row(
                  children: [
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            width: 272,
                            child: pw.Text(
                                Variables.dayraNo,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.crMamlaNo,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.pokkhogonerNam,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.porobortiTang,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.bicaricAdalot,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.amoliAdalot,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.mamlarDhoron,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                    pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.boiNo,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),pw.Expanded(
                        child: pw.Container(
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                                Variables.jojCourt,
                                textAlign: pw.TextAlign.center,
                                style: normalTextStyle
                            )
                        )
                    ),
                  ]
              ),
              pw.Divider(color: PdfColors.grey900,height: 5.0),
              pw.SizedBox(height: 10.0),

                pw.ListView.builder(
                  itemCount:dataList.length,
                  itemBuilder: (context, index){
                    return pw.Column(
                      children:[
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].dayraNo!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].mamlaNo!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].pokkhoDhara!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].porobortiTarikh!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].bicarikAdalot!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].amoliAdalot!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].mamlarDhoron!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].boiNo!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),pw.Expanded(
                                child: pw.Container(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text(
                                      dataList[index].jojCourt!,
                                      textAlign: pw.TextAlign.center,
                                      style: normalTextStyle
                                  ),
                                )
                              ),
                            ]
                        ),
                        pw.Divider(height: 0.0,thickness: 0.5,color: PdfColors.grey)
                      ]
                    );
                  }
                )
            ];
          }
        //maxPages: 100
      ),
    );
    Uint8List pdfInBytes = await pdf.save();


    closeLoadingDialog(context);
    Navigator.pop(context);

  }

}
