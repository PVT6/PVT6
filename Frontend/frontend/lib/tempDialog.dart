import 'package:flutter/material.dart';

class DialogForHistory{

  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      Navigator.pop(context);

    }else{
      Navigator.pop(context);
    }

  }

  delete(BuildContext context, String title) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmResult(false, context),
              child: Text('Close'),
            ),
            FlatButton(
              onPressed: () => _confirmResult(true, context),
              child: Text('Delete'),
            )
          ],
        );
      }

    );

  }

}