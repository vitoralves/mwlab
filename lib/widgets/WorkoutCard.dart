import 'package:flutter/material.dart';
import './ImageClipper.dart';
import '../utils/Util.dart';

class WorkoutCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  WorkoutCard(this.image, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceWidth = mediaQuery.size.width;
    final util = Util();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
      child: Card(
        color: Color.fromRGBO(60, 70, 72, 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: deviceWidth * 0.4,
              child: ClipPath(
                clipper: ImageClipper(),
                child: Image(
                  image: NetworkImage(image),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Theme.of(context).textTheme.title.fontSize),
                  ),
                  Text(
                    util.convertWeekDay(int.parse(subtitle)),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle.color,
                      fontSize: Theme.of(context).textTheme.subtitle.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
