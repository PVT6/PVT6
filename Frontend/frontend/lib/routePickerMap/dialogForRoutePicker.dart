import 'package:flutter/material.dart';

class DialogForRoutePicker{

  _confirmResult(bool isYes, BuildContext context){
    if(isYes){
      Navigator.pop(context);

    }else{
      Navigator.pop(context);
    }

  }

  confirm(BuildContext context, String title, String description) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _confirmResult(false, context),
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () => _confirmResult(true, context),
              child: Text('Start route'),
            )
          ],
        );
      }

    );

  }

}

