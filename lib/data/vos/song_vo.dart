import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'song_vo.g.dart';

@JsonSerializable()
class SongVO {
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

  @JsonKey(name: 'created_at', fromJson: _fromTimestamp, toJson: _toTimestamp)
  DateTime? createdAt;

  SongVO({
    this.id,
    this.title,
    this.artist,
    this.duration,
    this.fileUrl,
    this.coverUrl,
    this.createdAt,
  });

  factory SongVO.fromJson(Map<String, dynamic> json) => _$SongVOFromJson(json);
  Map<String, dynamic> toJson() => _$SongVOToJson(this);

  static DateTime? _fromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _toTimestamp(DateTime? dateTime) =>
      dateTime != null ? Timestamp.fromDate(dateTime) : null;
}
