import 'package:json_annotation/json_annotation.dart';
part 'song_vo.g.dart';

@JsonSerializable()
class SongVO{
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'artist')
  String? artist;
  @JsonKey(name: 'duration')
  double? duration;
  @JsonKey(name: 'fileUrl')
  String? fileUrl;
  @JsonKey(name: 'coverUrl')
  String? coverUrl;

  SongVO({this.id,this.title,this.artist,this.duration,this.fileUrl,this.coverUrl});
  factory SongVO.fromJson(Map<String,dynamic> json)=>_$SongVOFromJson(json);
  Map<String,dynamic> toJson()=>_$SongVOToJson(this);

}