import 'package:flutter/material.dart';
import 'package:flutter_app/models/student.dart';
import 'package:flutter_app/validation/student_validator.dart';

// ignore: must_be_immutable
class StudentAdd extends StatefulWidget {
  List<Student> students;

  StudentAdd(List<Student> students) {
    this.students = students;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State<StudentAdd> with StudentValidationMixin {
  List<Student> students;
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();

  _StudentAddState(List<Student> students) {
    this.students = students;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            title: Text("Yeni Öğrenci Ekle"),
            backgroundColor: Color(0xFF780029)),
        body: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(5),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                buildFirstNameField(),
                buildLasttNameField(),
                buildGradeNameField(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı:", hintText: "Burak"),
      validator: validateFirstName,
      onSaved: (String value) {
        student.firstName = value;
      },
    );
  }

  Widget buildLasttNameField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı:", hintText: "KALAYCI"),
      validator: validateLastName,
      onSaved: (String value) {
        student.lastName = value;
      },
    );
  }

  Widget buildGradeNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Aldığı Not:", hintText: "90"),
      validator: validateGrade,
      onSaved: (String value) {
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    // ignore: deprecated_member_use
    return RaisedButton(
      color: Color(0xFF780029),
      textColor: Colors.white,
      child: Text("Kaydet"),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          widget.students.add(student);
          Navigator.pop(context);
        }
      },
    );
  }
}
