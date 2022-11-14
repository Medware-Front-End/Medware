import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medware/utils/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:medware/utils/models/appointment/employee_appointment.dart';
import 'package:medware/utils/api/appointment/get_employee_appointments.dart';
import 'package:medware/screens/main/event/employee/patient_choosed.dart';

//import 'package:medware/utils/api/event/patient/get_schedule_employee.dart';
//import 'package:medware/utils/models/event/patient/employee_event.dart';

LinkedHashMap<DateTime, List<EmployeeAppointment>>? _groupedEvents;

class AppointmentDoctorCreate extends StatefulWidget {
  const AppointmentDoctorCreate({
    Key? key,
  }) : super(key: key);

  @override
  AppointmentDoctorCreateState createState() => AppointmentDoctorCreateState();
}

class AppointmentDoctorCreateState extends State<AppointmentDoctorCreate> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  var events;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> _getEventsForDay(DateTime date) {
    return _groupedEvents?[date] ?? [];
  }

  Future _loadAppointments() async {
    events = await getEmployeeAppointments();
    _groupEvent(events);
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month + 10002 + key.year;
  }

  _groupEvent(List<EmployeeAppointment> events) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      DateTime date =
          DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      if (_groupedEvents![date] == null) {
        _groupedEvents![date] = [];
      }
      _groupedEvents![date]!.add(event);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  bool _checkEventEnrollable(dynamic dayEvent) {
    for (int i = 0; i < dayEvent.length; i++) {
      if (dayEvent[i].capacity > dayEvent[i].patientCount) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fullDateFormatter = DateFormat.yMMMMEEEEd();
    final timeFormatter = DateFormat.jm();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 30, 0, 0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        '<   กลับ',
                        style: TextStyle(
                            fontFamily: 'NotoSansThai',
                            color: primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(100, 30, 0, 0),
                    child: Text(
                      'การทำนัดหมาย',
                      style: TextStyle(
                          fontFamily: 'NotoSansThai',
                          color: secondaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.fromLTRB(size.width * 0.045,
                          size.height * 0.003, size.width * 0.045, 0),
                      child: SizedBox(
                        height: size.height * 0.44,
                        width: size.width,
                        child: TableCalendar(
                          calendarBuilders: CalendarBuilders(
                            selectedBuilder: ((context, _datetime, focusedDay) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    size.width * 0.005,
                                    size.height * 0.005,
                                    size.width * 0.005,
                                    size.height * 0.005),
                                decoration: BoxDecoration(
                                    color: tertiaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.02)),
                                child: Center(
                                    child: Text(
                                  _datetime.day.toString(),
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                )),
                              );
                            }),
                            todayBuilder: (context, _datetime, focusedDay) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    size.width * 0.005,
                                    size.height * 0.005,
                                    size.width * 0.005,
                                    size.height * 0.005),
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.02)),
                                child: Center(
                                    child: Text(
                                  _datetime.day.toString(),
                                  style: TextStyle(
                                      color: Color(0xFFEEF2E6),
                                      fontWeight: FontWeight.w500),
                                )),
                              );
                            },
                            markerBuilder: (context, day, events) {
                              if (events.isNotEmpty) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 2.0,
                                      child: Container(
                                        height: 10.0,
                                        width: 10.0,
                                        decoration: BoxDecoration(
                                          color: _checkEventEnrollable(events)
                                              ? primaryColor
                                              : Color(0xFFFF0000),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return null;
                              }
                            },
                          ),
                          shouldFillViewport: true,
                          firstDay: DateTime(1990),
                          lastDay: DateTime(2050),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(color: primaryColor),
                              weekendStyle: TextStyle(color: tertiaryColor)),
                          calendarStyle: CalendarStyle(
                              selectedTextStyle: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500),
                              weekendTextStyle: TextStyle(color: tertiaryColor),
                              defaultTextStyle: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500)),
                          headerStyle: HeaderStyle(
                            leftChevronIcon: Icon(
                              Icons.arrow_back_ios,
                              color: primaryColor,
                              size: size.width * 0.05,
                            ),
                            rightChevronIcon: Icon(
                              Icons.arrow_forward_ios,
                              color: primaryColor,
                              size: size.width * 0.05,
                            ),
                            titleTextStyle: TextStyle(
                                color: primaryColor,
                                fontSize: size.width * 0.05),
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextFormatter: (date, locale) =>
                                DateFormat.MMMM(locale).format(date),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) async {
                            if (!isSameDay(_selectedDay, selectedDay)) {
                              setState(() {
                                _selectedDay = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                        ),
                      )),
                      SizedBox(
                        height: size.height*0.038,
                        ),
                        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(size.height * 0.03)),
            child: Container(
                width: size.width * 0.88,
                height: size.height * 0.31,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Color.fromARGB(106, 28, 103, 88),
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height * 0.03))),
                child: ScrollConfiguration(
                  behavior: CustomScroll(),
                  child: !_getEventsForDay(_selectedDay as DateTime).isEmpty
                      ? Scrollbar(
                        child: ListView(
                            shrinkWrap: false,
                            itemExtent: size.height * 0.102,
                            children: [
                              ..._getEventsForDay(_selectedDay as DateTime)
                                  .map((event) => ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(size.height * 0.04)),
                                        child: Card(
                                            shadowColor: Colors.transparent,
                                            margin: EdgeInsets.all(
                                                size.height * 0.003),
                                            color: quaternaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  size.height * 0.03),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                               
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PatientChoosed(
                                                            id: event.id,
                                                              date: event.date,
                                                            startTime:
                                                                event.startTime,
                                                            finishTime: event
                                                                .finishTime,
                                                             ),
                                                    ),
                                                  );
                                                
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    size.width * 0.02,
                                                    size.width * 0.015,
                                                    size.width * 0.02,
                                                    size.width * 0.015),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: event.type ==
                                                                0
                                                            ? Color(0xFF4CC9FF)
                                                            : Color(0xFFFF0000),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                          size.width * 0.03,
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.all(
                                                          size.width * 0.025),
                                                      child: Icon(
                                                        event.type == 1
                                                            ? Icons
                                                                .medical_services_outlined
                                                            : Icons
                                                                .water_drop_outlined,
                                                        size: size.width * 0.09,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width * 0.04,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        event.type == 0
                                                        ?
                                                        Text(
                                                          'ตรวจสุขภาพ',
                                                          style: TextStyle(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                        )
                                                        :
                                                        Text(
                                                          'ตรวจเลือด',
                                                          style: TextStyle(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                size.height *
                                                                    0.02,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${fullDateFormatter.format(event.date)}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    size.height *
                                                                        0.0145,
                                                                color:
                                                                    primaryColor,
                                                              ),
                                                            ),
                                                            Text(
                                                                'เวลา ${timeFormatter.format(event.startTime)} - ${timeFormatter.format(event.finishTime)}',
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.0145,
                                                                  color:
                                                                      primaryColor,
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0,
                                                              size.height * 0.045,
                                                              size.width * 0.03,
                                                              0),
                                                      child: Text(
                                                          '${event.patientCount} / ${event.capacity}',
                                                          style: TextStyle(
                                                            fontSize: size.width *
                                                                0.032,
                                                            color: event.patientCount >=
                                                                    event.capacity
                                                                ? Color(
                                                                    0xFFFF0000)
                                                                : primaryColor,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ))
                            ],
                          ),
                      )
                      : Center(
                          child: Text(
                          'ไม่มีนัดหมายที่ท่านสามารถทำการจองได้',
                          style: TextStyle(
                              fontSize: size.width * 0.05, color: primaryColor),
                        )),
                )),
          )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}