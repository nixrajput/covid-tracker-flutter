import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/models/covid_data.dart';
import 'package:covid_tracker/models/data.dart';
import 'package:covid_tracker/models/state_wise_data.dart';
import 'package:covid_tracker/views/about_screen.dart';
import 'package:covid_tracker/views/india_details_screen.dart';
import 'package:covid_tracker/views/webview_screen.dart';
import 'package:covid_tracker/views/widgets/custom_case_card.dart';
import 'package:covid_tracker/views/widgets/custom_text_btn.dart';
import 'package:covid_tracker/views/widgets/loading_indicator.dart';
import 'package:covid_tracker/views/widgets/state_wise_case_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<DataModel> _fetchedCovidData;
  bool _viewMore = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _networkStatus = false;

  Future<DataModel> _fetchCovidData() async {
    CovidData _covidData;
    StateWiseData _stateWiseData;
    Dio dio = Dio();

    final responseData = await dio.get(BASE_URL + DATA_URL);

    _covidData = CovidData.fromJson(responseData.data);
    final stateResponseData = await dio.get(BASE_URL + STATE_WISE_DATA_URL);
    _stateWiseData = StateWiseData.fromJson(stateResponseData.data);

    return DataModel(covidData: _covidData, stateWiseData: _stateWiseData);
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
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _fetchedCovidData = _fetchCovidData();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchCovidData,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _buildAppBar(context),
                  SizedBox(height: 16.0),
                  !_networkStatus ? _buildBanner(context) : SizedBox(),
                  !_networkStatus ? SizedBox(height: 16.0) : SizedBox(),
                  _buildCovidStatusBody(context),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
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
            APP_NAME,
            style: GoogleFonts.carterOne(
              textStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () => _showBottomSheet(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.menu,
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

  FutureBuilder<DataModel> _buildCovidStatusBody(BuildContext context) {
    return FutureBuilder<DataModel>(
      future: _fetchedCovidData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final CovidData _covidData = snapshot.data!.covidData;
            final List<Statewise> _stateWiseData = _covidData.statewise;
            final StateWiseData _stateWiseDailyData =
                snapshot.data!.stateWiseData;
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
                      Text(
                        "COVID-19 India Status",
                        style: GoogleFonts.luckiestGuy(
                          textStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Divider(color: Colors.grey.shade600),
                      Text(
                        "Last Updated",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "${_covidData.statewise.first.lastupdatedtime!}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCaseCard(
                            bgColor: Colors.orangeAccent,
                            title: "Confirmed",
                            value1:
                                _covidData.statewise.first.confirmed!.isNotEmpty
                                    ? _covidData.statewise.first.confirmed!
                                    : _covidData
                                        .casesTimeSeries.last.totalconfirmed!,
                            value2: _covidData
                                    .statewise.first.deltaconfirmed!.isNotEmpty
                                ? _covidData.statewise.first.deltaconfirmed!
                                : _covidData
                                    .casesTimeSeries.last.dailyconfirmed!,
                          ),
                          CustomCaseCard(
                            bgColor: Colors.lightBlue,
                            title: "Active",
                            value1:
                                _covidData.statewise.first.active!.isNotEmpty
                                    ? _covidData.statewise.first.active!
                                    : "0",
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomCaseCard(
                            bgColor: Colors.lightGreen,
                            title: "Recovered",
                            value1:
                                _covidData.statewise.first.recovered!.isNotEmpty
                                    ? _covidData.statewise.first.recovered!
                                    : _covidData
                                        .casesTimeSeries.last.totalrecovered!,
                            value2: _covidData
                                    .statewise.first.deltarecovered!.isNotEmpty
                                ? _covidData.statewise.first.deltarecovered!
                                : _covidData
                                    .casesTimeSeries.last.dailyrecovered!,
                          ),
                          CustomCaseCard(
                            bgColor: Colors.red,
                            title: "Deaths",
                            value1:
                                _covidData.statewise.first.deaths!.isNotEmpty
                                    ? _covidData.statewise.first.deaths!
                                    : _covidData
                                        .casesTimeSeries.last.totaldeceased!,
                            value2: _covidData
                                    .statewise.first.deltadeaths!.isNotEmpty
                                ? _covidData.statewise.first.deltadeaths!
                                : _covidData
                                    .casesTimeSeries.last.dailydeceased!,
                          ),
                        ],
                      ),
                      CustomCaseCard(
                        bgColor: Colors.cyan,
                        title: "Vaccinations",
                        value1: _covidData
                                .tested.last.totaldosesadministered!.isNotEmpty
                            ? _covidData.tested.last.totaldosesadministered!
                            : _covidData.tested[_covidData.tested.length - 2]
                                .totaldosesadministered!,
                        value2: _covidData
                                .tested.last.samplereportedtoday!.isNotEmpty
                            ? _covidData.tested.last.samplereportedtoday!
                            : _covidData.tested[_covidData.tested.length - 2]
                                .samplereportedtoday!,
                      ),
                      CustomTextBtn(
                        text: "View More",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => IndiaDetailsScreen(
                                stateWiseData: _covidData,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                _buildStateWiseDataBody(
                  context,
                  _stateWiseData,
                  _stateWiseDailyData,
                ),
              ],
            );
          } else {
            print(snapshot);
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.redAccent),
              ),
            );
          }
        } else {
          return Center(
              child: LoadingIndicator(
            color: Theme.of(context).accentColor,
          ));
        }
      },
    );
  }

  Container _buildStateWiseDataBody(
    BuildContext context,
    List<Statewise> stateWiseData,
    StateWiseData stateWiseDailyData,
  ) {
    return Container(
      child: Column(
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
                Text(
                  "Covid-19 Statewise Status",
                  style: GoogleFonts.luckiestGuy(
                    textStyle: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Divider(color: Colors.grey.shade600),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _viewMore ? stateWiseData.length : 6,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        if (stateWiseData[i].statecode != "TT" &&
                            stateWiseData[i].statecode != "UN")
                          StateWiseCaseCard(
                            title: stateWiseData[i].state!,
                            confirmedCases: stateWiseData[i].confirmed!,
                            activeCases: stateWiseData[i].active!,
                            recoveredCases: stateWiseData[i].recovered!,
                            deathCases: stateWiseData[i].deaths!,
                            stateNotes: stateWiseData[i].statenotes!,
                            cardColor: i.isEven
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).bottomAppBarColor,
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8.0),
                CustomTextBtn(
                  text: _viewMore ? "View Less" : 'View More',
                  onTap: () {
                    setState(() {
                      _viewMore = !_viewMore;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      APP_NAME,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                      },
                      child: Icon(
                        Icons.close,
                        size: 32.0,
                      ),
                    )
                  ],
                ),
                Divider(color: Colors.grey),
                CustomTile(
                  title: 'Guidelines',
                  icon: Icons.label_important,
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewScreen(url: GUIDELINES_URL),
                      ),
                    );
                  },
                ),
                CustomTile(
                  title: 'About',
                  icon: Icons.info,
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AboutScreen(),
                      ),
                    );
                  },
                ),
                CustomTile(
                  title: 'Privacy Policy',
                  icon: Icons.policy,
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewScreen(url: PRIVACY_POLICY_URL),
                      ),
                    );
                  },
                ),
                CustomTile(
                  title: "Terms of use",
                  icon: Icons.details,
                  onTap: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewScreen(url: USER_TERMS_URL),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
            SizedBox(width: 20.0),
            Text(
              title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
