import 'package:flutter/material.dart';
import 'package:medware/components/text_field.dart';
import 'package:medware/utils/colors.dart';

class ChangeMail extends StatelessWidget {
  const ChangeMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChangeMailForm();
  }
}

class ChangeMailForm extends StatefulWidget {
  const ChangeMailForm({super.key});

  @override
  State<ChangeMailForm> createState() => _ChangeMailState();
}

class _ChangeMailState extends State<ChangeMailForm> {
  TextEditingController _changeNewMail = TextEditingController();
  TextEditingController _changeNewMailPw = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _changeNewMail.dispose();
    _changeNewMailPw.dispose();
    super.dispose();
  }

  String? get _errorNewMail {
    final text = _changeNewMail.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดใส่ข้อมูล';
    }
    return null;
  }

  String? get _errorNewMailPw {
    final text = _changeNewMailPw.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดใส่ข้อมูล';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text.rich(TextSpan(
                              style: TextStyle(
                                fontSize: 27,
                              ),
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 17,
                                      fontFamily: 'NotoSansThai'),
                                  text: "<   กลับ",
                                ),
                              ])),
                          padding: EdgeInsets.fromLTRB(40.0, 50.0, 0.0, 0.0),
                        ),
                        Container(
                          child: Text(
                            'เปลี่ยนอีเมลล์',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'NotoSansThai',
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                          padding: EdgeInsets.fromLTRB(130.0, 50.0, 0.0, 0.0),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  ),
                  Container(
                      child: Column(children: <Widget>[
                        Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('อีเมลล์ใหม่',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: primaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                            padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                            margin: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 0.0)),
                        Container(
                            child: CustomTextField(
                              controller: _changeNewMail,
                              validator: _errorNewMail,
                              obscureText: false,
                            ),
                            padding: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 0.0),
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0)),
                      ]),
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.all(10.0)),
                  Container(
                      child: Column(children: <Widget>[
                        Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('รหัสผ่าน',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: primaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                            margin: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 0.0)),
                        Container(
                            child: CustomTextField(
                              controller: _changeNewMailPw,
                              validator: _errorNewMailPw,
                              obscureText: false,
                            ),
                            padding: EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 30.0),
                            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0)),
                      ]),
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.all(10.0)),
                  Container(
                      child: Column(children: <Widget>[
                        Container(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(7.0),
                                textStyle: const TextStyle(fontSize: 20),
                                backgroundColor: quaternaryColor),
                            onPressed: () {
                              setState(() {
                                _changeNewMail.text.isEmpty ||
                                        _changeNewMailPw.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                              });
                            },
                            child: Text(
                              'ยืนยัน',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontFamily: 'NotoSansThai'),
                            ),
                          ),
                        )
                      ]),
                      padding: EdgeInsets.fromLTRB(250.0, 250.0, 0.0, 0.0),
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0)),
                ],
              ))
            ]),
          ],
        ));
  }
}
