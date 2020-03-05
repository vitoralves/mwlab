class Util {
  convertWeekDay(int weekDay) {
    switch (weekDay) {
      case 0:
        return 'Domingo';
        break;
      case 1:
        return 'Segunda-Feira';
        break;
      case 2:
        return 'Terça-Feira';
        break;
      case 3:
        return 'Qaurta-Feira';
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
      default:
    }
  }
}
