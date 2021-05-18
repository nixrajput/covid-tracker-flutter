import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid_tracker/constants/colors.dart';
import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/views/webview_screen.dart';
import 'package:covid_tracker/views/widgets/company_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _networkStatus = false;

  PackageInfo _packageInfo = PackageInfo(
    appName: UNKNOWN,
    packageName: UNKNOWN,
    version: UNKNOWN,
    buildNumber: UNKNOWN,
  );

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          _networkStatus = true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          _networkStatus = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          _networkStatus = false;
        });
        break;
      default:
        setState(() {
          _networkStatus = false;
        });
        break;
    }
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initPackageInfo();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bodyHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: bodyHeight,
          child: Column(
            children: [
              _buildAppBar(context),
              SizedBox(height: 16.0),
              !_networkStatus ? _buildBanner(context) : SizedBox(),
              !_networkStatus ? SizedBox(height: 16.0) : SizedBox(),
              Expanded(child: _buildBody(context, bodyHeight)),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "About",
            style: GoogleFonts.carterOne(
              textStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back,
                size: 32.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Theme.of(context).bottomAppBarColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.network_check,
                color: Colors.redAccent,
              ),
              SizedBox(width: 8.0),
              Text(
                "No connection available.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              _initConnectivity();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'RETRY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildBody(BuildContext context, double height) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _versionArea(height),
          _companyDetails(height),
          _socialIconLink(),
        ],
      ),
    );
  }

  Column _versionArea(double height) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.0),
          Image.asset(
            LOCAL_ICON_PATH,
            height: 80.0,
          ),
          SizedBox(height: 10.0),
          Text(
            _packageInfo.appName,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            '$VERSION : ${_packageInfo.version} (${_packageInfo.buildNumber})',
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  GestureDetector _companyDetails(double height) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WebViewScreen(url: COMPANY_URL),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              COMPANY_LOGO_IMAGE_PATH,
              height: 50.0,
            ),
            CompanyLogoText(
              firstColor: secondColor,
              fontSize2: 32.0,
              fontSize1: 32.0,
            )
          ],
        ),
      );

  Column _socialIconLink() => Column(
        children: [
          Text(
            CREDITS.toUpperCase(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text("https://api.covid19india.org"),
          Text("https://www.mohfw.gov.in"),
          Text("https://disease.sh"),
          Text("https://www.cdc.gov"),
        ],
      );
}
