import 'package:flutter/material.dart';

push(BuildContext context, Widget view) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
}

pushReplacement(context, Widget view) {
  Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute(builder: (context) => view));
}

pushAndRemoveUntil(BuildContext context, Widget view) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => view),
    (route) => false,
  );
}

pop(BuildContext context) {
  Navigator.pop(context);
}
