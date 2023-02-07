import 'employee_and_note_model.dart';

class NoteByEmployeeModel {
final List<Notes>? notes;
const NoteByEmployeeModel({this.notes });
NoteByEmployeeModel copyWith({List<Notes>? notes}){
return NoteByEmployeeModel(
            notes:notes ?? this.notes
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'notes': notes?.map<Map<String,dynamic>>((data)=> data.toJson()).toList()
    };
}

static NoteByEmployeeModel fromJson(Map<String , Object?> json){
    return NoteByEmployeeModel(
            notes:json['notes'] == null ? null : (json['notes'] as List).map<Notes>((data)=> Notes.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''NoteByEmployeeModel(
                notes:${notes.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is NoteByEmployeeModel && 
        other.runtimeType == runtimeType &&
        other.notes == notes;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                notes
    );
}
    
}
      
      
// class Notes {
// final String? id;
// final String? title;
// final String? text;
// final String? createdAt;
// final String? updatedAt;
// const Notes({this.id , this.title , this.text , this.createdAt , this.updatedAt });
// Notes copyWith({String? id, String? title, String? text, String? createdAt, String? updatedAt}){
// return Notes(
//             id:id ?? this.id,
// title:title ?? this.title,
// text:text ?? this.text,
// createdAt:createdAt ?? this.createdAt,
// updatedAt:updatedAt ?? this.updatedAt
//         );
//         }
        
// Map<String,Object?> toJson(){
//     return {
//             'id': id,
// 'title': title,
// 'text': text,
// 'createdAt': createdAt,
// 'updatedAt': updatedAt
//     };
// }

// static Notes fromJson(Map<String , Object?> json){
//     return Notes(
//             id:json['id'] == null ? null : json['id'] as String,
// title:json['title'] == null ? null : json['title'] as String,
// text:json['text'] == null ? null : json['text'] as String,
// createdAt:json['created_at'] == null ? null : json['created_at'] as String,
// updatedAt:json['updated_at'] == null ? null : json['updated_at'] as String
//     );
// }

// @override
// String toString(){
//     return '''Notes(
//                 id:$id,
// title:$title,
// text:$text,
// createdAt:$createdAt,
// updatedAt:$updatedAt
//     ) ''';
// }

// @override
// bool operator ==(Object other){
//     return other is Notes && 
//         other.runtimeType == runtimeType &&
//         other.id == id && 
// other.title == title && 
// other.text == text && 
// other.createdAt == createdAt && 
// other.updatedAt == updatedAt;
// }
      
// @override
// int get hashCode {
//     return Object.hash(
//                 runtimeType,
//                 id, 
// title, 
// text, 
// createdAt, 
// updatedAt
//     );
// }
    
// }
      
      
  
     