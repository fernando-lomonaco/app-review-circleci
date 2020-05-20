// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReviewStore on _ReviewStore, Store {
  Computed<int> _$numberOfReviewsComputed;

  @override
  int get numberOfReviews =>
      (_$numberOfReviewsComputed ??= Computed<int>(() => super.numberOfReviews,
              name: '_ReviewStore.numberOfReviews'))
          .value;

  final _$reviewsAtom = Atom(name: '_ReviewStore.reviews');

  @override
  ObservableList<ReviewModel> get reviews {
    _$reviewsAtom.reportRead();
    return super.reviews;
  }

  @override
  set reviews(ObservableList<ReviewModel> value) {
    _$reviewsAtom.reportWrite(value, super.reviews, () {
      super.reviews = value;
    });
  }

  final _$averageStarsAtom = Atom(name: '_ReviewStore.averageStars');

  @override
  double get averageStars {
    _$averageStarsAtom.reportRead();
    return super.averageStars;
  }

  @override
  set averageStars(double value) {
    _$averageStarsAtom.reportWrite(value, super.averageStars, () {
      super.averageStars = value;
    });
  }

  final _$initReviewsAsyncAction = AsyncAction('_ReviewStore.initReviews');

  @override
  Future<void> initReviews() {
    return _$initReviewsAsyncAction.run(() => super.initReviews());
  }

  final _$_ReviewStoreActionController = ActionController(name: '_ReviewStore');

  @override
  void addReview(ReviewModel newReview) {
    final _$actionInfo = _$_ReviewStoreActionController.startAction(
        name: '_ReviewStore.addReview');
    try {
      return super.addReview(newReview);
    } finally {
      _$_ReviewStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
reviews: $reviews,
averageStars: $averageStars,
numberOfReviews: $numberOfReviews
    ''';
  }
}
