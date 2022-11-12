import 'package:medware/utils/models/user/patient.dart';

Future<Patient> getPatientById() async {
  const data = {
    'hnId': '234564',
    'nationalId': '0987654321098',
    'fName': 'ชื่อของ',
    'mName': '',
    'lName': 'คนไข้จ้า',
    'phoneNumber': '0987654321',
    'password':'12345678',
    'birthDate':'2001-01-22T00:00:00',
    'bloodType': '1',
    'pic': '1',
    'medicalConditions': 'โรคหอบหืด,โรคหัวใจ',
    'drugAllergies': 'พาราเซตามอล',
    'allergies': 'ภูมิแพ้ฝุ่นละออง,ภูมิแพ้อาหารทะเล',
  };

  return Patient.fromJson(data);
}
