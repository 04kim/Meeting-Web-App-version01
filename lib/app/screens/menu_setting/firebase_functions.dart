import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> fetchCompanyName(String userEmail) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.get('companyName');
    } else {
      return ''; // Return an empty string if the user is not found
    }
  } catch (e) {
    print("Error fetching company name: $e");
    return '';
  }
}

Stream<String> streamCompanyName(String userEmail) {
  try {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .snapshots()
        .map((docSnapshot) => docSnapshot.get('companyName'));
  } catch (e) {
    print("Error fetching company name: $e");
    return Stream.value(''); // Return an empty stream on error
  }
}

Future<void> updateCompanyName(String userEmail, String newCompanyName) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userEmail).update({
      'companyName': newCompanyName,
    });
  } catch (e) {
    print("Error updating company name: $e");
  }
}

Future<void> saveMonitorCode(String userEmail, String monitorCode) async {
  try {
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    if (userQuerySnapshot.docs.isNotEmpty) {
      final userDocRef = userQuerySnapshot.docs.first.reference;

      await userDocRef.update({
        'monitorCode': monitorCode,
      });
    } else {
      print("User not found with email: $userEmail");
    }
  } catch (e) {
    print("Error saving monitor code: $e");
  }
}
