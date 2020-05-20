import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:mobx_circleci/src/models/review.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'review.store.g.dart';

class ReviewStore = _ReviewStore with _$ReviewStore;

abstract class _ReviewStore with Store {
  @observable
  ObservableList<ReviewModel> reviews = ObservableList.of([]);

  @observable
  double averageStars = 0;

  // tambem poderia ser declaro como um observable, o computed eh usado pois mudanças
  // em seu valor dependem do resultado de uma ação (estado observável atualizado) em vez de diretamente na ação em si
  @computed
  int get numberOfReviews => reviews.length;

  int totalStars = 0;

  @action
  void addReview(ReviewModel newReview) {
    //to update list of reviews
    reviews.add(newReview);
    // to update the average number of stars
    averageStars = _calculateAverageStars(newReview.stars);
    // to update the total number of stars
    totalStars += newReview.stars;
    // to store the reviews using Shared Preferences
    _persistReview(reviews);
  }

  @action
  void removeReview(ReviewModel review) {
    reviews.remove(review);
    totalStars -= review.stars;
    averageStars = _calculateAverageRemoveStars();
    _persistReview(reviews);
  }

  @action
  Future<void> initReviews() async {
    await _getReviews().then((onValue) {
      reviews = ObservableList.of(onValue);
      for (ReviewModel review in reviews) {
        totalStars += review.stars;
      }
    });
    averageStars = totalStars / reviews.length;
  }

  double _calculateAverageStars(int stars) {
    return (stars + totalStars) / numberOfReviews;
  }

  double _calculateAverageRemoveStars() {
    return totalStars / numberOfReviews;
  }

  void _persistReview(List<ReviewModel> updatedReviews) async {
    List<String> reviewsStringList = [];
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    for (ReviewModel review in updatedReviews) {
      Map<String, dynamic> reviewMap = review.toJson();
      String reviewString = jsonEncode(ReviewModel.fromJson(reviewMap));
      reviewsStringList.add(reviewString);
    }
    _preferences.setStringList('userReviews', reviewsStringList);
  }

  Future<List<ReviewModel>> _getReviews() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    final List<String> reviewsStringList =
        _preferences.getStringList('userReviews') ?? [];
    final List<ReviewModel> retrievedReviews = [];
    for (String reviewString in reviewsStringList) {
      Map<String, dynamic> reviewMap = jsonDecode(reviewString);
      ReviewModel review = ReviewModel.fromJson(reviewMap);
      retrievedReviews.add(review);
    }
    return retrievedReviews;
  }
}
