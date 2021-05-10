import 'package:flutter/material.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/homeworksInfo.dart';
import 'package:etfscanandupload/Model/person.dart';
import 'package:etfscanandupload/View/homework/homeworkInformation.dart';

class HomeworksPage extends StatefulWidget {
  Person _currentPerson;
  HomeworksPage(Person currentPerson) {
    _currentPerson = currentPerson;
  }

  @override
  _HomeworksState createState() => _HomeworksState(_currentPerson);
}

class _HomeworksState extends State<HomeworksPage> {
  HomeworksInfo _homeworks;
  Person _currentPerson;

  _HomeworksState(Object currentPerson) {
    _currentPerson = currentPerson;
  }

  @override
  void initState() {
    super.initState();
    _fetchActiveHomeworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              painter: CurvePainter(),
              child: Container(
                height: 300.0,
              ),
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(100),
                    child: AppBar(
                      backgroundColor: Colors.blue,
                      title: Text("Aktivne zadaće"),
                      centerTitle: true,
                      elevation: 0,
                      leading: TextButton(
                        child: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(child: _buildActiveHomeworks()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchActiveHomeworks() async {
    var response = await Api.getUpcomingHomeworks(_currentPerson.id);
    if (response.statusCode == 200) {
      setState(() {
        _homeworks = HomeworksInfo.fromJson(response.data);
      });
    }
  }

  Widget _buildActiveHomeworks() {
    return _homeworks != null
        ? RefreshIndicator(
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                itemCount: _homeworks.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.white, Colors.blue]),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: _homeworks.results[index].active == true
                              ? Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.hourglass_bottom_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                        ),
                        title: Text(
                          _homeworks.results[index].courseUnit.abbrev,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                children: <Widget>[
                                  Text(
                                    "Naziv: " + _homeworks.results[index].name,
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      "Rok: " +
                                          _homeworks.results[index].deadline,
                                      style: TextStyle(color: Colors.white))
                                ],
                              )
                            ]),
                        trailing: TextButton(
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 30.0),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeworkInfoPage(
                                    _homeworks.results[index].id,
                                    _homeworks.results[index].courseUnit.id,
                                    _homeworks.results[index].nrAssignments,
                                    _currentPerson)));
                          },
                        ),
                      ),
                    ),
                  );
                }),
            onRefresh: () async {
              setState(() {
                _fetchActiveHomeworks();
              });
            },
          )
        : Center(child: CircularProgressIndicator());
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.55);
    path.quadraticBezierTo(
        size.width / 2, 1.5 * size.height, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
