import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key key,
    this.id,
    this.isSelected,
    this.onPressed,
    @required this.title,
  }) : super(key: key);
  @override
  final String id;
  final String title;
  final bool isSelected;
  final Function onPressed;
  // final void Function() qChanger;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.white,
            // backgroundColor: Color.fromARGB(86, 155, 39, 176),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        onPressed: () {
          onPressed();
        },
        child: SizedBox(
            child: Text(
          title,
          style: const TextStyle(color: Colors.black,fontSize: 23),
        )));
  }
}
