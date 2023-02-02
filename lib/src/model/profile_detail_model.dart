// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileDetailModel {
  String? fullName;
  String? email;
  String? avatar;
  bool? isEmployer;
  String? facility;
  ProfileDetailModel({
    this.fullName,
    this.email,
    this.avatar,
    this.isEmployer,
    this.facility,
  });

  ProfileDetailModel copyWith({
    String? fullName,
    String? email,
    String? avatar,
    bool? isEmployer,
    String? facility,
  }) {
    return ProfileDetailModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      isEmployer: isEmployer ?? this.isEmployer,
      facility: facility ?? this.facility,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'full_name': fullName,
      'email': email,
      'avatar': avatar,
      'is_employer': isEmployer,
      'facility': facility,
    };
  }

  factory ProfileDetailModel.fromMap(Map<String, dynamic> map) {
    return ProfileDetailModel(
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      isEmployer: map['is_employer'] != null ? map['is_employer'] as bool : null,
      facility: map['facility'] != null ? map['facility'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileDetailModel.fromJson(String source) => ProfileDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileDetailModel(full_name: $fullName, email: $email, avatar: $avatar, is_employer: $isEmployer, facility: $facility)';
  }

  @override
  bool operator ==(covariant ProfileDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.fullName == fullName &&
      other.email == email &&
      other.avatar == avatar &&
      other.isEmployer == isEmployer &&
      other.facility == facility;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
      email.hashCode ^
      avatar.hashCode ^
      isEmployer.hashCode ^
      facility.hashCode;
  }
}
