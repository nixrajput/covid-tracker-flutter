class StateWiseData {
  final List<StatesDaily> statesDaily;

  StateWiseData({
    required this.statesDaily,
  });

  factory StateWiseData.fromJson(Map<String, dynamic> json) => StateWiseData(
        statesDaily: List<StatesDaily>.from(
            json["states_daily"].map((x) => StatesDaily.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "states_daily": List<dynamic>.from(statesDaily.map((x) => x.toJson())),
      };
}

class StatesDaily {
  final String? an;
  final String? ap;
  final String? ar;
  final String? statesDailyAs;
  final String? br;
  final String? ch;
  final String? ct;
  final String? date;
  final DateTime? dateymd;
  final String? dd;
  final String? dl;
  final String? dn;
  final String? ga;
  final String? gj;
  final String? hp;
  final String? hr;
  final String? jh;
  final String? jk;
  final String? ka;
  final String? kl;
  final String? la;
  final String? ld;
  final String? mh;
  final String? ml;
  final String? mn;
  final String? mp;
  final String? mz;
  final String? nl;
  final String? or;
  final String? pb;
  final String? py;
  final String? rj;
  final String? sk;
  final String? status;
  final String? tg;
  final String? tn;
  final String? tr;
  final String? tt;
  final String? un;
  final String? up;
  final String? ut;
  final String? wb;

  StatesDaily({
    this.an,
    this.ap,
    this.ar,
    this.statesDailyAs,
    this.br,
    this.ch,
    this.ct,
    this.date,
    this.dateymd,
    this.dd,
    this.dl,
    this.dn,
    this.ga,
    this.gj,
    this.hp,
    this.hr,
    this.jh,
    this.jk,
    this.ka,
    this.kl,
    this.la,
    this.ld,
    this.mh,
    this.ml,
    this.mn,
    this.mp,
    this.mz,
    this.nl,
    this.or,
    this.pb,
    this.py,
    this.rj,
    this.sk,
    this.status,
    this.tg,
    this.tn,
    this.tr,
    this.tt,
    this.un,
    this.up,
    this.ut,
    this.wb,
  });

  factory StatesDaily.fromJson(Map<String, dynamic> json) => StatesDaily(
        an: json["an"],
        ap: json["ap"],
        ar: json["ar"],
        statesDailyAs: json["as"],
        br: json["br"],
        ch: json["ch"],
        ct: json["ct"],
        date: json["date"],
        dateymd: DateTime.parse(json["dateymd"]),
        dd: json["dd"],
        dl: json["dl"],
        dn: json["dn"],
        ga: json["ga"],
        gj: json["gj"],
        hp: json["hp"],
        hr: json["hr"],
        jh: json["jh"],
        jk: json["jk"],
        ka: json["ka"],
        kl: json["kl"],
        la: json["la"],
        ld: json["ld"],
        mh: json["mh"],
        ml: json["ml"],
        mn: json["mn"],
        mp: json["mp"],
        mz: json["mz"],
        nl: json["nl"],
        or: json["or"],
        pb: json["pb"],
        py: json["py"],
        rj: json["rj"],
        sk: json["sk"],
        status: json["status"],
        tg: json["tg"],
        tn: json["tn"],
        tr: json["tr"],
        tt: json["tt"],
        un: json["un"],
        up: json["up"],
        ut: json["ut"],
        wb: json["wb"],
      );

  Map<String, dynamic> toJson() => {
        "an": an,
        "ap": ap,
        "ar": ar,
        "as": statesDailyAs,
        "br": br,
        "ch": ch,
        "ct": ct,
        "date": date,
        "dateymd":
            "${dateymd!.year.toString().padLeft(4, '0')}-${dateymd!.month.toString().padLeft(2, '0')}-${dateymd!.day.toString().padLeft(2, '0')}",
        "dd": dd,
        "dl": dl,
        "dn": dn,
        "ga": ga,
        "gj": gj,
        "hp": hp,
        "hr": hr,
        "jh": jh,
        "jk": jk,
        "ka": ka,
        "kl": kl,
        "la": la,
        "ld": ld,
        "mh": mh,
        "ml": ml,
        "mn": mn,
        "mp": mp,
        "mz": mz,
        "nl": nl,
        "or": or,
        "pb": pb,
        "py": py,
        "rj": rj,
        "sk": sk,
        "status": status,
        "tg": tg,
        "tn": tn,
        "tr": tr,
        "tt": tt,
        "un": un,
        "up": up,
        "ut": ut,
        "wb": wb,
      };
}
