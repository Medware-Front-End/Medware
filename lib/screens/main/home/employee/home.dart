import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
import 'package:medware/components/notification_bell.dart';
import 'package:medware/screens/main/event/employee/view_appointment.dart';
import 'package:medware/utils/api/appointment/get_employee_appointments.dart';
import 'package:medware/utils/models/appointment/employee_appointment.dart';
import 'package:medware/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String name = 'ชนน';
  List<EmployeeAppointment> appointments = getEmployeeAppointments();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shortenedDateFormatter = DateFormat.MMMEd();
    final fullDateFormatter = DateFormat.yMMMMEEEEd();
    final timeFormatter = DateFormat.jm();

    final validAppointments =
        appointments.where((i) => i.startTime.isAfter(DateTime.now())).toList();
    validAppointments.sort((a, b) => a.startTime.compareTo(b.startTime));
    final sortedValidAppointments = groupBy(
      validAppointments,
      (EmployeeAppointment ea) => ea.date,
    );

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 140),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [tertiaryColor, quaternaryColor],
                  center: Alignment.topRight,
                  radius: size.width * 0.0025,
                  focal: Alignment.topRight,
                  focalRadius: size.width * 0.0007,
                ),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                    size.height * 0.3,
                    size.height * 0.06,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: AppBar(
                      elevation: 0,
                      title: Text(
                        'สวัสดี!\nคุณ $name',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 40,
                          height: 1,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      toolbarHeight: size.height * 0.2,
                      backgroundColor: Colors.transparent,
                      actions: [
                        NotificationBell(
                          backgroundColor: quaternaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: size.width * 0.06,
                        right: size.width * 0.4,
                        top: size.width * 0.055,
                      ),
                      width: size.width * 0.9,
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.75,
                            blurRadius: 2,
                            offset: const Offset(5, 5),
                          ),
                        ],
                        gradient: RadialGradient(
                          colors: [primaryColor, secondaryColor],
                          center: Alignment.topLeft,
                          radius: size.width * 0.0025,
                          focal: Alignment.topLeft,
                          focalRadius: size.width * 0.0007,
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(
                          Radius.circular(size.width * 0.07),
                        ),
                      ),
                      child: Text(
                        'อย่าลืมดื่มน้ำให้ครบ\nอย่างน้อย 2 ลิตร\nต่อวันนะ :)',
                        style: TextStyle(
                            color: quaternaryColor,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Positioned(
                      bottom: size.width * -0.03,
                      right: size.width * -0.04,
                      child: Image.asset(
                        'assets/images/drink-water.png',
                        height: size.height * 0.18,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    left: size.width * 0.095,
                    top: size.height * 0.05,
                  ),
                  child: Text(
                    'นัดหมายของคุณ',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.only(bottom: size.height * 0.05),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sortedValidAppointments.length,
                  itemBuilder: (context, i) {
                    final keys = sortedValidAppointments.keys.toList();
                    final appointmentList = sortedValidAppointments[keys[i]];

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.015,
                          ),
                          child: Container(
                            width: size.width * 0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: quaternaryColor,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.1),
                            ),
                            child: Text(
                              shortenedDateFormatter
                                  .formatInBuddhistCalendarThai(keys[i]),
                              style: TextStyle(
                                  color: tertiaryColor,
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: appointmentList!.length,
                          itemBuilder: (context, j) {
                            final appointment = appointmentList[j];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                                vertical: size.width * 0.02,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: quaternaryColor,
                                  borderRadius: BorderRadius.circular(
                                    size.width * 0.05,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewAppointment(
                                          appointment: appointment),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    size.width * 0.05,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(size.width * 0.04),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: appointment.type == 0
                                                ? Colors.blue[200]
                                                : Colors.red[400],
                                            borderRadius: BorderRadius.circular(
                                              size.width * 0.03,
                                            ),
                                          ),
                                          padding:
                                              EdgeInsets.all(size.width * 0.05),
                                          child: Icon(
                                            appointment.type == 0
                                                ? Icons
                                                    .medical_services_outlined
                                                : Icons.water_drop_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.04,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              EmployeeAppointment
                                                  .typeList[appointment.type],
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              '${fullDateFormatter.formatInBuddhistCalendarThai(appointment.date)}\nเวลา ${timeFormatter.format(appointment.startTime)} - ${timeFormatter.format(appointment.finishTime)}',
                                              style: TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07,
                    vertical: size.width * 0.05,
                  ),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    gradient: RadialGradient(
                      colors: [quaternaryColor, tertiaryColor],
                      center: Alignment.bottomLeft,
                      radius: size.width * 0.003,
                      focal: Alignment.bottomLeft,
                      focalRadius: size.width * 0.0005,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(size.width * 0.07),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ติดต่อโรงพยาบาล',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: size.width * 0.09,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '02-XXX-XXXX',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'โรงพยาบาล Medware ถ.ถนน ต.ตำบล อ.อำเภอ จ.จังหวัด 00000',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}