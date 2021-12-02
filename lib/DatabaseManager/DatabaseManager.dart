import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {

  final CollectionReference profileList =
      Firestore.instance.collection('profileInfo');

  final CollectionReference userDetails = 
  Firestore.instance.collection('userDetails');

  final CollectionReference vehicleRegistration = 
  Firestore.instance.collection('vehicleRegistration'); 

  final CollectionReference newDriverLicense = 
  Firestore.instance.collection('newDriverLicense');


  Future<void> createUserData(
      String firstname, String surname, String phoneNumber,String email, String uid) async {
    return await profileList
        .document(uid)
        .setData({'firstname': firstname, 'surname': surname, 'phoneNumber': phoneNumber, 'email': email});
  }

  Future<void> vehicleRegistrationData(
      String dateOfPurchase, String engineNumber, String vehicleColour,String vehicleMake, String vehicleType, String yearOfManufacture, 
      String dateOfBirth, String firstName, String middleName, String lastName, String religion, String phoneNumber, String imageUrl,  String uid) async {
    return await vehicleRegistration
        .document(uid)
        .setData({'DateOfPurchase': dateOfPurchase, 'EngineNumber': engineNumber, 'VehicleColour': vehicleColour, 'VehicleMake': vehicleMake, 
        'VehicleType': vehicleType, 'YearOfManufacture': yearOfManufacture,'DateOfBirth': dateOfBirth, 'Firstname': firstName, 'Middlename': middleName,
        'Lastname': lastName, 'Religion': religion, 'PhoneNumber': phoneNumber, 'imageUrl': imageUrl});
  }

  Future<void> newDriverLicenseData(
      String age, String idNumber, String idType, String imageUrl,
      String dateOfBirth,String firstName, String middleName, String lastName, String uid) async {
    return await newDriverLicense
        .document(uid)
        .setData({ 'Age': age, 'IDNumber': idNumber, 
        'IDType': idType, 'DateOfBirth': dateOfBirth, 'firstName': firstName, 'middleName': middleName,
        'lastName': lastName, 'imageUrl': imageUrl,});
  }

   Future<void> renewDriverLicenseData(
      String firstName, String middleName, String lastName,String dateOfBirth, String licenseClass, String imageUrl, 
      String dateOfIssue, String expiryDate, String licenseNumber, String nationality, String referenceNumber,  String uid) async {
    return await userDetails
        .document(uid)
        .setData({ 'firstName': firstName, 'middleName': middleName, 'lastName': lastName,  'dateOfBirth': dateOfBirth, 'licenseClass': licenseClass, 'imageUrl': imageUrl,
        'dateOfIssue': dateOfIssue, 'expiryDate': expiryDate,'licenseNumber': licenseNumber, 'nationality':  nationality, 'referenceNumber': referenceNumber});
  }

  Future<void> renewVehicleLicenseData(
    String vehicleOwner, String carNumber, String expiryDate, String use, String colour, String make, String model, String uid) async {
      return await Firestore.instance.collection("VehicleLicenseDetails").document(uid).setData({
        'vehicleOwner': vehicleOwner, 'carNumber': carNumber, 'expiryDate': expiryDate, 'use': use, 'colour': colour, 'make': make, 'model': model
      });
    } 

  Future<void> newDriverData(
    String firstname, String middlename, String lastname, String dateOfBirth, String idType, String idNumber, String uid) async {
      return await Firestore.instance.collection("newDriverLicenseDetails").document(uid).setData({
        'firstname': firstname, 'middlename': middlename, 'lastname': lastname, 'dateOfBirth': dateOfBirth, 'idType': idType, 'idNumber': idNumber, 
      });
    } 

  // Future updateUserList(String name, String gender, int score, String uid) async {
  //   return await profileList.doc(uid).update({
  //     'name': name, 'gender': gender, 'score': score
  //   });
  // }


  /*Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/
String userid='';
  Future getUsersList() async {
    List itemsList = [];

    try {
      userDetails.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element){

          itemsList.add(element.data);
          //userid = element.documentID;
        });
      }
      
      );
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

/*static Future<QuerySnapshot> searchUsers(String name) async {
    Future<QuerySnapshot> users = usersRef
        .where('name', isGreaterThanOrEqualTo: name)
        .where('name', isLessThan: name + 'z')
        .get();

    return users;
  }*/
}
