import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:covid_tracker/constants/colors.dart';
import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/controllers/firebase_functions.dart';
import 'package:covid_tracker/views/download_screen.dart';
import 'package:covid_tracker/views/home_screen.dart';
import 'package:covid_tracker/views/widgets/company_text_widget.dart';
import 'package:covid_tracker/views/widgets/custom_border_btn.dart';
import 'package:covid_tracker/views/widgets/custom_rounded_btn.dart';
import 'package:covid_tracker/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:version/version.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasUpdate = false;
  bool _hasError = false;
  bool _isLoading = false;
  var _message;
  var _downloadUrl;
  var _latVer;
  var _latBuildNo;
  var _currVer;
  var _currBuildNo;
  List<dynamic> _changelog = [];
  PackageInfo _packageInfo = PackageInfo(
    appName: UNKNOWN,
    packageName: UNKNOWN,
    version: UNKNOWN,
    buildNumber: UNKNOWN,
  );
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _networkStatus = false;

  Future<void> _checkAppBuildInfo() async {
    setState(() {
      _isLoading = true;
    });

    if (_networkStatus) {
      try {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        setState(() {
          _packageInfo = packageInfo;
        });

        try {
          await FirebaseFunctions.getAppInfo().then((appInfoSnapshot) {
            if (appInfoSnapshot.exists) {
              final String latVer = appInfoSnapshot.data()![LATEST_VERSION];
              final int latBuildNo =
                  appInfoSnapshot.data()!['$LATEST_BUILD_NO'];
              int major = int.parse(_packageInfo.version.substring(0, 1));
              int minor = int.parse(_packageInfo.version.substring(2, 3));
              int patch = int.parse(_packageInfo.version
                  .substring(4, _packageInfo.version.length));
              int currBuildNo = int.parse(_packageInfo.buildNumber);

              final Version currVer = Version(major, minor, patch);
              final Version latVersion = Version.parse(latVer);

              if (latVersion > currVer || latBuildNo > currBuildNo) {
                setState(() {
                  _hasUpdate = true;
                  _hasError = false;
                  _downloadUrl = appInfoSnapshot.data()![APP_URL].toString();
                  _changelog = appInfoSnapshot.data()![CHANGELOG.toLowerCase()];
                  _latVer = latVersion;
                  _latBuildNo = latBuildNo;
                  _currVer = currVer.toString();
                  _currBuildNo = currBuildNo.toString();
                });
              } else {
                setState(() {
                  _hasUpdate = false;
                  _hasError = false;
                });
              }
            } else {
              setState(() {
                _hasError = true;
                _message = '$APP_INFO_EMPTY_WARNING';
                _isLoading = false;
              });
            }
          });
        } on FirebaseException catch (ex) {
          setState(() {
            _hasError = true;
            _message = ex.message.toString();
            _isLoading = false;
          });
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } on PlatformException catch (e) {
        setState(() {
          _hasError = true;
          _message = e.message.toString();
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _hasError = true;
        _message = NETWORK_WARNING;
        _isLoading = false;
      });
    }

    if (!_hasUpdate && !_isLoading && !_hasError) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  void _navigateToDownloadPage() {
    final url = _downloadUrl;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DownloadScreen(url: url),
        ));
  }

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

  @override
  void initState() {
    super.initState();
    _initConnectivity().then((_) => _checkAppBuildInfo());
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height;
    final double bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: _buildBody(bodyWidth, bodyHeight),
      ),
    );
  }

  Widget _buildBody(double width, double height) {
    if (_isLoading && !_hasError && !_hasUpdate) {
      return _loadingScreen(width, height);
    }
    if (_hasError && !_hasUpdate && !_isLoading) {
      return _errorScreen(width, height);
    }
    if (_hasUpdate && !_hasError && !_isLoading) {
      return _updateScreen(height);
    }
    return _loadingScreen(width, height);
  }

  Widget _errorScreen(double width, double height) => Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: height * 0.1),
              Image.asset(
                ERROR_IMAGE_PATH,
                width: width * 0.5,
              ),
              SizedBox(height: height * 0.1),
              Text(
                '$ERROR_OCCUR_WARNING',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade400,
                ),
              ),
              if (_message != null) SizedBox(height: height * 0.02),
              if (_message != null)
                Text(
                  "$_message",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.red.shade400,
                  ),
                ),
              SizedBox(height: height * 0.1),
              CustomBorderBtn(
                width: width * 0.4,
                borderRadius: 20.0,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                title: '$RETRY'.toUpperCase(),
                onTap: _checkAppBuildInfo,
              )
            ],
          ),
        ),
      );

  Widget _loadingScreen(double width, double height) => Container(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: height * 0.1),
                Image.asset(
                  LOCAL_ICON_PATH,
                  height: 100.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  '$APP_NAME',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingIndicator(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$DEVELOPED $BY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      COMPANY_LOGO_IMAGE_PATH,
                      height: 40.0,
                    ),
                    SizedBox(width: 5.0),
                    CompanyLogoText(
                      firstColor: secondColor,
                      fontSize1: 24.0,
                      fontSize2: 24.0,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  Widget _updateScreen(bodyHeight) => Container(
        height: bodyHeight,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 16.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('$UPDATE_WARNING',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 5.0),
                    Text(
                        'CURRENT ${VERSION.toUpperCase()} : $_currVer ($_currBuildNo)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 5.0),
                    Text(
                        'LATEST ${VERSION.toUpperCase()} : $_latVer ($_latBuildNo)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Divider(color: Theme.of(context).accentColor),
                    Text('${CHANGELOG.toUpperCase()}:',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    if (_changelog.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _changelog.length,
                        itemBuilder: (ctx, index) =>
                            Text('- ${_changelog[index]}',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                      ),
                    SizedBox(height: 40.0),
                    CustomRoundedBtn(
                      title: '$UPDATE',
                      onTap: _navigateToDownloadPage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
