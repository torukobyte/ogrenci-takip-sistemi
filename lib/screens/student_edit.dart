import 'package:flutter/material.dart';
import 'package:flutter_app/models/student.dart';
import 'package:flutter_app/validation/student_validator.dart';

// ignore: must_be_immutable
class StudentEdit extends StatefulWidget {
  Student selecetedStudent;

  StudentEdit(Student selecetedStudent) {
    this.selecetedStudent = selecetedStudent;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentEditState(selecetedStudent);
  }
}

class _StudentEditState extends State<StudentEdit> with StudentValidationMixin {
  Student selecetedStudent;
  var formKey = GlobalKey<FormState>();

  _StudentEditState(Student selecetedStudent) {
    this.selecetedStudent = selecetedStudent;
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
      initialValue: selecetedStudent.firstName,
      decoration: InputDecoration(labelText: "Öğrenci Adı:", hintText: "Asya"),
      validator: validateFirstName,
      onSaved: (String value) {
        selecetedStudent.firstName = value;
      },
    );
  }

  Widget buildLasttNameField() {
    return TextFormField(
      initialValue: selecetedStudent.lastName,
      decoration:
          InputDecoration(labelText: "Öğrenci Soyadı:", hintText: "Yılmaz"),
      validator: validateLastName,
      onSaved: (String value) {
        selecetedStudent.lastName = value;
      },
    );
  }

  Widget buildGradeNameField() {
    return TextFormField(
      initialValue: selecetedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Aldığı Not:", hintText: "95"),
      validator: validateGrade,
      onSaved: (String value) {
        selecetedStudent.grade = int.parse(value);
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
          Navigator.pop(context);
        }
      },
    );
  }
}
