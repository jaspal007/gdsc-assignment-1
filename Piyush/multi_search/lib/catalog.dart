class Person {
  final String name;
  final String date;
  final String school;

  Person(this.name, this.date, this.school);

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      json['Name'],
      json['Date Of Joining'],
      json['School'],
    );
  }
}
