import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:papersapp/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'searchinput.dart';

class Searchpaper extends StatefulWidget {
  var branch;
  Searchpaper({Key? key, this.branch}) : super(key: key);

  @override
  _SearchpaperState createState() => _SearchpaperState();
}

class _SearchpaperState extends State<Searchpaper> {
  List allpapers = [];
  String? sometext = "No Results Found";

  // ignore: unused_field
  final _dataofsname = "";
  getdata() async {
    sometext = "loading";
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isPapers = false;
        sometext = "Poor Internet Connection ";
      });
    });
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        isPapers = true;
        sometext = "No papers are available for ${widget.branch} Branch";
      });
    });
  }

  bool isPapers = false;
  void _builddata() async {
    // getData();
    print(widget.branch);
    try {
      var url = Uri.parse(
          'https://papersbank-backend.herokuapp.com/getdatabybranch/${widget.branch}');
      final response = await http.get(url);
      print(response);
      print("response is printed ");
      print(response.body);
      print("response body is printed");
      var responseData = json.decode(response.body);

      print(responseData);
      print(" response data is printed");
      setState(() {
        allpapers = responseData;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Data base error occured");
    }
  }

  @override
  void initState() {
    super.initState();

    _builddata();

    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Questions papers"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 40),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.purple,
                  heroTag: "btn1",
                  // ignore: avoid_print
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Searchinput(),
                      ),
                    );
                  },

                  label: const Text("Search Question Paper"),
                  icon: const Icon(Icons.search),
                  // extendedPadding: const EdgeInsets.all(30.0),
                ),
              ),
            ),
            allpapers.isNotEmpty
                ? Expanded(
                    child: Column(
                      children: [
                        Text(
                            "Here only your branch(${widget.branch}) Model Papers are available"),
                        SizedBox(height: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ListView.separated(
                              itemCount: allpapers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          // builder: (context) => Search(paperDetails:allpapers[index] ),
                                          builder: (context) => Search(
                                              paperDetails: allpapers[index]),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.black,
                                          ),
                                          child: Center(
                                            child: FittedBox(
                                              child: Text(
                                                  "${allpapers[index]["subjectname"]}",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 80,
                                              child: Card(
                                                color: Colors.green,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Easy"),
                                                    FittedBox(
                                                      child: Text(
                                                          "${allpapers[index]
                                                              ["easy"]}"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Card(
                                                child: ListTile(
                                                  leading: SizedBox(
                                                      width: 40,
                                                      child: Text(
                                                          allpapers[index]
                                                              ["semmid"])),
                                                   
                                                  title: Text(allpapers[index]
                                                      ["shortname"]),
                                                  subtitle: Text(
                                                      allpapers[index]["year"]),
                                                ),
                                                elevation: 10,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 100,
                                              width: 80,
                                              child: Card(
                                                color: Colors.red,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Tough"),
                                                    FittedBox(
                                                      child: Text(
                                                          "${allpapers[index]["tough"]}"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  height: 10,
                                  color: Colors.purple,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: isPapers == false
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(
                                  strokeWidth: 10,
                                  color: Colors.purple,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                sometext!,
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Lottie.asset("assets/sad.json"),
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(sometext!,
                                  style: const TextStyle(fontSize: 20.0)),
                            ],
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
// return ListTile(
//   // ignore: avoid_print
//   leading: const IconButton(
//     onPressed: null,
//     icon: Icon(Icons.ac_unit_outlined),
//   ),
//   trailing: const Icon(Icons.delete),
//   title: Text(
//     allpapers[index]["subjectname"],
//     style: const TextStyle(fontSize: 24),
//   ),
// );