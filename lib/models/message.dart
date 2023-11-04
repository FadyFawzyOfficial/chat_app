import 'dart:convert';

class Message {
  final String message;
  final String email;
  final DateTime date;

  Message({
    required this.message,
    required this.email,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'email': email,
      'date': date,
    };
  }

  factory Message.fromMap(map) {
    return Message(
      message: map['message'],
      email: map['email'],
      date: map['date'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
