
import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String textBtn;
  final Function() onPressed;
  const BotonAzul ({ 
    Key? key,
    required this.textBtn,
    required this.onPressed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ButtonStyle styleButton = ElevatedButton.styleFrom(
      elevation: 2,
      onPrimary: Colors.white,
      primary: Colors.blue,
      shape: const StadiumBorder(),

    );
    return ElevatedButton(
      style: styleButton,
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: Center(
        child:  Text(textBtn , style: const TextStyle(color: Colors.white, fontSize: 17,))
        )
      )
    );
  }
}