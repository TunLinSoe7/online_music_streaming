import 'package:json_annotation/json_annotation.dart';
import 'song_vo.dart';
part 'play_list_vo.g.dart';

@JsonSerializable()
class PlaylistVO {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'playlist_name')
  String? playlistName;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'songs')
  List<SongVO>? songs;

  PlaylistVO({this.id,this.playlistName,this.createdAt,this.songs});

  factory PlaylistVO.fromJson(Map<String, dynamic> json) => _$PlaylistVOFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistVOToJson(this);
}
