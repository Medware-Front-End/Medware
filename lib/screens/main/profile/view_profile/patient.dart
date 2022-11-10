import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medware/components/action_button.dart';
import 'package:medware/components/cancel_button.dart';
import 'package:medware/screens/main/profile/edit_profile/change_password.dart';
import 'package:medware/screens/main/profile/view_profile/components/body/detail.dart';
import 'package:medware/screens/main/profile/view_profile/components/body/detailedList.dart';
import 'package:medware/screens/main/profile/view_profile/components/header/header.dart';
import 'package:medware/screens/main/profile/view_profile/components/body/label.dart';
import 'package:medware/utils/api/user/get_patient_by_id.dart';
import 'package:medware/utils/colors.dart';
import 'package:medware/utils/models/user/patient.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Patient patient = Patient(
    id: 'XXXXXXX',
    nationalId: 'XXXXXXXXXXXXX',
    fName: 'F',
    mName: 'M',
    lName: 'L',
    phoneNumber: 'XXXXXXXXXX',
    bloodType: 0,
    profilePic: 0,
    medicalConditions: [],
    drugAllergies: [],
    allergies: [],
  );

  Future _loadPatient() async {
    var temp = await getPatientById();
    setState(() => patient = temp);
  }

  @override
  void initState() {
    super.initState();
    _loadPatient();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadPatient,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        backgroundColor: quaternaryColor,
        color: primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            children: [
              Header(
                role: 1,
                path: SharedPreference.profilePictures[patient.profilePic],
                refresh: _loadPatient,
              ),
              Container(
                width: size.width * 0.85,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * 0.03,
                      ),
                      child: Label(
                        fName: patient.fName,
                        mName: patient.mName,
                        lName: patient.lName,
                        role: 'ผู้ป่วย',
                      ),
                    ),
                    Detail(
                      title: 'หมายเลขประจำตัวบัตรประชาชน',
                      detail: patient.nationalId,
                      icon: Icons.badge_outlined,
                    ),
                    Detail(
                      title: 'เลขที่ประจําตัวผู้ป่วยนอก',
                      detail: patient.id,
                      icon: Icons.medical_information_outlined,
                    ),
                    Detail(
                      title: 'หมู่เลือด',
                      detail: SharedPreference.bloodTypes[patient.bloodType],
                      icon: Icons.bloodtype_outlined,
                    ),
                    Detail(
                      title: 'เบอร์โทรศัพท์',
                      detail: patient.phoneNumber,
                      icon: Icons.phone_rounded,
                    ),
                    DetailedList(
                      title: 'โรคประจำตัว',
                      details: patient.medicalConditions,
                      icon: Icons.coronavirus_outlined,
                    ),
                    DetailedList(
                      title: 'การแพ้ยา',
                      details: patient.drugAllergies,
                      icon: Icons.vaccines_outlined,
                    ),
                    DetailedList(
                      title: 'ภูมิแพ้',
                      details: patient.allergies,
                      icon: Icons.sick_outlined,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.width * 0.075,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ActionButton(
                            text: 'เปลี่ยนรหัสผ่าน',
                            action: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChangePassword(),
                              ),
                            ),
                            percentWidth: 35,
                          ),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          CancelButton(
                            text: 'ออกจากระบบ',
                            action: () {
                              HapticFeedback.lightImpact();
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('คุณแน่ใจหรือไม่?'),
                                  content: const Text(
                                      'คุณแน่ใจที่จะออกจากระบบหรือไม่?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('ไม่'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('ใช่'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            percentWidth: 35,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}