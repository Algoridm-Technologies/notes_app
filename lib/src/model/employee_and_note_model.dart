class EmployeeAndNoteModel {
final List<Employees>? employees;
final List<Notes>? notes;
const EmployeeAndNoteModel({this.employees , this.notes });
EmployeeAndNoteModel copyWith({List<Employees>? employees, List<Notes>? notes}){
return EmployeeAndNoteModel(
            employees:employees ?? this.employees,
notes:notes ?? this.notes
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'employees': employees?.map<Map<String,dynamic>>((data)=> data.toJson()).toList(),
'notes': notes?.map<Map<String,dynamic>>((data)=> data.toJson()).toList()
    };
}

static EmployeeAndNoteModel fromJson(Map<String , Object?> json){
    return EmployeeAndNoteModel(
            employees:json['employees'] == null ? null : (json['employees'] as List).map<Employees>((data)=> Employees.fromJson(data  as Map<String,Object?>)).toList(),
notes:json['notes'] == null ? null : (json['notes'] as List).map<Notes>((data)=> Notes.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''EmployeeAndNoteModel(
                employees:${employees.toString()},
notes:${notes.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is EmployeeAndNoteModel && 
        other.runtimeType == runtimeType &&
        other.employees == employees && 
other.notes == notes;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                employees, 
notes
    );
}
    
}
      
      
class Notes {
final String? id;
final User? user;
final String? title;
final String? text;
final String? updatedAt;
const Notes({this.id , this.user , this.title , this.text , this.updatedAt });
Notes copyWith({String? id, User? user, String? title, String? text, String? updatedAt}){
return Notes(
            id:id ?? this.id,
user:user ?? this.user,
title:title ?? this.title,
text:text ?? this.text,
updatedAt:updatedAt ?? this.updatedAt
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'id': id,
'user': user?.toJson(),
'title': title,
'text': text,
'updatedAt': updatedAt
    };
}

static Notes fromJson(Map<String , Object?> json){
    return Notes(
            id:json['id'] == null ? null : json['id'] as String,
user:json['user'] == null ? null : User.fromJson(json['user']  as Map<String,Object?>),
title:json['title'] == null ? null : json['title'] as String,
text:json['text'] == null ? null : json['text'] as String,
updatedAt:json['updated_at'] == null ? null : json['updated_at'] as String
    );
}

@override
String toString(){
    return '''Notes(
                id:$id,
user:${user.toString()},
title:$title,
text:$text,
updatedAt:$updatedAt
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Notes && 
        other.runtimeType == runtimeType &&
        other.id == id && 
other.user == user && 
other.title == title && 
other.text == text && 
other.updatedAt == updatedAt;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                id, 
user, 
title, 
text, 
updatedAt
    );
}
    
}
      
      
class User {
final String? fullName;
final String? avatar;
const User({this.fullName , this.avatar });
User copyWith({String? fullName, String? avatar}){
return User(
            fullName:fullName ?? this.fullName,
avatar:avatar ?? this.avatar
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'fullName': fullName,
'avatar': avatar
    };
}

static User fromJson(Map<String , Object?> json){
    return User(
            fullName:json['full_name'] == null ? null : json['full_name'] as String,
avatar:json['avatar'] == null ? null : json['avatar'] as String
    );
}

@override
String toString(){
    return '''User(
                fullName:$fullName,
avatar:$avatar
    ) ''';
}

@override
bool operator ==(Object other){
    return other is User && 
        other.runtimeType == runtimeType &&
        other.fullName == fullName && 
other.avatar == avatar;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                fullName, 
avatar
    );
}
    
}
      
      
class Employees {
final String? id;
final String? fullName;
final String? avatar;
const Employees({this.id , this.fullName , this.avatar });
Employees copyWith({String? id, String? fullName, String? avatar}){
return Employees(
            id:id ?? this.id,
fullName:fullName ?? this.fullName,
avatar:avatar ?? this.avatar
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'id': id,
'fullName': fullName,
'avatar': avatar
    };
}

static Employees fromJson(Map<String , Object?> json){
    return Employees(
            id:json['id'] == null ? null : json['id'] as String,
fullName:json['full_name'] == null ? null : json['full_name'] as String,
avatar:json['avatar'] == null ? null : json['avatar'] as String
    );
}

@override
String toString(){
    return '''Employees(
                id:$id,
fullName:$fullName,
avatar:$avatar
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Employees && 
        other.runtimeType == runtimeType &&
        other.id == id && 
other.fullName == fullName && 
other.avatar == avatar;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                id, 
fullName, 
avatar
    );
}
    
}
      
      
  
     