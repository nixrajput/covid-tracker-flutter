class CovidData {
  final List<CasesTimeSeries> casesTimeSeries;
  final List<Statewise> statewise;
  final List<Tested> tested;

  CovidData({
    required this.casesTimeSeries,
    required this.statewise,
    required this.tested,
  });

  factory CovidData.fromJson(Map<String, dynamic> json) => CovidData(
        casesTimeSeries: List<CasesTimeSeries>.from(
            json["cases_time_series"].map((x) => CasesTimeSeries.fromJson(x))),
        statewise: List<Statewise>.from(
            json["statewise"].map((x) => Statewise.fromJson(x))),
        tested:
            List<Tested>.from(json["tested"].map((x) => Tested.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cases_time_series":
            List<dynamic>.from(casesTimeSeries.map((x) => x.toJson())),
        "statewise": List<dynamic>.from(statewise.map((x) => x.toJson())),
        "tested": List<dynamic>.from(tested.map((x) => x.toJson())),
      };
}

class CasesTimeSeries {
  final String? dailyconfirmed;
  final String? dailydeceased;
  final String? dailyrecovered;
  final String? date;
  final DateTime? dateymd;
  final String? totalconfirmed;
  final String? totaldeceased;
  final String? totalrecovered;

  CasesTimeSeries({
    this.dailyconfirmed,
    this.dailydeceased,
    this.dailyrecovered,
    this.date,
    this.dateymd,
    this.totalconfirmed,
    this.totaldeceased,
    this.totalrecovered,
  });

  factory CasesTimeSeries.fromJson(Map<String, dynamic> json) =>
      CasesTimeSeries(
        dailyconfirmed: json["dailyconfirmed"],
        dailydeceased: json["dailydeceased"],
        dailyrecovered: json["dailyrecovered"],
        date: json["date"],
        dateymd: DateTime.parse(json["dateymd"]),
        totalconfirmed: json["totalconfirmed"],
        totaldeceased: json["totaldeceased"],
        totalrecovered: json["totalrecovered"],
      );

  Map<String, dynamic> toJson() => {
        "dailyconfirmed": dailyconfirmed,
        "dailydeceased": dailydeceased,
        "dailyrecovered": dailyrecovered,
        "date": date,
        "dateymd":
            "${dateymd!.year.toString().padLeft(4, '0')}-${dateymd!.month.toString().padLeft(2, '0')}-${dateymd!.day.toString().padLeft(2, '0')}",
        "totalconfirmed": totalconfirmed,
        "totaldeceased": totaldeceased,
        "totalrecovered": totalrecovered,
      };
}

class Statewise implements Comparable {
  final String? active;
  final String? confirmed;
  final String? deaths;
  final String? deltaconfirmed;
  final String? deltadeaths;
  final String? deltarecovered;
  final String? lastupdatedtime;
  final String? migratedother;
  final String? recovered;
  final String? state;
  final String? statecode;
  final String? statenotes;

  Statewise({
    this.active,
    this.confirmed,
    this.deaths,
    this.deltaconfirmed,
    this.deltadeaths,
    this.deltarecovered,
    this.lastupdatedtime,
    this.migratedother,
    this.recovered,
    this.state,
    this.statecode,
    this.statenotes,
  });

  factory Statewise.fromJson(Map<String, dynamic> json) => Statewise(
        active: json["active"],
        confirmed: json["confirmed"],
        deaths: json["deaths"],
        deltaconfirmed: json["deltaconfirmed"],
        deltadeaths: json["deltadeaths"],
        deltarecovered: json["deltarecovered"],
        lastupdatedtime: json["lastupdatedtime"],
        migratedother: json["migratedother"],
        recovered: json["recovered"],
        state: json["state"],
        statecode: json["statecode"],
        statenotes: json["statenotes"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "confirmed": confirmed,
        "deaths": deaths,
        "deltaconfirmed": deltaconfirmed,
        "deltadeaths": deltadeaths,
        "deltarecovered": deltarecovered,
        "lastupdatedtime": lastupdatedtime,
        "migratedother": migratedother,
        "recovered": recovered,
        "state": state,
        "statecode": statecode,
        "statenotes": statenotes,
      };

  @override
  int compareTo(other) {
    if (int.parse(this.confirmed!) < int.parse(other.confirmed)) {
      return 1;
    }
    if (int.parse(this.confirmed!) > int.parse(other.confirmed)) {
      return -1;
    }
    if (int.parse(this.confirmed!) == int.parse(other.confirmed)) {
      return 0;
    }
    return 0;
  }
}

class Tested {
  final String? aefi;
  final String? dailyrtpcrsamplescollectedicmrapplication;
  final String? firstdoseadministered;
  final String? frontlineworkersvaccinated1Stdose;
  final String? frontlineworkersvaccinated2Nddose;
  final String? healthcareworkersvaccinated1Stdose;
  final String? healthcareworkersvaccinated2Nddose;
  final String? lp;
  final String? over45Years1Stdose;
  final String? over45Years2Nddose;
  final String? over60Years1Stdose;
  final String? over60Years2Nddose;
  final String? positivecasesfromsamplesreported;
  final String? registrationflwhcw;
  final String? registrationonline;
  final String? registrationonspot;
  final String? samplereportedtoday;
  final String? seconddoseadministered;
  final String? source;
  final String? source2;
  final String? source3;
  final String? source4;
  final String? testedasof;
  final String? testsconductedbyprivatelabs;
  final String? to60YearswithcoMorbidities1Stdose;
  final String? to60YearswithcoMorbidities2Nddose;
  final String? totaldosesadministered;
  final String? totalindividualstested;
  final String? totalindividualsvaccinated;
  final String? totalpositivecases;
  final String? totalrtpcrsamplescollectedicmrapplication;
  final String? totalsamplestested;
  final String? totalsessionsconducted;

  Tested({
    this.aefi,
    this.dailyrtpcrsamplescollectedicmrapplication,
    this.firstdoseadministered,
    this.frontlineworkersvaccinated1Stdose,
    this.frontlineworkersvaccinated2Nddose,
    this.healthcareworkersvaccinated1Stdose,
    this.healthcareworkersvaccinated2Nddose,
    this.lp,
    this.over45Years1Stdose,
    this.over45Years2Nddose,
    this.over60Years1Stdose,
    this.over60Years2Nddose,
    this.positivecasesfromsamplesreported,
    this.registrationflwhcw,
    this.registrationonline,
    this.registrationonspot,
    this.samplereportedtoday,
    this.seconddoseadministered,
    this.source,
    this.source2,
    this.source3,
    this.source4,
    this.testedasof,
    this.testsconductedbyprivatelabs,
    this.to60YearswithcoMorbidities1Stdose,
    this.to60YearswithcoMorbidities2Nddose,
    this.totaldosesadministered,
    this.totalindividualstested,
    this.totalindividualsvaccinated,
    this.totalpositivecases,
    this.totalrtpcrsamplescollectedicmrapplication,
    this.totalsamplestested,
    this.totalsessionsconducted,
  });

  factory Tested.fromJson(Map<String, dynamic> json) => Tested(
        aefi: json["aefi"],
        dailyrtpcrsamplescollectedicmrapplication:
            json["dailyrtpcrsamplescollectedicmrapplication"],
        firstdoseadministered: json["firstdoseadministered"],
        frontlineworkersvaccinated1Stdose:
            json["frontlineworkersvaccinated1stdose"],
        frontlineworkersvaccinated2Nddose:
            json["frontlineworkersvaccinated2nddose"],
        healthcareworkersvaccinated1Stdose:
            json["healthcareworkersvaccinated1stdose"],
        healthcareworkersvaccinated2Nddose:
            json["healthcareworkersvaccinated2nddose"],
        lp: json["lp"],
        over45Years1Stdose: json["over45years1stdose"],
        over45Years2Nddose: json["over45years2nddose"],
        over60Years1Stdose: json["over60years1stdose"],
        over60Years2Nddose: json["over60years2nddose"],
        positivecasesfromsamplesreported:
            json["positivecasesfromsamplesreported"],
        registrationflwhcw: json["registrationflwhcw"],
        registrationonline: json["registrationonline"],
        registrationonspot: json["registrationonspot"],
        samplereportedtoday: json["samplereportedtoday"],
        seconddoseadministered: json["seconddoseadministered"],
        source: json["source"],
        source2: json["source2"],
        source3: json["source3"],
        source4: json["source4"],
        testedasof: json["testedasof"],
        testsconductedbyprivatelabs: json["testsconductedbyprivatelabs"],
        to60YearswithcoMorbidities1Stdose:
            json["to60yearswithco-morbidities1stdose"],
        to60YearswithcoMorbidities2Nddose:
            json["to60yearswithco-morbidities2nddose"],
        totaldosesadministered: json["totaldosesadministered"],
        totalindividualstested: json["totalindividualstested"],
        totalindividualsvaccinated: json["totalindividualsvaccinated"],
        totalpositivecases: json["totalpositivecases"],
        totalrtpcrsamplescollectedicmrapplication:
            json["totalrtpcrsamplescollectedicmrapplication"],
        totalsamplestested: json["totalsamplestested"],
        totalsessionsconducted: json["totalsessionsconducted"],
      );

  Map<String, dynamic> toJson() => {
        "aefi": aefi,
        "dailyrtpcrsamplescollectedicmrapplication":
            dailyrtpcrsamplescollectedicmrapplication,
        "firstdoseadministered": firstdoseadministered,
        "frontlineworkersvaccinated1stdose": frontlineworkersvaccinated1Stdose,
        "frontlineworkersvaccinated2nddose": frontlineworkersvaccinated2Nddose,
        "healthcareworkersvaccinated1stdose":
            healthcareworkersvaccinated1Stdose,
        "healthcareworkersvaccinated2nddose":
            healthcareworkersvaccinated2Nddose,
        "lp": lp,
        "over45years1stdose": over45Years1Stdose,
        "over45years2nddose": over45Years2Nddose,
        "over60years1stdose": over60Years1Stdose,
        "over60years2nddose": over60Years2Nddose,
        "positivecasesfromsamplesreported": positivecasesfromsamplesreported,
        "registrationflwhcw": registrationflwhcw,
        "registrationonline": registrationonline,
        "registrationonspot": registrationonspot,
        "samplereportedtoday": samplereportedtoday,
        "seconddoseadministered": seconddoseadministered,
        "source": source,
        "source2": source2,
        "source3": source3,
        "source4": source4,
        "testedasof": testedasof,
        "testsconductedbyprivatelabs": testsconductedbyprivatelabs,
        "to60yearswithco-morbidities1stdose": to60YearswithcoMorbidities1Stdose,
        "to60yearswithco-morbidities2nddose": to60YearswithcoMorbidities2Nddose,
        "totaldosesadministered": totaldosesadministered,
        "totalindividualstested": totalindividualstested,
        "totalindividualsvaccinated": totalindividualsvaccinated,
        "totalpositivecases": totalpositivecases,
        "totalrtpcrsamplescollectedicmrapplication":
            totalrtpcrsamplescollectedicmrapplication,
        "totalsamplestested": totalsamplestested,
        "totalsessionsconducted": totalsessionsconducted,
      };
}
