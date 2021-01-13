import 'dart:async';

import 'package:covid_tracker/constants/strings.dart';
import 'package:covid_tracker/models/global_covid_data.dart';
import 'package:covid_tracker/screens/about_page.dart';
import 'package:covid_tracker/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:covid_tracker/widgets/cards/case_info_card.dart';
import 'package:covid_tracker/widgets/cards/help_card.dart';
import 'package:covid_tracker/widgets/cards/prevention_card.dart';
import 'package:covid_tracker/widgets/custom_app_bar.dart';
import 'package:covid_tracker/widgets/custom_border_btn.dart';
import 'package:covid_tracker/widgets/custom_circular_progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home-screen';

  final countryData;

  HomeScreen({this.countryData});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  void _navigateToAboutPage() {
    Navigator.pushNamed(context, AboutPage.routeName);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<CovidData>> fetchedData() async {
    List<CovidData> _globalData = [];
    Dio dio = Dio();
    final response = await dio.get(GLOBAL_CASE_URL);
    _globalData = (response.data as List)
        .map((data) => CovidData.fromJson(data))
        .toList();
    return _globalData;
  }

  @override
  Widget build(BuildContext context) {
    final double bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    final double bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CustomCircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              )
            : Column(
                children: [
                  CustomAppBar(
                    title: DASHBOARD,
                    titleColor: Theme.of(context).accentColor,
                    leading: GestureDetector(
                      onTap: () => showBottomSheet(context),
                      child: SvgPicture.asset(
                        MENU_ICON_PATH,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: _navigateToAboutPage,
                      child: SvgPicture.asset(
                        INFO_ICON_PATH,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Expanded(child: _buildBody(bodyWidth, bodyHeight))
                ],
              ),
      ),
    );
  }

  Widget _buildBody(double width, double height) => RefreshIndicator(
        onRefresh: () => fetchedData(),
        child: FutureBuilder<List<CovidData>>(
            future: fetchedData(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.hasError) {
                return _errorScreen(width, height, dataSnapshot.error);
              } else if (dataSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CustomCircularProgressIndicator(
                    color: Theme.of(context).accentColor,
                  ),
                );
              }
              return showCaseDetails(dataSnapshot.data);
            }),
      );

  Widget showCaseDetails(List<CovidData> data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 10),
          PreventionCard(),
          HelpCard(),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (ctx, i) => CaseInfoCard(
              country: data[i].country,
              tested: data[i].tested,
              infected: data[i].infected,
              recovered: data[i].recovered,
              deceased: data[i].deceased,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _errorScreen(double width, double height, String error) => Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: height * 0.1),
              Padding(
                padding: EdgeInsets.only(left: width * 0.3),
                child: Image.asset(
                  ERROR_IMAGE_PATH,
                  width: width * 0.5,
                ),
              ),
              SizedBox(height: height * 0.2),
              Text(
                '$ERROR_OCCUR_WARNING',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (error != null) SizedBox(height: height * 0.05),
              if (error != null)
                Text(
                  error,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              SizedBox(height: height * 0.1),
              CustomBorderBtn(
                width: width * 0.25,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                title: '$RETRY',
                onTap: fetchedData,
              )
            ],
          ),
        ),
      );

  showBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(16.0),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return CustomBottomSheet(
            sendMailFunc: () => _sendEmail('nixlab.inc@gmail.com'),
            shareFunc: () => _share(context),
            aboutFunc: () => _navigateToAboutPage(),
          );
        });
  }

  void _sendEmail(String email) async {
    var url = "mailto:$email";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Email couldn't sent";
    }
  }

  void _share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    const url = '$COMPANY_URL#projects';
    Share.share(url,
        subject: "Latest COVID Tracker App : ",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
