import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exercises_provider.dart';

class ExerciseList extends StatefulWidget {
  final String workoutId;
  final double screenPortion;

  ExerciseList(this.workoutId, this.screenPortion);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  bool _loading = true;
  bool _isInit = true;

  Future<void> _remove(String id) async {
    setState(() {
      _loading = true;
    });

    await Provider.of<ExercisesProvider>(context, listen: false).delete(id);

    setState(() {
      _loading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    print(_isInit);
    if (_isInit) {
      await Provider.of<ExercisesProvider>(context).get(widget.workoutId);
      setState(() {
        _loading = false;
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    print(widget.screenPortion);
    return Stack(
      children: <Widget>[
        // _loading ? Center(child: CircularProgressIndicator()) : null,
        Consumer<ExercisesProvider>(
          builder: (context, provider, _) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInSine,
              height:
                  _loading ? 0 : _mediaQuery.size.height * widget.screenPortion,
              child: ListView.builder(
                itemCount: provider.exercises.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    elevation: 5,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/images/halter.png'),
                          image:
                              NetworkImage(provider.exercises[index].imageUrl),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        // color: Colors.red,
                        onPressed: () => _remove(provider.exercises[index].id),
                      ),
                      title: Text(
                        provider.exercises[index].title,
                        style: TextStyle(
                          // color: Color.fromRGBO(37, 37, 95, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        provider.exercises[index].description,
                        // style: TextStyle(
                        //   color: Color.fromRGBO(205, 205, 218, 1),
                        // ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
