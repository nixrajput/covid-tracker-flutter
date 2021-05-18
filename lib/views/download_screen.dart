import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadScreen extends StatefulWidget {
  final String url;

  const DownloadScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  double _progress = 0.0;
  final Dio _dio = Dio();
  var _downloadStatus = "INITIALIZING";

  Future<Directory> _getTemporaryDirectory() async {
    return await getTemporaryDirectory();
  }

  Future<void> _download() async {
    final dir = await _getTemporaryDirectory();
    await Permission.storage.request();

    final savePath = path.join(dir.path, 'update.apk');
    await _startDownload(savePath);
  }

  Future<void> _startDownload(String savePath) async {
    await _dio.download(
      widget.url,
      savePath,
      onReceiveProgress: (int received, int total) {
        if (total != -1 && mounted) {
          setState(() {
            _progress = (received / total);
            _downloadStatus = "DOWNLOADING";
          });
        }
      },
    ).then((value) async {
      setState(() {
        _downloadStatus = "DOWNLOADED";
      });
      if (_downloadStatus == "DOWNLOADED") {
        final dir = await _getTemporaryDirectory();
        final filePath = path.join(dir.path, 'update.apk');
        OpenFile.open(filePath);
      }
    }).catchError((err) {
      print(err.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    _download();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$_downloadStatus",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "${(_progress * 100).toStringAsFixed(2)} %",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              LinearProgressIndicator(
                value: _progress,
                minHeight: 40.0,
                backgroundColor: Theme.of(context).bottomAppBarColor,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
