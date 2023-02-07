// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';




class NotificationModel {
  String? id;
  String? noteId;
  Sender? sender;
  bool? isRead;
  String? timestamp;
  NotificationModel({
    this.id,
    this.noteId,
    this.sender,
    this.isRead,
    this.timestamp,
  });

  NotificationModel copyWith({
    String? id,
    String? noteId,
    Sender? sender,
    bool? isRead,
    String? timestamp,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      noteId: noteId ?? this.noteId,
      sender: sender ?? this.sender,
      isRead: isRead ?? this.isRead,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'note_id': noteId,
      'sender': sender?.toMap(),
      'is_read': isRead,
      'timestamp': timestamp,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] != null ? map['id'] as String : null,
      noteId: map['note_id'] != null ? map['note_id'] as String : null,
      sender: map['sender'] != null ? Sender.fromMap(map['sender'] as Map<String,dynamic>) : null,
      isRead: map['is_read'] != null ? map['is_read'] as bool : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, note_id: $noteId, sender: $sender, is_read: $isRead, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.noteId == noteId &&
      other.sender == sender &&
      other.isRead == isRead &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      noteId.hashCode ^
      sender.hashCode ^
      isRead.hashCode ^
      timestamp.hashCode;
  }
}

class Sender {
  String? name;
  bool? isEmployer;
  Sender({
    this.name,
    this.isEmployer,
  });

  Sender copyWith({
    String? name,
    bool? isEmployer,
  }) {
    return Sender(
      name: name ?? this.name,
      isEmployer: isEmployer ?? this.isEmployer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'is_employer': isEmployer,
    };
  }

  factory Sender.fromMap(Map<String, dynamic> map) {
    return Sender(
      name: map['name'] != null ? map['name'] as String : null,
      isEmployer:
          map['is_employer'] != null ? map['is_employer'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sender.fromJson(String source) =>
      Sender.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Sender(name: $name, is_employer: $isEmployer)';

  @override
  bool operator ==(covariant Sender other) {
    if (identical(this, other)) return true;

    return other.name == name && other.isEmployer == isEmployer;
  }

  @override
  int get hashCode => name.hashCode ^ isEmployer.hashCode;
}
