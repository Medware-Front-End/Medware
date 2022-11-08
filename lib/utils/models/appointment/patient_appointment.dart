class PatientAppointment {
  final int id;
  final int type;
  final DateTime date;
  final DateTime startTime;
  final DateTime finishTime;
  final String doctor;
  final String department;
  static List<String> typeList = ['ตรวจร่างกาย', 'บริจาคเลือด'];

  const PatientAppointment({
    required this.id,
    required this.type,
    required this.date,
    required this.startTime,
    required this.finishTime,
    required this.doctor,
    required this.department,
  });

  static PatientAppointment fromJson(json) => PatientAppointment(
        id: int.parse(json['id']),
        type: int.parse(json['type']),
        date: DateTime.parse(json['date']),
        startTime: DateTime.parse(json['startTime']),
        finishTime: DateTime.parse(json['finishTime']),
        doctor: json['doctorName'],
        department: json['department'],
      );
}
