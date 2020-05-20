import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_circleci/models/review.model.dart';
import 'package:mobx_circleci/screens/review.dart';
import 'package:mobx_circleci/stores/review.store.dart';
import 'package:mobx_circleci/widgets/info_card.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final ReviewStore _reviewStore = ReviewStore();

  final List<int> _stars = [1, 2, 3, 4, 5];
  final TextEditingController _commentController = TextEditingController();
  int _selectedStar;

  @override
  void initState() {
    _selectedStar = null;
    _reviewStore.initReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("App de Avaliações"),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        splashColor: Colors.red,
        backgroundColor: Colors.purple,
        onPressed: () {},
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.6,
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: "Escreva uma avaliação",
                      labelText: "Avaliação",
                    ),
                  ),
                ),
                Container(
                  child: DropdownButton(
                    hint: Text("Estrelas"),
                    elevation: 0,
                    value: _selectedStar,
                    items: _stars.map((star) {
                      return DropdownMenuItem<int>(
                        child: Text(star.toString()),
                        value: star,
                      );
                    }).toList(),
                    onChanged: (item) {
                      setState(() {
                        _selectedStar = item;
                      });
                    },
                  ),
                ),
                Container(
                  child: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Icon(
                          Icons.done,
                          size: 25.0,
                          color: Colors.green[900],
                        ),
                        onPressed: () {
                          if (_selectedStar == null) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.orangeAccent[100],
                              content: Text(
                                "Adicione as estrelas para a avaliação",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87
                                ),
                              ),
                              duration: Duration(milliseconds: 1300),
                            ));
                          } else if (_commentController.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Avaliação não pode ser vazia"),
                              duration: Duration(milliseconds: 1000),
                            ));
                          } else {
                            _reviewStore.addReview(ReviewModel(
                              comment: _commentController.text,
                              stars: _selectedStar,
                            ));
                            _commentController.text = "";
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            //contains average stars and total reviews card
            Observer(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InfoCard(
                      infoValue: _reviewStore.numberOfReviews > 0
                          ? _reviewStore.numberOfReviews.toString()
                          : "",
                      infoLabel: _reviewStore.numberOfReviews == 0
                          ? "aguardando novas avalições"
                          : _reviewStore.numberOfReviews == 1
                              ? "avaliação"
                              : "avaliações",
                      cardColor: Colors.green,
                      iconData: Icons.comment,
                    ),
                    InfoCard(
                      infoValue: _reviewStore.averageStars.isInfinite ||
                              _reviewStore.averageStars.isNaN
                          ? ""
                          : _reviewStore.averageStars.toStringAsFixed(2),
                      infoLabel: _reviewStore.averageStars.isInfinite
                          ? ""
                          : "média de avaliações",
                      cardColor: Colors.lightBlue,
                      iconData: Icons.star,
                      key: Key(
                        'avgStar',
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 24.0),
            //the review menu label
            Container(
              color: Colors.purple[600],
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Avaliações",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            //contains list of reviews
            Expanded(
              child: Container(
                child: Observer(
                    builder: (_) => _reviewStore.reviews.isNotEmpty
                        ? ListView(
                            children:
                                _reviewStore.reviews.reversed.map((reviewItem) {
                              return ReviewWidget(
                                reviewStore: _reviewStore,
                                reviewItem: reviewItem,
                              );
                            }).toList(),
                          )
                        : Text("Nenhuma avaliação ainda")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
