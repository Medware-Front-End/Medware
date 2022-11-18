import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medware/components/action_button.dart';
import 'package:medware/components/underlined_button.dart';
import 'package:medware/screens/main/event/transfer_patient/transfer_patient.dart';
import 'package:medware/screens/main/event/view_appointment/components/date_time_card.dart';
import 'package:medware/screens/main/event/view_appointment/components/header.dart';
import 'package:medware/utils/api/notification/push_notification.dart';
import 'package:medware/utils/colors.dart';
import 'package:medware/utils/models/appointment/employee_appointment.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';
import 'package:medware/screens/main/postpone/employee/calendar_postpone.dart'
    as postponeEmployee;

import '../delay_appointment/delay_employee_appointment.dart';

class ViewAppointment extends StatelessWidget {
  final EmployeeAppointment appointment;
  const ViewAppointment({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int role = SharedPreference.getUserRole();
    final size = MediaQuery.of(context).size;
    final dateFormatter = DateFormat('d MMMM y');
    final timeFormatter = DateFormat.jm();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Header(role: role, title: appointmentTypes[appointment.type]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: DateTimeCard(
              date: appointment.date,
              startTime: appointment.startTime,
              finishTime: appointment.finishTime,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06,
            ),
            child: Ink(
              width: double.infinity,
              height: size.height * 0.22,
              decoration: BoxDecoration(
                color: quaternaryColor,
                borderRadius: BorderRadius.circular(size.width * 0.05),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(
                  size.width * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.medical_information_outlined,
                      size: size.width * 0.1,
                      color: primaryColor,
                    ),
                    Column(
                      children: [
                        Text(
                          'จำนวนคนไข้',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w300,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                        Text(
                          appointment.patientCount.toString(),
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                        Text(
                          '(กดที่นี่เพื่อดูผู้ป่วยทั้งหมด)',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: size.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(
                    text: 'เลื่อนนัด',
                    action: () {
                      Navigator.push(

                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DelayEmployeeAppointment()));

                    },
                    percentWidth: 30,
                  ),
                  ActionButton(
                    text: 'โอนถ่ายแพทย์',
                    action: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TranferPatient()
                            )
                          );
                    },
                    percentWidth: 30,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              UnderlinedButton(
                text: 'ยกเลิก',
                color: Colors.red,
                action: () {
                  HapticFeedback.lightImpact();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('คุณแน่ใจหรือไม่?'),
                      content:
                          const Text('คุณแน่ใจที่จะยกเลิกนัดหมายนี้หรือไม่?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ไม่'),
                        ),
                        TextButton(
                          onPressed: () {
                            PushNotification.showNotification(
                              title: 'มีการยกเลิกนัดหมายของคุณ',
                              body:
                                  'การนัดหมายการ${appointmentTypes[appointment.type]}ในวันที่ ${dateFormatter.format(appointment.date)} เวลา ${timeFormatter.format(appointment.startTime)} - ${timeFormatter.format(appointment.finishTime)} ถูกยกเลิกแล้ว',
                              payload: 'id number',
                            );
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                    const Text('การนัดหมายนี้ถูกยกเลิกสำเร็จ'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('กลับ'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('ใช่'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 1),
        ],
      ),
    );
  }
}
