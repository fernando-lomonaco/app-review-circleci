import 'package:flutter/material.dart';
import 'package:mobx_circleci/src/models/review.model.dart';
import 'package:mobx_circleci/src/stores/review.store.dart';
import 'package:mobx_circleci/src/widgets/toast_dialog.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewItem;
  final ReviewStore reviewStore;

  const ReviewWidget({
    Key key,
    @required this.reviewItem,
    @required this.reviewStore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        itemList(context),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }

  Widget itemList(context) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) => ToastDialog(),
        );
      },
      onDismissed: (direction) {
        reviewStore.removeReview(reviewItem);
        final snackbar = SnackBar(
          duration: Duration(seconds: 5),
          content: Text("Avaliação removida!"),
        );

        Scaffold.of(context).showSnackBar(snackbar);
      },
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                reviewItem.comment,
              ),
            ),
            Row(
              children: List(reviewItem.stars).map(
                (listItem) {
                  return Icon(Icons.star);
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
