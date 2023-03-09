import 'dart:convert';
import 'package:easylifeapp/models/serviceman.dart';

class Appointment {
  final String id;
  final List<Serviceman> servicemans;
  final List<int> duration;
  final String address;
  final String userId;
  final String appointDate;
  final String appointTime;
  final int requestedAt;
  final int status;
  final double totalAmount;

  Appointment({
    required this.id,
    required this.servicemans,
    required this.duration,
    required this.address,
    required this.userId,
    required this.requestedAt,
    required this.appointDate,
    required this.appointTime,
    required this.status,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'servicemans': servicemans.map((x) => x.toMap()).toList(),
      'duration': duration,
      'address': address,
      'userId': userId,
      'requestedAt': requestedAt,
      'status': status,
      'appointDate': appointDate,
      'appointTime': appointTime,
      'totalAmount': totalAmount,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['_id'] ?? '',
      servicemans: List<Serviceman>.from(
          map['servicemans']?.map((x) => Serviceman.fromMap(x['serviceman']))),
      duration: List<int>.from(
        map['servicemans']?.map(
          (x) => x['duration'],
        ),
      ),
      address: map['address'] ?? '',
      appointDate: map['appointDate'] ?? '',
      appointTime: map['appointTime'] ?? '',
      userId: map['userId'] ?? '',
      requestedAt: map['requestedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));
}
