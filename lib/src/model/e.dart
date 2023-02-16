// class e {
// final String? success;
// final List<Data>? data;
// const e({this.success , this.data });
// e copyWith({String? success, List<Data>? data}){
// return e(
//             success:success ?? this.success,
// data:data ?? this.data
//         );
//         }
        
// Map<String,Object?> toJson(){
//     return {
//             'success': success,
// 'data': data?.map<Map<String,dynamic>>((data)=> data.toJson()).toList()
//     };
// }

// static e fromJson(Map<String , Object?> json){
//     return e(
//             success:json['success'] == null ? null : json['success'] as String,
// data:json['data'] == null ? null : (json['data'] as List).map<Data>((data)=> Data.fromJson(data  as Map<String,Object?>)).toList()
//     );
// }

// @override
// String toString(){
//     return '''e(
//                 success:$success,
// data:${data.toString()}
//     ) ''';
// }

// @override
// bool operator ==(Object other){
//     return other is e && 
//         other.runtimeType == runtimeType &&
//         other.success == success && 
// other.data == data;
// }
      
// @override
// int get hashCode {
//     return Object.hash(
//                 runtimeType,
//                 success, 
// data
//     );
// }
    
// }
      
      
// class Data {
// final String? id;
// final String? fullName;
// final String? avatar;
// const Data({this.id , this.fullName , this.avatar });
// Data copyWith({String? id, String? fullName, String? avatar}){
// return Data(
//             id:id ?? this.id,
// fullName:fullName ?? this.fullName,
// avatar:avatar ?? this.avatar
//         );
//         }
        
// Map<String,Object?> toJson(){
//     return {
//             'id': id,
// 'fullName': fullName,
// 'avatar': avatar
//     };
// }

// static Data fromJson(Map<String , Object?> json){
//     return Data(
//             id:json['id'] == null ? null : json['id'] as String,
// fullName:json['fullName'] == null ? null : json['fullName'] as String,
// avatar:json['avatar'] == null ? null : json['avatar'] as String
//     );
// }

// @override
// String toString(){
//     return '''Data(
//                 id:$id,
// fullName:$fullName,
// avatar:$avatar
//     ) ''';
// }

// @override
// bool operator ==(Object other){
//     return other is Data && 
//         other.runtimeType == runtimeType &&
//         other.id == id && 
// other.fullName == fullName && 
// other.avatar == avatar;
// }
      
// @override
// int get hashCode {
//     return Object.hash(
//                 runtimeType,
//                 id, 
// fullName, 
// avatar
//     );
// }
    
// }
      
      
  
     