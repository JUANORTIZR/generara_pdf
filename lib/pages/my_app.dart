import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generara_pdf/models/control.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generar pdf',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Generar pdf'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                generarPdf().then((value) => print(value));
              },
              child: const Text("Generar pdf")),
        ));
  }

  Future<String> generarPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      // mainAxisAlignment: pw.MainAxisAlignment.center,

      header: (context) {
        return pw.Row(children: [pw.Text("Encambezado")]);
      },
      build: (pw.Context contex) => [buildTitle(), texto()],
      footer: (context) {
        final text = 'Página ${context.pageNumber} | ${context.pagesCount}';
        return footer(text);
      },
    ));
    pdf.addPage(pw.MultiPage(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        header: (context) {
          return pw.Row(children: [pw.Text("Encambezado")]);
        },
        build: (pw.Context contex) => [buildTitleTabla(), tabla(<Control>[])],
        footer: (context) {
          final text = 'Página ${context.pageNumber} | ${context.pagesCount}';

          return footer(text);
        }));
    final dir = await getApplicationDocumentsDirectory();
    var name = "primerPdf.pdf";
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(await pdf.save());
    openFile(file);
    return dir.path;
  }

  pw.Widget footer(String text) {
    return pw.Column(children: [
      pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child:
              pw.Text(text, style: const pw.TextStyle(color: PdfColors.green))),
      pw.Container(
          alignment: pw.Alignment.centerLeft,
          margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
          child: pw.Text(
              "Dirección: Kilometro 38 vía chiriguana, La Jagüa de Ibirico \nNumero celular: 3122992545 \nCorreo: Agrorganicosemillas@gmail.com",
              style: const pw.TextStyle(color: PdfColors.blueGrey300)))
    ]);
  }

  pw.Widget tabla(List<Control> contenido) {
    final headers = [
      'Dia',
      'Cosecharte',
      'Compass',
      'Total',
    ];

    contenido.add(Control("1", "34", "23", "543"));
    contenido.add(Control("2", "343", "223", "343"));
    contenido.add(Control("3", "344", "253", "5413"));
    contenido.add(Control("4", "344", "253", "5413"));
    contenido.add(Control("5", "344", "253", "5413"));
    contenido.add(Control("6", "344", "253", "5413"));
    contenido.add(Control("7", "344", "253", "5413"));
    contenido.add(Control("8", "344", "253", "5413"));
    contenido.add(Control("9", "344", "253", "5413"));
    contenido.add(Control("10", "344", "253", "5413"));
    contenido.add(Control("11", "344", "253", "5413"));
    contenido.add(Control("12", "344", "253", "5413"));
    contenido.add(Control("13", "344", "253", "5413"));
    contenido.add(Control("14", "344", "253", "5413"));
    contenido.add(Control("15", "344", "253", "5413"));
    contenido.add(Control("16", "344", "253", "5413"));
    contenido.add(Control("17", "344", "253", "5413"));
    contenido.add(Control("18", "344", "253", "5413"));
    contenido.add(Control("19", "344", "253", "5413"));
    contenido.add(Control("20", "344", "253", "5413"));
    contenido.add(Control("21", "344", "253", "5413"));
    contenido.add(Control("22", "344", "253", "5413"));
    contenido.add(Control("23", "344", "253", "5413"));
    contenido.add(Control("24", "344", "253", "5413"));
    contenido.add(Control("25", "344", "253", "5413"));
    contenido.add(Control("26", "344", "253", "5413"));
    contenido.add(Control("27", "344", "253", "5413"));
    contenido.add(Control("28", "344", "253", "5413"));
    contenido.add(Control("29", "344", "253", "5413"));
    contenido.add(Control("30", "344", "253", "5413"));
    contenido.add(Control("31", "344", "253", "5413"));

    var suma = 0;
    for (var i = 0; i < contenido.length; i++) {
      suma += int.parse(contenido[i].compass);
    }

    final data = contenido.map((control) {
      return [control.dia, control.cosecharte, control.compass, control.total];
    }).toList();

    data.add(['suma dia', 'suma cosecharte', suma.toString(), 'suma total']);

    return pw.Table.fromTextArray(
        headers: headers,
        data: data,
        headerDecoration: const pw.BoxDecoration(color: PdfColors.green300),
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        cellHeight: 2,
        cellAlignments: {
          0: pw.Alignment.centerRight,
          1: pw.Alignment.centerRight,
          2: pw.Alignment.centerRight,
          3: pw.Alignment.centerRight,
        });
  }

  pw.Widget buildTitle() => pw.Center(
          child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            "AGRORGANICO SEMILLAS",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 14),
          pw.Text(
            "CON",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 14),
          pw.Text(
            "NIT:12523764-7",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 30),
          pw.Text(
            "CERTIFICA QUE",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
        ],
      ));

  pw.Widget texto() {
    return pw.Column(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
      pw.Paragraph(
          text:
              'Del 2 al 31 mayo se recibieron en la granja Villa Noris ubicada en la vereda salsipuedes judiridiccion de la jagua de ibirico,  33.559 kilogramos de reciduos organicos provenientes de los comedores ubicados en las minas Pribbenow y el Descanso de la empresa DRUMMOND LTD con NIT:800.021.308-5, sobre los cuales se llevo a cabo un proceso de biotransformacion controlada basada en compostaje',
          style: const pw.TextStyle(fontSize: 12)),
      pw.SizedBox(height: 350),
      pw.Text('Juan Carlos Ortiz Maestre'),
      pw.Text('__________________________'),
      pw.Text('FIRMA GERENTE')
    ]);
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  pw.Widget buildTitleTabla() => pw.Center(
          child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(
            "-Informacion detallada de los residuos en kilogramos (kg) recibidos en el mes de mayo del 2021",
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 14),
        ],
      ));
}
