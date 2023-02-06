class NoteDetailModel {
final String? id;
final String? user;
final String? title;
final String? text;
final String? createdAt;
final String? updatedAt;
final List<Replies>? replies;
const NoteDetailModel({this.id , this.user , this.title , this.text , this.createdAt , this.updatedAt , this.replies });
NoteDetailModel copyWith({String? id, String? user, String? title, String? text, String? createdAt, String? updatedAt, List<Replies>? replies}){
return NoteDetailModel(
            id:id ?? this.id,
user:user ?? this.user,
title:title ?? this.title,
text:text ?? this.text,
createdAt:createdAt ?? this.createdAt,
updatedAt:updatedAt ?? this.updatedAt,
replies:replies ?? this.replies
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'id': id,
'user': user,
'title': title,
'text': text,
'createdAt': createdAt,
'updatedAt': updatedAt,
'replies': replies?.map<Map<String,dynamic>>((data)=> data.toJson()).toList()
    };
}

static NoteDetailModel fromJson(Map<String , Object?> json){
    return NoteDetailModel(
            id:json['id'] == null ? null : json['id'] as String,
user:json['user'] == null ? null : json['user'] as String,
title:json['title'] == null ? null : json['title'] as String,
text:json['text'] == null ? null : json['text'] as String,
createdAt:json['created_at'] == null ? null : json['created_at'] as String,
updatedAt:json['updated_at'] == null ? null : json['updated_at'] as String,
replies:json['replies'] == null ? null : (json['replies'] as List).map<Replies>((data)=> Replies.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''NoteDetailModel(
                id:$id,
user:$user,
title:$title,
text:$text,
createdAt:$createdAt,
updatedAt:$updatedAt,
replies:${replies.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is NoteDetailModel && 
        other.runtimeType == runtimeType &&
        other.id == id && 
other.user == user && 
other.title == title && 
other.text == text && 
other.createdAt == createdAt && 
other.updatedAt == updatedAt && 
other.replies == replies;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                id, 
user, 
title, 
text, 
createdAt, 
updatedAt, 
replies
    );
}
    
}
      
      
class Replies {
final String? id;
final String? user;
final String? text;
const Replies({this.id , this.user , this.text });
Replies copyWith({String? id, String? user, String? text}){
return Replies(
            id:id ?? this.id,
user:user ?? this.user,
text:text ?? this.text
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'id': id,
'user': user,
'text': text
    };
}

static Replies fromJson(Map<String , Object?> json){
    return Replies(
            id:json['id'] == null ? null : json['id'] as String,
user:json['user'] == null ? null : json['user'] as String,
text:json['text'] == null ? null : json['text'] as String
    );
}

@override
String toString(){
    return '''Replies(
                id:$id,
user:$user,
text:$text
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Replies && 
        other.runtimeType == runtimeType &&
        other.id == id && 
other.user == user && 
other.text == text;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                id, 
user, 
text
    );
}
    
}
      
      
  
     