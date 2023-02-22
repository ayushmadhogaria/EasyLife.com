import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String phone;
  final String address;
  final String token;
  final List<dynamic> wishlist;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.phone,
    required this.address,
    required this.token,
    required this.wishlist,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'phone': phone,
      'address': address,
      'token': token,
      'wishlist': wishlist,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      token: map['token'] ?? '',
      wishlist: List<Map<String, dynamic>>.from(
        map['wishlist']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? type,
    String? phone,
    String? address,
    String? token,
    List<dynamic>? wishlist,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      token: token ?? this.token,
      wishlist: wishlist ?? this.wishlist,
    );
  }
}
