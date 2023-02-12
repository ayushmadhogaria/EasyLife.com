import 'dart:convert';

class Serviceman {
  final String name;
  final String description;
  final double salary;
  final String phone;
  final String shift;
  final String worktime;
  final String category;
  final List<String> images;
  final String? id;
  final String? userId;
  Serviceman({
    required this.name,
    required this.description,
    required this.salary,
    required this.phone,
    required this.shift,
    required this.worktime,
    required this.category,
    required this.images,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'salary': salary,
      'phone': phone,
      'shift': shift,
      'worktime': worktime,
      'category': category,
      'images': images,
      'id': id,
      'userId': userId
    };
  }

  factory Serviceman.fromMap(Map<String, dynamic> map) {
    return Serviceman(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      salary: map['salary']?.toDouble() ?? 0.0,
      phone: map['phone'] ?? '',
      shift: map['shift'] ?? '',
      worktime: map['worktime'] ?? '',
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      id: map['_id'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Serviceman.fromJson(String source) =>
      Serviceman.fromMap(json.decode(source));
}
