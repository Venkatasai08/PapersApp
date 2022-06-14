// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:papersapp/search.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Searchinput extends StatefulWidget {
  const Searchinput({Key? key}) : super(key: key);

  @override
  _SearchinputState createState() => _SearchinputState();
}

class _SearchinputState extends State<Searchinput>
    with TickerProviderStateMixin {
  TextEditingController subjectnameController = TextEditingController();
  final controller = PageController();
  late final AnimationController _likecontroller;
  late final AnimationController _dislikecontroller;

  List dummyList = [];
  List _dataofsname = [];
  String label = "Some Label";
  bool onpeasy = true;
  bool onptough = true;
  bool onptoughset = true;
  bool onpeasyset = true;
  List oneasy = [];
  List ontough = [];
  bool isLoading = false;
  // int inteasy = 0;
  // int inttough = 0;
  // String streasy = "";
  // String strtough = "";

  @override
  void initState() {
    super.initState();
    subjectnameController;
    _builddata();
    _likecontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _dislikecontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  // @override
  // void dispose() {
    
  //   super.dispose();
  //   subjectnameController.dispose();
  // }

  void _builddata() async {
    try {
      var url =
          Uri.parse('https://papersbank-backend.herokuapp.com/getdummylist');
      final response = await http.get(url);
      var responseData = json.decode(response.body);
      setState(() {
        dummyList = responseData;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "no options");
    }
  }
  //   bool islikeAnimate = false;
  // bool isdislikeAnimate = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // print(_dataofsname);
    // TextEditingController myController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search by Subject name"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          const Text("Search question paper by"),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 70,
                child: TextFieldSearch(
                  initialList: dummyList,
                  label: "Subjectname",
                  controller: subjectnameController,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  var sname = subjectnameController.text;
                  void searchybname() async {
                    try {
                      var url = Uri.parse(
                          "https://papersbank-backend.herokuapp.com/getdatabysubname/$sname");
                      final response1 = await http.get(url);

                      var responseData1 = json.decode(response1.body);
                      setState(() {
                        _dataofsname = responseData1;
                        isLoading = false;
                      });
                    } catch (e) {
                      Fluttertoast.showToast(msg: "data base error");
                    }
                  }

                  // print(sname);
                  searchybname();
                },
                label: const Icon(Icons.search),
              )
            ],
          ),
          _dataofsname.isNotEmpty
              ? Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      primary: false,
                      itemCount: _dataofsname.length,
                      itemBuilder: (BuildContext context, int index) {
                        oneasy.length < _dataofsname.length
                            ? oneasy.add(false)
                            : null;
                        ontough.length < _dataofsname.length
                            ? ontough.add(false)
                            : null;

                        return SizedBox(
                          height: 450,
                          width: width,
                          child: Card(
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1)),
                                        height: 330,
                                        width: width / 1.8,
                                        child: PageView(
                                          controller: controller,
                                          children: [
                                            Image.network(
                                              _dataofsname[index]
                                                  ["onefrontside"],
                                              fit: BoxFit.cover,
                                            ),
                                            _dataofsname[index]
                                                        ["onebackside"] !=
                                                    ""
                                                ? Image.network(
                                                    _dataofsname[index]
                                                        ["onebackside"],
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    child: const Center(
                                                        child:
                                                            Text("No Image")),
                                                  ),
                                            _dataofsname[index]
                                                        ["twofrontside"] !=
                                                    ""
                                                ? Image.network(
                                                    _dataofsname[index]
                                                        ["twofrontside"],
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    child: const Center(
                                                        child:
                                                            Text("No Image")),
                                                  ),
                                            _dataofsname[index]
                                                        ["twobackside"] !=
                                                    ""
                                                ? Image.network(
                                                    _dataofsname[index]
                                                        ["twobackside"],
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    child: const Center(
                                                        child:
                                                            Text("No Image")),
                                                  )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 330,
                                        width: 100,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Reviews",
                                                  style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  )),
                                              Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _likecontroller
                                                            .forward();
                                                      });

                                                      print(oneasy);
                                                      // oneasy[index] += 1;
                                                      // print(oneasy[index]);

                                                      String onpeindex =
                                                          _dataofsname[index]
                                                              ["_id"];
                                                      // int.parse(
                                                      //     "${_dataofsname[index]["easy"]}");
                                                      setandupeasy() {
                                                        {
                                                          setState(() {
                                                            oneasy[index] =
                                                                true;
                                                            // onptough = false;
                                                            // onpeasy = false;
                                                            // onpeasyset = false;
                                                            // onptoughset = true;
                                                            _dataofsname[index]
                                                                    ["easy"] =
                                                                _dataofsname[
                                                                            index]
                                                                        [
                                                                        "easy"] +
                                                                    1;
                                                          });
                                                        }

                                                        var url1 = Uri.parse(
                                                          'https://papersbank-backend.herokuapp.com/update/easy/${_dataofsname[index]["_id"]}',
                                                        );
                                                        void
                                                            easyupmethod() async {
                                                          try {
                                                            await http.put(
                                                              url1,
                                                              headers: <String,
                                                                  String>{
                                                                'Content-Type':
                                                                    'application/json; charset=UTF-8',
                                                              },
                                                              body: json.encode(
                                                                {
                                                                  "easy": (_dataofsname[
                                                                          index]
                                                                      ["easy"]),
                                                                },
                                                              ),
                                                            );
                                                          } catch (e) {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "database error");
                                                          }
                                                        }

                                                        easyupmethod();
                                                      }

                                                      // onpeasy ? setandupeasy() : null;
                                                      if (onpeindex ==
                                                              _dataofsname[
                                                                      index]
                                                                  ["_id"] &&
                                                          onpeasy == true) {
                                                        setandupeasy();
                                                      } else {
                                                        onpeasy = true;
                                                        onptough = true;
                                                        onpeasyset = true;
                                                        onptoughset = true;
                                                      }
                                                    },
                                                    child: Container(
                                                      color: Colors.green,
                                                      height: 120,
                                                      width: 130,
                                                      child:
                                                          // Lottie.network(
                                                          //   "https://assets1.lottiefiles.com/packages/lf20_qlyb4sly.json",
                                                          //   controller: _likecontroller,
                                                          // )
                                                          Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          SizedBox(
                                                            height: 70,
                                                            width: 70,
                                                            child: Lottie.asset(
                                                              "assets/lottie/Like2.json",
                                                              controller:
                                                                  _likecontroller,
                                                            ),
                                                          ),
                                                          Text(
                                                            oneasy[index] ==
                                                                    true
                                                                ? "Easiest"
                                                                : "Easy",
                                                          ),
                                                          Text(
                                                              "${_dataofsname[index]["easy"]}")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ontough[index] ||
                                                          oneasy[index]
                                                      ? Center(
                                                          child: Container(
                                                            height: 120,
                                                            width: 130,
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              // const SizedBox(
                                              //   height: 15,
                                              // ),

                                              Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        // isdislikeAnimate = true;
                                                        _dislikecontroller
                                                            .forward();
                                                        String onptindex =
                                                            _dataofsname[index]
                                                                ["_id"];
                                                        setanduptough() {
                                                          {
                                                            setState(() {
                                                              ontough[index] =
                                                                  true;
                                                              // onptough = false;
                                                              // onpeasy = false;
                                                              // onpeasyset = true;
                                                              // onptoughset = false;
                                                              _dataofsname[
                                                                          index]
                                                                      [
                                                                      "tough"] =
                                                                  _dataofsname[
                                                                              index]
                                                                          [
                                                                          "tough"] +
                                                                      1;
                                                            });
                                                          } //  else {
                                                          //   onpeasy = true;
                                                          //   onptough = true;
                                                          //   onpeasyset = true;
                                                          //   onptoughset = true;
                                                          // }

                                                          // int a=1;
                                                          // var toughupdata =
                                                          //     _dataofsname[index]["tough"] +a;
                                                          var url2 = Uri.parse(
                                                            'https://papersbank-backend.herokuapp.com/update/tough/${_dataofsname[index]["_id"]}',
                                                          );
                                                          void
                                                              toughupmethod() async {
                                                            try {
                                                              await http.put(
                                                                url2,
                                                                headers: <
                                                                    String,
                                                                    String>{
                                                                  'Content-Type':
                                                                      'application/json; charset=UTF-8',
                                                                },
                                                                body:
                                                                    jsonEncode(
                                                                  {
                                                                    "tough": (_dataofsname[
                                                                            index]
                                                                        [
                                                                        "tough"])
                                                                  },
                                                                ),
                                                              );
                                                            } catch (e) {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "database error");
                                                            }
                                                          }

                                                          toughupmethod();

                                                          // Fluttertoast.showToast(
                                                          //     msg:
                                                          //         "${_dataofsname[index]["tough"]}");
                                                        }

                                                        // onptough ? setanduptough() : null;
                                                        if (onptindex ==
                                                                _dataofsname[
                                                                        index]
                                                                    ["_id"] &&
                                                            onptough == true) {
                                                          setanduptough();
                                                        } else {
                                                          onpeasy = true;
                                                          onptough = true;
                                                          onpeasyset = true;
                                                          onptoughset = true;
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      color: Colors.red,
                                                      height: 120,
                                                      width: 130,
                                                      child:
                                                          // Lottie.network(
                                                          //   "https://assets1.lottiefiles.com/packages/lf20_qlyb4sly.json",
                                                          //   controller: _likecontroller,
                                                          // )

                                                          Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          RotationTransition(
                                                            turns:
                                                                const AlwaysStoppedAnimation(
                                                                    180 / 360),
                                                            child: SizedBox(
                                                              height: 70,
                                                              width: 70,
                                                              child:
                                                                  Lottie.asset(
                                                                "assets/lottie/Like2.json",
                                                                controller:
                                                                    _dislikecontroller,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(ontough[index] ==
                                                                  true
                                                              ? "Toughest"
                                                              : "Tough"),
                                                          Text(
                                                              "${_dataofsname[index]["tough"]}")
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  ontough[index] ||
                                                          oneasy[index]
                                                      ? Center(
                                                          child: Container(
                                                            height: 120,
                                                            width: 130,
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                              FittedBox(
                                                child: SmoothPageIndicator(
                                                  controller: controller,
                                                  count: 4,
                                                  onDotClicked: (index) =>
                                                      controller.animateToPage(
                                                          index,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          curve: Curves.easeIn),
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "${_dataofsname[index]['subjectname']}",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Divider(
                                    color: Colors.blueGrey,
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => (Search(
                                              paperDetails:
                                                  _dataofsname[index])),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 42,
                                      width: width,
                                      color: Colors.black,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "View More Details",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        // SizedBox(
                        //   height: 200,
                        //   child: Card(
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             Text("${_dataofsname[index]["shortname"]}"),
                        //             const Padding(
                        //               padding: EdgeInsets.only(right: 5.0),
                        //             ),
                        //             Column(
                        //               children: [
                        //                 const Text("subjectname"),
                        //                 FittedBox(
                        //                   child: Text(
                        //                     "${_dataofsname[index]["subjectname"]}",
                        //                     overflow: TextOverflow.ellipsis,
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //             Text(
                        //                 "${_dataofsname[index]["regulation"]}"),
                        //           ],
                        //         ),
                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             Stack(
                        //               children: [
                        //                 AnimatedContainer(
                        //                   duration:
                        //                       const Duration(milliseconds: 501),
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(20.0),
                        //                     color: Colors.black54,
                        //                   ),
                        //                   padding:
                        //                       const EdgeInsets.only(left: 1),
                        //                   width: oneasy[index] ? 100 : 80,
                        //                   child: TextButton.icon(
                        //                     onPressed: () {
                        //                       // print(oneasy);
                        //                       // oneasy[index] += 1;
                        //                       // print(oneasy[index]);

                        //                       String onpeindex =
                        //                           _dataofsname[index]["_id"];
                        //                       // int.parse(
                        //                       //     "${_dataofsname[index]["easy"]}");
                        //                       setandupeasy() {
                        //                         {
                        //                           setState(() {
                        //                             oneasy[index] = true;
                        //                             // onptough = false;
                        //                             // onpeasy = false;
                        //                             // onpeasyset = false;
                        //                             // onptoughset = true;
                        //                             _dataofsname[index]
                        //                                     ["easy"] =
                        //                                 int.parse((_dataofsname[index]
                        //                                         ["easy"])
                        //                                     )+1;
                        //                           });
                        //                         }

                        //                         var url1 = Uri.parse(
                        //                           'https://normal-backend.herokuapp.com/update/easy/${_dataofsname[index]["_id"]}',
                        //                         );
                        //                         void easyupmethod() async {
                        //                           try {
                        //                             await http.put(
                        //                               url1,
                        //                               headers: <String, String>{
                        //                                 'Content-Type':
                        //                                     'application/json; charset=UTF-8',
                        //                               },
                        //                               body: json.encode(
                        //                                 {
                        //                                   "easy": (_dataofsname[
                        //                                       index]["easy"]),
                        //                                 },
                        //                               ),
                        //                             );
                        //                           } catch (e) {
                        //                             Fluttertoast.showToast(
                        //                                 msg: "database error");
                        //                           }
                        //                         }

                        //                         easyupmethod();
                        //                       }

                        //                       // onpeasy ? setandupeasy() : null;
                        //                       if (onpeindex ==
                        //                               _dataofsname[index]
                        //                                   ["_id"] &&
                        //                           onpeasy == true) {
                        //                         setandupeasy();
                        //                       } else {
                        //                         onpeasy = true;
                        //                         onptough = true;
                        //                         onpeasyset = true;
                        //                         onptoughset = true;
                        //                       }
                        //                     },
                        //                     icon: Icon(
                        //                       Icons.thumb_up,
                        //                       size: oneasy[index] ? 25 : 15,
                        //                       color: Colors.green,
                        //                     ),
                        //                     label: Text(
                        //                       oneasy[index]
                        //                           ? "Easiset "
                        //                           : "Easy",
                        //                       style: TextStyle(
                        //                           fontSize:
                        //                               oneasy[index] ? 10 : 15),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 oneasy[index] || ontough[index]
                        //                     ? Center(
                        //                         child: Container(
                        //                           width:
                        //                               oneasy[index] ? 100 : 80,
                        //                           height: 50,
                        //                           color: Colors.transparent,
                        //                         ),
                        //                       )
                        //                     : Container()
                        //               ],
                        //             ),
                        //             Text(
                        //               "${_dataofsname[index]["easy"]}",
                        //               style: TextStyle(
                        //                   fontSize:
                        //                       oneasy[index] ? 25.0 : 15.0),
                        //             ),
                        //             // const VerticalDivider(
                        //             //   thickness: 2,
                        //             //   color: Colors.black,
                        //             // ),
                        //             Container(
                        //               decoration: const BoxDecoration(
                        //                   border: Border(
                        //                 left: BorderSide(
                        //                   color: Colors.black,
                        //                   width: 3.0,
                        //                 ),
                        //               )),
                        //             ),
                        //             Text(
                        //               "${_dataofsname[index]["tough"]}",
                        //               style: TextStyle(
                        //                   fontSize:
                        //                       ontough[index] ? 25.0 : 15.0),
                        //             ),
                        //             Stack(
                        //               children: [
                        //                 Center(
                        //                   child: AnimatedContainer(
                        //                     duration: const Duration(
                        //                         milliseconds: 500),
                        //                     decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(20.0),
                        //                       color: Colors.black54,
                        //                     ),
                        //                     padding:
                        //                         const EdgeInsets.only(left: 1),
                        //                     width: ontough[index] ? 100 : 80,
                        //                     child: TextButton.icon(
                        //                       onPressed: () {
                        // String onptindex =
                        //     _dataofsname[index]["_id"];
                        // setanduptough() {
                        //   {
                        //     setState(() {
                        //       ontough[index] = true;
                        //       // onptough = false;
                        //       // onpeasy = false;
                        //       // onpeasyset = true;
                        //       // onptoughset = false;
                        //     _dataofsname[index]
                        //               ["tough"] =
                        //         int.parse(  _dataofsname[index]
                        //                   ["tough"]) +
                        //               1;
                        //     });
                        //   } //  else {
                        //   //   onpeasy = true;
                        //   //   onptough = true;
                        //   //   onpeasyset = true;
                        //   //   onptoughset = true;
                        //   // }

                        //   // int a=1;
                        //   // var toughupdata =
                        //   //     _dataofsname[index]["tough"] +a;
                        //   var url2 = Uri.parse(
                        //     'https://normal-backend.herokuapp.com/update/tough/${_dataofsname[index]["_id"]}',
                        //   );
                        //   void toughupmethod() async {
                        //     try {
                        //       await http.put(
                        //         url2,
                        //         headers: <String,
                        //             String>{
                        //           'Content-Type':
                        //               'application/json; charset=UTF-8',
                        //         },
                        //         body: jsonEncode(
                        //           {
                        //             "tough":
                        //                 (_dataofsname[
                        //                         index]
                        //                     ["tough"])
                        //           },
                        //         ),
                        //       );
                        //     } catch (e) {
                        //       Fluttertoast.showToast(
                        //           msg:
                        //               "database error");
                        //     }
                        //   }

                        //   toughupmethod();

                        //   // Fluttertoast.showToast(
                        //   //     msg:
                        //   //         "${_dataofsname[index]["tough"]}");
                        // }

                        // // onptough ? setanduptough() : null;
                        // if (onptindex ==
                        //         _dataofsname[index]
                        //             ["_id"] &&
                        //     onptough == true) {
                        //   setanduptough();
                        // } else {
                        //   onpeasy = true;
                        //   onptough = true;
                        //   onpeasyset = true;
                        //   onptoughset = true;
                        // }
                        //                       },
                        //                       icon: Icon(
                        //                         Icons.thumb_down,
                        //                         size: ontough[index] ? 25 : 15,
                        //                         color: Colors.red,
                        //                       ),
                        //                       label: Text(
                        //                         ontough[index]
                        //                             ? "Toughest"
                        //                             : "Tough",
                        //                         style: TextStyle(
                        //                             fontSize: ontough[index]
                        //                                 ? 10
                        //                                 : 13),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        // ontough[index] || oneasy[index]
                        //     ? Center(
                        //         child: Container(
                        //           width:
                        //               ontough[index] ? 100 : 80,
                        //           height: 50,
                        //           color: Colors.transparent,
                        //         ),
                        //       )
                        //     : Container()
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //         const Divider(height: 2,color: Colors.grey,),
                        //         GestureDetector(
                        //           onTap: () {
                        //               Navigator.of(context).push(
                        //                 MaterialPageRoute(
                        //                   // builder: (context) => Search(paperDetails:allpapers[index] ),
                        //                   builder: (context) => Search(
                        //                       paperDetails: _dataofsname[index]),
                        //                 ),
                        //               );
                        //             },
                        //           child: Container(
                        //           height: 50,
                        //           width:double.infinity,
                        //           // color: Colors.black,

                        //             child: const Center(child: Text("Viewmore",style: TextStyle(decoration: TextDecoration.underline),))
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //     elevation: 20,
                        //   ),
                        // );
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                              "Type and select the subject and click on search icon"),
                          Text(" and wait for the results"),
                          SizedBox(height: 100,),
                          isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Container()
                        ],
                      )),
                ),
        ],
      ),
    );
  }
}

// child: Card(
//   color: Colors.grey,
//   child: ListTile(
//     title: SizedBox(
//       height: 80,
//       child: Column(
//         children: [
//           const Text(
//             "Subjectname",
//             style: TextStyle(color: Colors.white),
//           ),
//           Text(
//             "${_dataofsname[index]["subjectname"]}",
//             style: const TextStyle(
//                 fontSize: 15, color: Colors.white),
//           ),
//         ],
//       ),
//     ),
//     leading: Container(
//       height: 100,
//       child:     Container(
//             color: Colors.black54,
//             padding: const EdgeInsets.only(left: 1),
//             width: 80,
//             child: TextButton.icon(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.thumb_up,
//                 size: 15,
//               ),
//               label: const Text("Easy"),
//             ),
//           ),
//     ),
//     trailing:   Container(
//             color: Colors.black54,
//             padding: const EdgeInsets.only(left: 1),
//             width: 80,
//             child: TextButton.icon(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.thumb_down,
//                 size: 15,
//                 color: Colors.red,
//               ),
//               label: const Text("Tough"),
//             ),
//           ),
//     // subtitle: Container(
//     //   padding: const EdgeInsets.symmetric(vertical: 0),
//     //   child: Row(
//     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //     children: [
//           // Container(
//           //   color: Colors.black54,
//           //   padding: const EdgeInsets.only(left: 1),
//           //   width: 80,
//           //   child: TextButton.icon(
//           //     onPressed: () {},
//           //     icon: Icon(
//           //       Icons.thumb_up,
//           //       size: 15,
//           //     ),
//           //     label: const Text("Easy"),
//           //   ),
//           // ),
//           // Padding(padding: const EdgeInsets.all(10)),
//           // Container(
//           //   color: Colors.black54,
//           //   padding: const EdgeInsets.only(left: 1),
//           //   width: 80,
//           //   child: TextButton.icon(
//           //     onPressed: () {},
//           //     icon: Icon(
//           //       Icons.thumb_down,
//           //       size: 15,
//           //       color: Colors.red,
//           //     ),
//           //     label: const Text("Tough"),
//           //   ),
//           // ),
//     //     ],
//     //   ),
//     // ),
//   ),
//   elevation: 20,
// ),
