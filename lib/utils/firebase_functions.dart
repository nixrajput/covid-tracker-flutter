import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_tracker/constants/strings.dart';

class FirebaseFunctions {
  static final firestore = FirebaseFirestore.instance;
  static final appInfoCollection = firestore.collection(APP_INFO_REF);

  static Future<DocumentSnapshot> getAppInfo() async {
    DocumentSnapshot appInfoSnapshot =
        await appInfoCollection.doc(APP_INFO).get();
    return appInfoSnapshot ?? null;
  }
}
