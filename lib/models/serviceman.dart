import 'dart:convert';

import 'package:easylifeapp/models/rating.dart';

class Serviceman {
  final String name;
  final String description;
  final double salary;
  final String phone;
  final String address;
  final String shift;
  final String time;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;

  Serviceman({
    required this.name,
    required this.description,
    required this.salary,
    required this.phone,
    required this.address,
    required this.shift,
    required this.time,
    required this.category,
    required this.images,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'salary': salary,
      'phone': phone,
      'address': address,
      'shift': shift,
      'time': time,
      'category': category,
      'images': images,
      'id': id,
      'rating': rating,
    };
  }

  factory Serviceman.fromMap(Map<String, dynamic> map) {
    return Serviceman(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      salary: map['salary']?.toDouble() ?? 0.0,
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      shift: map['shift'] ?? '',
      time: map['time'] ?? '',
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      id: map['_id'],
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Serviceman.fromJson(String source) =>
      Serviceman.fromMap(json.decode(source));
}
