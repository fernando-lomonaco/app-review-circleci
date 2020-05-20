import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx_circleci/src/models/review.model.dart';
import 'package:mobx_circleci/src/stores/review.store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Test MobX state class', () async {
    final ReviewStore _reviewsStore = ReviewStore();

    _reviewsStore.initReviews();

    expect(_reviewsStore.totalStars, 0);

    expect(_reviewsStore.averageStars, 0);
    _reviewsStore.addReview(ReviewModel(
      comment: 'This is a test review',
      stars: 3,
    ));

    expect(_reviewsStore.totalStars, 3);
    _reviewsStore.addReview(ReviewModel(
      comment: 'This is a second test review',
      stars: 5,
    ));

    expect(_reviewsStore.averageStars, 4);
  });
}