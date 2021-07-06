part of 'helpers.dart';

void calculatingAlert(BuildContext context) {

  if (Platform.isAndroid) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Wait please'),
        content: Text('Calculating route...'),
      )
    );
  } else {
    showCupertinoDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Text('Wait please'),
        content: CupertinoActivityIndicator(),
      )
    );
  }

}