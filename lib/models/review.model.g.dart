// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return ReviewModel(
    comment: json['comment'] as String,
    stars: json['stars'] as int,
  );
}

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'stars': instance.stars,
    };
