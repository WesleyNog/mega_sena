import 'package:flutter/material.dart';

Widget BallNumber(String number, {Key? key}) {
  return Container(
    key: key,
    width: 50,
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
    child: Text(
      number,
      style: TextStyle(
        color: Colors.grey.shade600,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}

Widget showNumbers(List<int> numbers) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: numbers.map((number) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Container invisível para manter o espaço
              Container(width: 50, height: 50),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: BallNumber(number.toString(), key: ValueKey(number)),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}
