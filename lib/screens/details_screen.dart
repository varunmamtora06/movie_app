import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  //DetailScreen({Key key}) : super(key: key);
  var prevResp;
  DetailScreen({this.prevResp});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Widget custWidg = Container();
  Icon search_cancel = Icon(Icons.search, color: Colors.white);
  String movie_name = TextEditingController().toString();

  var url, movieData, response, res;

  Future getdata(var name) async {
    res = await http.get("http://www.omdbapi.com/?t=${name}&apikey=e0beeb26");
    response = jsonDecode(res.body);

    if (response != null) {
      if (response['Response'] == "False") {
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
      } else {
        setState(() {
          widget.prevResp = response;
        });
      }

      //print(widget.prevResp);
    }
    // print(response);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff99CC99),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: screen.size.width,
                    height: screen.size.height - 400,
                    decoration: BoxDecoration(
                      color: Color(0xff339966),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(180),
                          bottomRight: Radius.circular(180)),
                    ),
                  ),
                  Container(
                    width: screen.size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff339966),
                      // color: Colors.red,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Color(0xff99CC99),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Icon(Icons.arrow_back,
                                    color: Colors.white)),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextField(
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {
                                        movie_name = value;
                                        // print(movie_name);
                                        getdata(movie_name);
                                        setState(() {
                                          search_cancel = Icon(Icons.search,
                                              color: Colors.white);
                                          custWidg = Container();
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
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${widget.prevResp['Title'] ?? response['Title']}",
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 220,
                            // decoration: BoxDecoration(
                            //     color: Colors.red,
                            //     ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(widget.prevResp['Poster'] ??
                                  response['Poster']),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 380,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffffffcc),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8),
                                      child: Text(
                                        "Run Time",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 8),
                                      child: Text(
                                        "${widget.prevResp['Runtime'] ?? response['Runtime']}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[500],
                                      size: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        "Imdb: ${widget.prevResp['imdbRating'] ?? response['imdbRating']}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 10),
                                      child: Text(
                                        "Release",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 8),
                                      child: Text(
                                        "${widget.prevResp['Year'] ?? response['Year']}",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              infoSection("Genre"),
              infoSection("Plot"),
              infoSection("Director"),
              infoSection("Writer"),
              infoSection("Actors"),
              infoSection("Awards"),
              infoSection("Language"),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoSection(String info) {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          info,
          style: TextStyle(fontSize: 45),
          textAlign: TextAlign.center,
        ),
        Text(
          widget.prevResp['${info}'],
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
      ],
    ));
  }
}
