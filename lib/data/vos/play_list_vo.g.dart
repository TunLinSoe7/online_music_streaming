// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistVO _$PlaylistVOFromJson(Map<String, dynamic> json) => PlaylistVO(
      id: json['id'] as String?,
      playlistName: json['playlist_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => SongVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistVOToJson(PlaylistVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playlist_name': instance.playlistName,
      'created_at': instance.createdAt?.toIso8601String(),
      'songs': instance.songs,
    };
