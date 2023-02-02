// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccessModel {
  int? exp;
  String? userId;
  String? fullName;
  bool? isEmployer;
  String? authProvider;
  AccessModel({
    this.exp,
    this.userId,
    this.fullName,
    this.isEmployer,
    this.authProvider,
  });

  AccessModel copyWith({
    int? exp,
    String? userId,
    String? fullName,
    bool? isEmployer,
    String? authProvider,
  }) {
    return AccessModel(
      exp: exp ?? this.exp,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      isEmployer: isEmployer ?? this.isEmployer,
      authProvider: authProvider ?? this.authProvider,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exp': exp,
      'userId': userId,
      'fullName': fullName,
      'isEmployer': isEmployer,
      'authProvider': authProvider,
    };
  }

  factory AccessModel.fromMap(Map<String, dynamic> map) {
    return AccessModel(
      exp: map['exp'] != null ? map['exp'] as int : null,
      userId: map['user_id'] != null ? map['user_id'] as String : null,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      isEmployer:
          map['is_employer'] != null ? map['is_employer'] as bool : null,
      authProvider:
          map['auth_provider'] != null ? map['auth_provider'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessModel.fromJson(String source) =>
      AccessModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccessModel(exp: $exp, userId: $userId, fullName: $fullName, isEmployer: $isEmployer, authProvider: $authProvider)';
  }

  @override
  bool operator ==(covariant AccessModel other) {
    if (identical(this, other)) return true;

    return other.exp == exp &&
        other.userId == userId &&
        other.fullName == fullName &&
        other.isEmployer == isEmployer &&
        other.authProvider == authProvider;
  }

  @override
  int get hashCode {
    return exp.hashCode ^
        userId.hashCode ^
        fullName.hashCode ^
        isEmployer.hashCode ^
        authProvider.hashCode;
  }
}
