// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrentFacilityModel {
  String? facilityName;
  String? facilityId;
  CurrentFacilityModel({
    this.facilityName,
    this.facilityId,
  });

  CurrentFacilityModel copyWith({
    String? facilityName,
    String? facilityId,
  }) {
    return CurrentFacilityModel(
      facilityName: facilityName ?? this.facilityName,
      facilityId: facilityId ?? this.facilityId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'facilityName': facilityName,
      'facilityId': facilityId,
    };
  }

  factory CurrentFacilityModel.fromMap(Map<String, dynamic> map) {
    return CurrentFacilityModel(
      facilityName: map['facilityName'] != null ? map['facilityName'] as String : null,
      facilityId: map['facilityId'] != null ? map['facilityId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentFacilityModel.fromJson(String source) => CurrentFacilityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CurrentFacilityModel(facilityName: $facilityName, facilityId: $facilityId)';

  @override
  bool operator ==(covariant CurrentFacilityModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.facilityName == facilityName &&
      other.facilityId == facilityId;
  }

  @override
  int get hashCode => facilityName.hashCode ^ facilityId.hashCode;
}
