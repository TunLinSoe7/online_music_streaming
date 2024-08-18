// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongVO _$SongVOFromJson(Map<String, dynamic> json) => SongVO(
      id: json['id'] as String?,
      title: json['title'] as String?,
      artist: json['artist'] as String?,
      duration: (json['duration'] as num?)?.toDouble(),
      fileUrl: json['fileUrl'] as String?,
      coverUrl: json['coverUrl'] as String?,
    );

Map<String, dynamic> _$SongVOToJson(SongVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'duration': instance.duration,
      'fileUrl': instance.fileUrl,
      'coverUrl': instance.coverUrl,
    };
