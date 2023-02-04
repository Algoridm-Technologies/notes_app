class FacilityModel {
final List<Facilities>? facilities;
const FacilityModel({this.facilities });
FacilityModel copyWith({List<Facilities>? facilities}){
return FacilityModel(
            facilities:facilities ?? this.facilities
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'facilities': facilities?.map<Map<String,dynamic>>((data)=> data.toJson()).toList()
    };
}

static FacilityModel fromJson(Map<String , Object?> json){
    return FacilityModel(
            facilities:json['facilities'] == null ? null : (json['facilities'] as List).map<Facilities>((data)=> Facilities.fromJson(data  as Map<String,Object?>)).toList()
    );
}

@override
String toString(){
    return '''FacilityModel(
                facilities:${facilities.toString()}
    ) ''';
}

@override
bool operator ==(Object other){
    return other is FacilityModel && 
        other.runtimeType == runtimeType &&
        other.facilities == facilities;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                facilities
    );
}
    
}
      
      
class Facilities {
final String? id;
final String? title;
final String? location;
final String? image;
const Facilities({this.id , this.title , this.location , this.image });
Facilities copyWith({String? id, String? title, String? location, String? image}){
return Facilities(
            id:id ?? this.id,
title:title ?? this.title,
location:location ?? this.location,
image:image ?? this.image
        );
        }
        
Map<String,Object?> toJson(){
    return {
            'id': id,
'title': title,
'location': location,
'image': image
    };
}

static Facilities fromJson(Map<String , Object?> json){
    return Facilities(
            id:json['id'] == null ? null : json['id'] as String,
title:json['title'] == null ? null : json['title'] as String,
location:json['location'] == null ? null : json['location'] as String,
image:json['image'] == null ? null : json['image'] as String
    );
}

@override
String toString(){
    return '''Facilities(
                id:$id,
title:$title,
location:$location,
image:$image
    ) ''';
}

@override
bool operator ==(Object other){
    return other is Facilities && 
        other.runtimeType == runtimeType &&
        other.id == id && 
other.title == title && 
other.location == location && 
other.image == image;
}
      
@override
int get hashCode {
    return Object.hash(
                runtimeType,
                id, 
title, 
location, 
image
    );
}
    
}
      
      
  
     