import 'package:flutter/material.dart';

class Util {
  convertWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return 'Segunda-Feira';
        break;
      case 2:
        return 'Terça-Feira';
        break;
      case 3:
        return 'Quarta-Feira';
        break;
      case 4:
        return 'Quinta-Feira';
        break;
      case 5:
        return 'Sexta-Feira';
        break;
      case 6:
        return 'Sábado';
        break;
      case 7:
        return 'Domingo';
        break;
      default:
    }
  }

  getDecoration(context, label) {
    return InputDecoration(
      fillColor: Color.fromRGBO(48, 56, 62, 0.9),
      filled: true,
      labelStyle: TextStyle(
        color: Theme.of(context).textTheme.subtitle.color,
      ),
      labelText: label,
      border: InputBorder.none,
    );
  }
}
