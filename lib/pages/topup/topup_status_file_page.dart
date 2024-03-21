import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class TopupStatusFile extends StatelessWidget {
  final String fileTitle;
  final String filePath;
  const TopupStatusFile(
      {super.key, required this.fileTitle, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${fileTitle}',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
        ),
        backgroundColor: HexColor('#FFFFFF'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/back-icon.svg'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: PDFView(
                  autoSpacing: false, pageFling: false, filePath: filePath)),
        ],
      ),
    );
  }
}
