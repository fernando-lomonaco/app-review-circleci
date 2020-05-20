import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.model.g.dart';

@JsonSerializable(nullable: true)
class ReviewModel extends Equatable {
  @JsonKey(name: "comment")
  final String comment;
  @JsonKey(name: "stars")
  final int stars;

  ReviewModel({
    @required this.comment,
    @required this.stars,
  });

  @override
  // TODO: implement props
  List<Object> get props => [comment, stars];

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
