import 'package:covid_tracker/models/covid_data.dart';
import 'package:covid_tracker/models/state_wise_data.dart';

class DataModel {
  CovidData covidData;
  StateWiseData stateWiseData;

  DataModel({
    required this.covidData,
    required this.stateWiseData,
  });
}
