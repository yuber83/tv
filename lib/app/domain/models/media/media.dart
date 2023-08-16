import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  factory Media({
    required int id,
    required String overview,

    ///
    @JsonKey(
      readValue: readTitleValue,
    )
    required String title,
    @JsonKey(
      readValue: readOriginalTitleValue,
      name: 'original_title',
    )
    required String originalTitle,
    @JsonKey(name: 'poster_path') required String postPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'media_type') required String type,
  }) = _Media;

  factory Media.fromJson(JsonTypedef json) => _$MediaFromJson(json);
}

Object? readTitleValue(Map map, String _) {
  return map['title'] ?? map['name'];
}

Object? readOriginalTitleValue(Map map, String _) {
  return map['original_title'] ?? map['original_name'];
}
