import 'package:etfscanandupload/Model/course.dart';
import 'package:etfscanandupload/Model/courses.dart';
import 'package:etfscanandupload/View/archive/archivedEvents.dart';
import 'package:etfscanandupload/View/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:etfscanandupload/API/api.dart';
import 'package:etfscanandupload/Model/person.dart';

class MyStudyPage extends StatefulWidget {
  Person _currentPerson;
  MyStudyPage(Person currentPerson) {
    _currentPerson = currentPerson;
  }
  @override
  _MyStudyPageState createState() => _MyStudyPageState(_currentPerson);
}

class _MyStudyPageState extends State<MyStudyPage> {
  Person _currentPerson;
  Courses _myCourses;
  Courses _filteredCourses;
  String _searchText;
  final TextEditingController _filter = new TextEditingController();

  _MyStudyPageState(Person currentPerson) {
    _currentPerson = currentPerson;
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        _searchText = "";
        _filteredCourses = _myCourses;
      } else {
        _filteredCourses = new Courses();
        _filteredCourses.results = [];
        _searchText = _filter.text.toLowerCase();
        for (int i = 0; i < _myCourses.results.length; i++) {
          if (_myCourses.results[i].courseOffering.courseUnit.name
                  .toLowerCase()
                  .contains(_searchText) ||
              _myCourses.results[i].courseOffering.courseUnit.abbrev
                  .toLowerCase()
                  .contains(_searchText)) {
            _filteredCourses.results.add(_myCourses.results[i]);
          }
        }
        setState(() {});
      }
    });
  }

  void initState() {
    super.initState();
    _fetchMyStudy();
  }

  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return _filteredCourses == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Color(0xfff0f0f0),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 145),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: _filteredCourses.results.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildList(context, index);
                          }),
                    ),
                    Container(
                      height: 140,
                      width: double.infinity,
                      color: Colors.blue.shade800,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MenuPage()));
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "\nOdaberite predmet za koji želite " +
                                      '\n' +
                                      " pregled arhiviranih događaja",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 110,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Material(
                              elevation: 5.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: TextField(
                                controller: _filter,
                                cursorColor: Theme.of(context).primaryColor,
                                style: dropdownMenuItem,
                                decoration: InputDecoration(
                                    hintText: "Pretraži predmet",
                                    hintStyle: TextStyle(
                                        color: Colors.black38, fontSize: 16),
                                    prefixIcon: Material(
                                      elevation: 0.0,
                                      child: Icon(Icons.search),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 13)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArchivedEventsPage(
                _currentPerson, _filteredCourses.results[index])));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 13),
                child: Icon(FontAwesomeIcons.book,
                    color: Colors.blue.shade800, size: 35),
              ),
              _filteredCourses.results[index].grade == null
                  ? SizedBox(
                      height: 5,
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 15, 0),
                      child: Text(
                        _filteredCourses.results[index].grade.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    )
            ]),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "\n" +
                        _filteredCourses
                            .results[index].courseOffering.courseUnit.name,
                    style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetchMyStudy() async {
    var response = await Api.getMyStudy(_currentPerson.id);
    if (response.statusCode == 200) {
      _myCourses = Courses.fromJson(response.data);
      _filteredCourses = Courses.fromJson(response.data);
      setState(() {});
    }
  }
}
