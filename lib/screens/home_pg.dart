import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget custWidg = Container();
  Icon search_cancel = Icon(Icons.search, color: Colors.white);

  String movie_name = TextEditingController().toString();

  var response, res;
  Future getdata(var name) async {
    res = await http.get("http://www.omdbapi.com/?t=${name}&apikey=e0beeb26");
    response = jsonDecode(res.body);
    //print(response);
    if (res.statusCode == 200 && response['Title'] != null) {
      setState(() {
        
      custWidg = Container();
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                    prevResp: response,
                  )));
    } else if (response['Response'] == "False") {
      setState(() {
        
      custWidg = Container();
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Movie Not Found!!"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Okay"))
              ],
            );
          });
      // print("errorrr");
    } else {
      setState(() {
        
      custWidg = CircularProgressIndicator(backgroundColor: Colors.white,);//this else is just incase if internet is slow/not availale
      });
    }
    // print(res.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF99CC99),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 800,
              decoration: BoxDecoration(
                color: Color(0xff99CC99),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(65)),
              ),
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(top: screen.size.height/1.3, bottom: 0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    moovie("ford",
                        "https://m.media-amazon.com/images/M/MV5BM2UwMDVmMDItM2I2Yi00NGZmLTk4ZTUtY2JjNTQ3OGQ5ZjM2XkEyXkFqcGdeQXVyMTA1OTYzOTUx._V1_SX300.jpg"),
                    moovie("avengers",
                        "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg"),
                    moovie("parasite",
                        "https://m.media-amazon.com/images/M/MV5BYWZjMjk3ZTItODQ2ZC00NTY5LWE0ZDYtZTI3MjcwN2Q5NTVkXkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_SX300.jpg"),
                    moovie("starwars",
                        "https://m.media-amazon.com/images/M/MV5BNTI5OTBhMGYtNTZlNS00MjMzLTk5NTEtZDZkODM5YjYzYmE5XkEyXkFqcGdeQXVyMzU0OTU0MzY@._V1_SX300.jpg"),
                  ],
                ),
              ),
            ),
            Container(
              width: screen.size.width,
              height: screen.size.height/1.45,
              decoration: BoxDecoration(
                color: Color(0xff339966),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(65)),
              ),
              child: Container(
                padding: EdgeInsets.only(top: screen.size.height/1.65),
                child: Text(
                  "Now Playing",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: screen.size.height/1.75,
              decoration: BoxDecoration(
                color: Color(0xffffffcc),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(65)),
              ),
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.only(left: 10, top: 10),
                margin: EdgeInsets.only(top: screen.size.height/5, bottom: 0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    moovie("it",
                        "https://m.media-amazon.com/images/M/MV5BZDVkZmI0YzAtNzdjYi00ZjhhLWE1ODEtMWMzMWMzNDA0NmQ4XkEyXkFqcGdeQXVyNzYzODM3Mzg@._V1_SX300.jpg"),
                    moovie("saw",
                        "https://m.media-amazon.com/images/M/MV5BMjE4MDYzNDE1OV5BMl5BanBnXkFtZTcwNDY2OTYwNA@@._V1_SX300.jpg"),
                    moovie("nun",
                        "https://m.media-amazon.com/images/M/MV5BY2NiNWU3OTktODVlYi00NmRiLWIzYTYtMzZjYzlkYmFkNTI1XkEyXkFqcGdeQXVyMjM2OTAxNg@@._V1_SX300.jpg"),
                    moovie("inferno",
                        "https://m.media-amazon.com/images/M/MV5BMTUzNTE2NTkzMV5BMl5BanBnXkFtZTgwMDAzOTUyMDI@._V1_SX300.jpg"),
                  ],
                ),
              ),
            ),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xff339966),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(65)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Made with ❤️ by Varooon!!"),
                                );
                              });
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color(0xff99CC99),
                                borderRadius: BorderRadius.circular(7)),
                            child: Icon(Icons.info, color: Colors.white)),
                      ),
                      custWidg,
                      InkWell(
                        onTap: () {
                          if (search_cancel.icon == Icons.search) {
                            setState(() {
                              search_cancel = Icon(
                                Icons.cancel,
                                color: Colors.white,
                              );
                              custWidg = Container(
                                margin: EdgeInsets.only(top: 5),
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (value) {
                                    movie_name = value;
                                    // print(movie_name);
                                    getdata(movie_name);
                                    setState(() {
                                      search_cancel = Icon(Icons.search,
                                          color: Colors.white);
                                      // custWidg = Container();
                                      custWidg=CircularProgressIndicator(backgroundColor: Colors.white,);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search a movie",
                                  ),
                                ),
                              );
                            });
                          } else {
                            setState(() {
                              search_cancel =
                                  Icon(Icons.search, color: Colors.white);
                              custWidg = Container();
                            });
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color(0xff99CC99),
                                borderRadius: BorderRadius.circular(7)),
                            child: search_cancel),
                      )
                    ],
                  ),
                  Text(
                    "Trending",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  Text(
                    "New Releases",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget moovie(String movieName, String imgurl) {
    return InkWell(
      onTap: ()  {
        setState(() {
          custWidg=CircularProgressIndicator(backgroundColor: Colors.white,);
        });
        getdata(movieName);
      },
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(5),
              // color: Colors.red,
              width: MediaQuery.of(context).size.width/3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(imgurl))),
          Container(
            child: Text(
              movieName.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
