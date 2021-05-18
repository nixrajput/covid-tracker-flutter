import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid_tracker/models/covid_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IndiaDetailsScreen extends StatefulWidget {
  final CovidData stateWiseData;

  const IndiaDetailsScreen({
    Key? key,
    required this.stateWiseData,
  }) : super(key: key);

  @override
  _IndiaDetailsScreenState createState() => _IndiaDetailsScreenState();
}

class _IndiaDetailsScreenState extends State<IndiaDetailsScreen> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _networkStatus = false;

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

  double convertToDouble(String num) {
    double db;
    db = int.parse(num).toDouble();
    print(num + " " + db.toString());
    return db;
  }

  double _calculateDeathRate() {
    double num =
        (int.parse(widget.stateWiseData.statewise.first.deaths!) * 100) /
            int.parse(widget.stateWiseData.statewise.first.confirmed!);
    return num;
  }

  double _calculateRecoveryRate() {
    double num =
        (int.parse(widget.stateWiseData.statewise.first.recovered!) * 100) /
            int.parse(widget.stateWiseData.statewise.first.confirmed!);
    return num;
  }

  double _calculateActiveRate() {
    double num =
        (int.parse(widget.stateWiseData.statewise.first.active!) * 100) /
            int.parse(widget.stateWiseData.statewise.first.confirmed!);
    return num;
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bodyWidth = MediaQuery.of(context).size.width;
    final double bodyHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _buildAppBar(context),
              SizedBox(height: 16.0),
              !_networkStatus ? _buildBanner(context) : SizedBox(),
              !_networkStatus ? SizedBox(height: 16.0) : SizedBox(),
              _buildBody(context, bodyWidth, bodyHeight),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      )),
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
            "India",
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

  Column _buildBody(BuildContext context, double width, double height) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 10.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomRateCard(
                    bgColor: Colors.orangeAccent,
                    title: "Death Rate",
                    value: _calculateDeathRate().toStringAsFixed(2),
                  ),
                  CustomRateCard(
                    bgColor: Colors.lightGreen,
                    title: "Recovery Rate",
                    value: _calculateRecoveryRate().toStringAsFixed(2),
                  ),
                ],
              ),
              CustomRateCard(
                bgColor: Colors.lightBlue,
                title: "Active Rate",
                value: _calculateActiveRate().toStringAsFixed(2),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 10.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            children: [
              Text(
                "Vaccination Details",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Divider(color: Colors.grey.shade600),
              SizedBox(height: 8.0),
              CustomRowTextCard(
                title: "Total",
                value: widget.stateWiseData.tested.last.totaldosesadministered!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.totaldosesadministered!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .totaldosesadministered!,
              ),
              CustomRowTextCard(
                title: "Today",
                value: widget.stateWiseData.tested.last.samplereportedtoday!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.samplereportedtoday!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .samplereportedtoday!,
                isDimmed: true,
              ),
              CustomRowTextCard(
                title: "First Dose",
                value: widget.stateWiseData.tested.last.firstdoseadministered!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.firstdoseadministered!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .firstdoseadministered!,
                isDimmed: false,
              ),
              CustomRowTextCard(
                title: "Second Dose",
                value: widget.stateWiseData.tested.last.seconddoseadministered!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.seconddoseadministered!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .seconddoseadministered!,
                isDimmed: true,
              ),
              Divider(color: Colors.grey.shade600),
              Text(
                "Front-line Workers",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              CustomRowTextCard(
                title: "First Dose",
                value: widget.stateWiseData.tested.last
                        .frontlineworkersvaccinated1Stdose!.isNotEmpty
                    ? widget.stateWiseData.tested.last
                        .frontlineworkersvaccinated1Stdose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .frontlineworkersvaccinated1Stdose!,
                isDimmed: false,
              ),
              CustomRowTextCard(
                title: "Second Dose",
                value: widget.stateWiseData.tested.last
                        .frontlineworkersvaccinated2Nddose!.isNotEmpty
                    ? widget.stateWiseData.tested.last
                        .frontlineworkersvaccinated2Nddose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .frontlineworkersvaccinated2Nddose!,
                isDimmed: true,
              ),
              Divider(color: Colors.grey.shade600),
              Text(
                "Health Care Workers",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              CustomRowTextCard(
                title: "First Dose",
                value: widget.stateWiseData.tested.last
                        .healthcareworkersvaccinated1Stdose!.isNotEmpty
                    ? widget.stateWiseData.tested.last
                        .healthcareworkersvaccinated1Stdose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .healthcareworkersvaccinated1Stdose!,
                isDimmed: false,
              ),
              CustomRowTextCard(
                title: "Second Dose",
                value: widget.stateWiseData.tested.last
                        .healthcareworkersvaccinated2Nddose!.isNotEmpty
                    ? widget.stateWiseData.tested.last
                        .healthcareworkersvaccinated2Nddose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .healthcareworkersvaccinated2Nddose!,
                isDimmed: true,
              ),
              Divider(color: Colors.grey.shade600),
              Text(
                "Over 45 Years Citizens",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              CustomRowTextCard(
                title: "First Dose",
                value: widget.stateWiseData.tested.last.over45Years1Stdose!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.over45Years1Stdose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .over45Years1Stdose!,
                isDimmed: false,
              ),
              CustomRowTextCard(
                title: "Second Dose",
                value: widget.stateWiseData.tested.last.over45Years2Nddose!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.over45Years2Nddose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .over45Years2Nddose!,
                isDimmed: true,
              ),
              Divider(color: Colors.grey.shade600),
              Text(
                "Over 60 Years Citizens",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              CustomRowTextCard(
                title: "First Dose",
                value: widget.stateWiseData.tested.last.over60Years1Stdose!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.over60Years1Stdose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .over60Years1Stdose!,
                isDimmed: false,
              ),
              CustomRowTextCard(
                title: "Second Dose",
                value: widget.stateWiseData.tested.last.over60Years2Nddose!
                        .isNotEmpty
                    ? widget.stateWiseData.tested.last.over60Years2Nddose!
                    : widget
                        .stateWiseData
                        .tested[widget.stateWiseData.tested.length - 2]
                        .over60Years2Nddose!,
                isDimmed: true,
              )
            ],
          ),
        )
      ],
    );
  }
}

class CustomRateCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? bgColor;
  final VoidCallback? onTap;

  const CustomRateCard({
    Key? key,
    required this.title,
    required this.value,
    this.bgColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            )),
          ),
          Text(
            "$value %",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              color: bgColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            )),
          ),
        ],
      ),
    );
  }
}

class CustomRowTextCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isDimmed;

  const CustomRowTextCard({
    Key? key,
    required this.title,
    required this.value,
    this.isDimmed = false,
  }) : super(key: key);

  String _formatNumber(String num) {
    NumberFormat _numFormat = NumberFormat();
    if (num.isNotEmpty) {
      _numFormat = NumberFormat("#,##,000", "HI");
    }
    return _numFormat.format(int.parse(num));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      color: isDimmed
          ? Theme.of(context).bottomAppBarColor
          : Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (width / 2),
            child: Text(
              "$title",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          if (value.isNotEmpty)
            Text(
              _formatNumber(value),
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
