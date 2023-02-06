class EmployeeNoteModel {
  final List<MyNotes>? myNotes;
  final List<TeamMatesNotes>? teamMatesNotes;
  const EmployeeNoteModel({this.myNotes, this.teamMatesNotes});
  EmployeeNoteModel copyWith(
      {List<MyNotes>? myNotes, List<TeamMatesNotes>? teamMatesNotes}) {
    return EmployeeNoteModel(
        myNotes: myNotes ?? this.myNotes,
        teamMatesNotes: teamMatesNotes ?? this.teamMatesNotes);
  }

  Map<String, Object?> toJson() {
    return {
      'myNotes':
          myNotes?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'teamMatesNotes': teamMatesNotes
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList()
    };
  }

  static EmployeeNoteModel fromJson(Map<String, Object?> json) {
    return EmployeeNoteModel(
        myNotes: json['my_notes'] == null
            ? null
            : (json['my_notes'] as List)
                .map<MyNotes>(
                    (data) => MyNotes.fromJson(data as Map<String, Object?>))
                .toList(),
        teamMatesNotes: json['team_mates_notes'] == null
            ? null
            : (json['team_mates_notes'] as List)
                .map<TeamMatesNotes>((data) =>
                    TeamMatesNotes.fromJson(data as Map<String, Object?>))
                .toList());
  }

  @override
  String toString() {
    return '''EmployeeNoteModel(
                myNotes:${myNotes.toString()},
teamMatesNotes:${teamMatesNotes.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeNoteModel &&
        other.runtimeType == runtimeType &&
        other.myNotes == myNotes &&
        other.teamMatesNotes == teamMatesNotes;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, myNotes, teamMatesNotes);
  }
}

class TeamMatesNotes {
  final String? id;
  final User? user;
  final String? title;
  final String? text;
  final String? createdAt;
  final String? updatedAt;
  const TeamMatesNotes(
      {this.id,
      this.user,
      this.title,
      this.text,
      this.createdAt,
      this.updatedAt});
  TeamMatesNotes copyWith(
      {String? id,
      User? user,
      String? title,
      String? text,
      String? createdAt,
      String? updatedAt}) {
    return TeamMatesNotes(
        id: id ?? this.id,
        user: user ?? this.user,
        title: title ?? this.title,
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'title': title,
      'text': text,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  static TeamMatesNotes fromJson(Map<String, Object?> json) {
    return TeamMatesNotes(
        id: json['id'] == null ? null : json['id'] as String,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, Object?>),
        title: json['title'] == null ? null : json['title'] as String,
        text: json['text'] == null ? null : json['text'] as String,
        createdAt:
            json['created_at'] == null ? null : json['created_at'] as String,
        updatedAt:
            json['updated_at'] == null ? null : json['updated_at'] as String);
  }

  @override
  String toString() {
    return '''TeamMatesNotes(
                id:$id,
user:${user.toString()},
title:$title,
text:$text,
createdAt:$createdAt,
updatedAt:$updatedAt
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is TeamMatesNotes &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.user == user &&
        other.title == title &&
        other.text == text &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType, id, user, title, text, createdAt, updatedAt);
  }
}

class User {
  final String? fullName;
  final String? avatar;
  const User({this.fullName, this.avatar});
  User copyWith({String? fullName, String? avatar}) {
    return User(
        fullName: fullName ?? this.fullName, avatar: avatar ?? this.avatar);
  }

  Map<String, Object?> toJson() {
    return {'fullName': fullName, 'avatar': avatar};
  }

  static User fromJson(Map<String, Object?> json) {
    return User(
        fullName:
            json['full_name'] == null ? null : json['full_name'] as String,
        avatar: json['avatar'] == null ? null : json['avatar'] as String);
  }

  @override
  String toString() {
    return '''User(
                fullName:$fullName,
avatar:$avatar
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is User &&
        other.runtimeType == runtimeType &&
        other.fullName == fullName &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, fullName, avatar);
  }
}

class MyNotes {
  final String? id;
  final String? title;
  final String? text;
  final String? createdAt;
  final String? updatedAt;
  const MyNotes(
      {this.id, this.title, this.text, this.createdAt, this.updatedAt});
  MyNotes copyWith(
      {String? id,
      String? title,
      String? text,
      String? createdAt,
      String? updatedAt}) {
    return MyNotes(
        id: id ?? this.id,
        title: title ?? this.title,
        text: text ?? this.text,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  static MyNotes fromJson(Map<String, Object?> json) {
    return MyNotes(
        id: json['id'] == null ? null : json['id'] as String,
        title: json['title'] == null ? null : json['title'] as String,
        text: json['text'] == null ? null : json['text'] as String,
        createdAt:
            json['created_at'] == null ? null : json['created_at'] as String,
        updatedAt:
            json['updated_at'] == null ? null : json['updated_at'] as String);
  }

  @override
  String toString() {
    return '''MyNotes(
                id:$id,
title:$title,
text:$text,
createdAt:$createdAt,
updatedAt:$updatedAt
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is MyNotes &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.title == title &&
        other.text == text &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, title, text, createdAt, updatedAt);
  }
}
