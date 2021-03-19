class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  String _status;

  Student(int id, String firstName, String lastName, int grade) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.grade = grade;
  }

  Student.withoutInfo();

  String get getStatus {
    String message = "";
    if (this.grade >= 60) {
      message = "Geçti";
    } else if (this.grade >= 40) {
      message = "Bütünlemeye Kaldı!";
    } else {
      message = "Kaldı!";
    }
    return message;
  }
}
