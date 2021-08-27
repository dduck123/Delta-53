import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference payslip =
      FirebaseFirestore.instance.collection('Employees');

  Future getUserPayslip() async {
    List itemsList = [];

    try {
      await payslip.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
