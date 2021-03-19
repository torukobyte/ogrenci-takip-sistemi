import 'package:flutter/material.dart';
import 'package:flutter_app/screens/student_add.dart';
import 'package:flutter_app/screens/student_edit.dart';

import 'models/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = "Öğrenci Takip Sistemi";
  Student selectedStudent = Student(0, "", "", 0);
  List<Student> students = [
    Student(1, "toruko", "byte", 100),
    Student(2, "Asya", "Yılmaz", 50),
    Student(3, "Elif", "Susuz", 20)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(message),
          backgroundColor: Color(0xFF780029),
        ),
        body: buildBody(context));
  }

  void showAlert(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("İşlem Başarılı"),
      titleTextStyle: TextStyle(color: Colors.white),
      contentTextStyle: TextStyle(color: Colors.white),
      content: Text(mesaj),
      backgroundColor: Color(0xFF780029),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int i) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://yt3.ggpht.com/ytc/AAUvwniA9QrrIEm2S00Lk_uSQT5-p8ZU9NRr-t7hdIkjoA=s900-c-k-c0x00ffffff-no-rj"),
                    ),
                    title: Text(
                        students[i].firstName + " " + students[i].lastName),
                    subtitle: Text("Sınavdan aldığı not: " +
                        students[i].grade.toString() +
                        " [" +
                        students[i].getStatus +
                        "]"),
                    trailing: buildStatusIcon(students[i].grade),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[i];
                      });
                      print(selectedStudent.firstName);
                    },
                  );
                })),
        Text("Seçili Öğrenci - " +
            selectedStudent.firstName +
            " " +
            selectedStudent.lastName),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color(0xFF780029),
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), Text("Ekle")],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentAdd(students)),
                  ).then((value) => setState(() {}));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color(0xFF780029),
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.update), Text("Güncelle")],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentEdit(selectedStudent)),
                  ).then((value) => setState(() {}));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color(0xFF780029),
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.delete), Text("Sil")],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);
                  });
                  var msg = selectedStudent.firstName +
                      " " +
                      selectedStudent.lastName +
                      " Başarıyla silindi!";
                  showAlert(context, msg);
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 60) {
      return Icon(Icons.done, color: Color(0xFF780029));
    } else if (grade >= 40) {
      return Icon(Icons.album, color: Color(0xFF780029));
    } else {
      return Icon(Icons.clear, color: Color(0xFF780029));
    }
  }
}
