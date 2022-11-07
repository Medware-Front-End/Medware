import 'package:flutter/material.dart';
import 'package:medware/components/text_field.dart';
import 'package:medware/utils/colors.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterForm> {
  TextEditingController _unameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _cpasswordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _mailTextController = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _unameTextController.dispose();
    _passwordTextController.dispose();
    _cpasswordTextController.dispose();
    _nameTextController.dispose();
    _mailTextController.dispose();
    super.dispose();
  }

  String? get _errorUname {
    final text = _unameTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    if (text.length < 13) {
      return 'สั้นเกินไป';
    }
    return null;
  }

  String? get _errorName {
    final text = _nameTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorPassword {
    final text = _passwordTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorCPassword {
    final text = _cpasswordTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  String? get _errorMail {
    final text = _mailTextController.value.text;

    if (!_validate) {
      return null;
    }
    if (text.isEmpty) {
      return 'โปรดกรอกข้อมูล';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: secondaryColor,
        body: Column(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: primaryColor,
                  borderRadius: new BorderRadius.all(
                    const Radius.circular(15.0),
                  )),
              padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 20.0),
              margin: EdgeInsets.fromLTRB(40.0, 100.0, 40.0, 0.0),
              child: Column(children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Center(
                          child: Text(
                            'สร้างบัญชีผู้ใช้',
                            style: TextStyle(
                                fontSize: 20,
                                color: quaternaryColor,
                                fontFamily: 'NotoSansThai'),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                    ),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('หมายเลขบัตรประชาชน',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _unameTextController,
                              validator: _errorUname,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(5.0)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('ชื่อ - นามสกุล',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _nameTextController,
                              validator: _errorName,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(5.0)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('รหัสผ่าน',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _passwordTextController,
                              validator: _errorPassword,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(5.0)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('ยืนยันรหัสผ่าน',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _cpasswordTextController,
                              validator: _errorCPassword,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(5.0)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('อีเมลล์ ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: quaternaryColor,
                                      fontFamily: 'NotoSansThai')),
                            ),
                          ),
                          Container(
                            child: CustomTextField(
                              controller: _mailTextController,
                              validator: _errorMail,
                            ),
                          ),
                        ]),
                        margin: EdgeInsets.all(5.0)),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(7.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                  backgroundColor: tertiaryColor),
                              onPressed: () {
                                setState(() {
                                  _unameTextController.text.isEmpty ||
                                          _passwordTextController
                                              .text.isEmpty ||
                                          _cpasswordTextController
                                              .text.isEmpty ||
                                          _nameTextController.text.isEmpty ||
                                          _mailTextController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                });
                                // Navigator.pop(context);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Login()),
                                // );
                              },
                              child: Text(
                                'สร้างบัญชี',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: quaternaryColor,
                                    fontFamily: 'NotoSansThai'),
                              ),
                            ),
                          )
                        ]),
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
                  ],
                )
              ]),
            )
          ],
        ));
  }
}
