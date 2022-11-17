import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:medware/screens/main/event/employee/display_appointment.dart';
import 'package:medware/utils/models/event/getPatientAppointment.dart';
import 'dart:core';
import 'dart:convert';
import 'package:medware/screens/main/event/view_appointment/components/date_time_card.dart';
import 'package:medware/utils/colors.dart';

import 'package:medware/utils/api/appointment/get_employee_appointment_by_id.dart';
import 'package:http/http.dart' as http;

class PatientChoosed extends StatefulWidget {
  final int id;
  final DateTime date;
  final DateTime startTime;
  final DateTime finishTime;

  getId() {
    return id;
  }

  const PatientChoosed(
      {super.key,
      required this.id,
      required this.date,
      required this.startTime,
      required this.finishTime});

  @override
  State<PatientChoosed> createState() => _PatientChoosedState();
}

class _PatientChoosedState extends State<PatientChoosed> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late List<GetPatientAppointment> _getdata;

  

  Future<List<GetPatientAppointment>> getPatientOnSchedule() async {
    var url =
        "https://medcare-database-test.herokuapp.com/appointments/findPatientbyScheduleId/${widget.getId().toString()}";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'authtoken':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJjb2RlcGVuZGEiLCJleHAiOjE2Njg3MDU4MjAsImlhdCI6MTY2ODcwMjgyMCwiYXV0aElkIjoiMTIzNDU2Nzg5MTIzNSJ9.fVXvInCuzThVpPCULuG8QUXD4dczlsFKMWxUr-ySV4k'
    };

    var response = await http.get(Uri.parse(url), headers: requestHeaders);
    if (response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes);
      print(responseString);
      final _getdata = getPatientAppointmentFromJson(responseString);

      return _getdata;
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    getPatientOnSchedule();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            child: RefreshIndicator(
              onRefresh: getPatientOnSchedule,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              backgroundColor: quaternaryColor,
              color: primaryColor,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
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
                      padding: EdgeInsetsDirectional.fromSTEB(130, 30, 0, 0),
                      child: Text(
                        'เลือกคนไข้',
                        style: TextStyle(
                            fontFamily: 'NotoSansThai',
                            color: secondaryColor,
                            fontSize: size.width * 0.07,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          size.width * 0.05,
                          size.width * 0.05,
                          size.width * 0.05,
                          size.width * 0.05),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "ค้นหาคนไข้",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  size.shortestSide * 0.05),
                              borderSide: BorderSide(color: primaryColor),
                            )),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    child: FutureBuilder(
                      future: getPatientOnSchedule(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var result = snapshot.data;
                        
                          return Container(
                            padding: EdgeInsets.fromLTRB(size.width * 0.03, 0,
                                size.width * 0.03, size.width * 0.03),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: result.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(top: size.width * 0.02),
                                    decoration: BoxDecoration(
                                      color: quaternaryColor,
                                      borderRadius: BorderRadius.circular(
                                          size.width * 0.03),
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentDisplay(
                                                    scheduleId: widget.getId(),
                                                    appointmentDate: result[i]
                                                        .appointmentDate,
                                                    appointmentTimeStart: result[
                                                            i]
                                                        .appointmentTimeStart,
                                                    appointmentTimeEnd: result[
                                                            i]
                                                        .appointmentTimeEnd,
                                                    patientFirstName:
                                                        result[i]
                                                            .patientFirstName,
                                                    patientMiddleName:
                                                        result[
                                                                i]
                                                            .patientMiddleName,
                                                    patientLastName: result[i]
                                                        .patientLastName),
                                          ),
                                        );
                                      },
                                      title: Text(
                                          "${result[i].patientFirstName} ${result[i].patientMiddleName} ${result[i].patientLastName}"),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      leading: Icon(
                                          Icons.account_circle_rounded,
                                          size: size.width * 0.08),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return LinearProgressIndicator();
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
