import 'package:flutter/material.dart';

class ToastDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  Widget _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 24.0),
          margin: EdgeInsets.only(top: 66.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Alerta!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff292929),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Está seguro de remover essa avaliação?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff292929),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                height: 56,
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  elevation: 0.0,
                  child: Text(
                    "Confirmar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    side: BorderSide(
                      color: Colors.blue[400],
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 56,
                width: double.infinity,
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[690],
                    ),
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  highlightedBorderColor: Colors.transparent,
                  borderSide: BorderSide(color: Colors.transparent),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
