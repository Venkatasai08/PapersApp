import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:photo_view/photo_view.dart';

class Search extends StatefulWidget {
  // final Map?  i;
  final Map? paperDetails;
  const Search({Key? key, required this.paperDetails}) : super(key: key);
  // const Search({Key? key, required this.i}) : super(key: key);

  // ignore: use_key_in_widget_constructors
  // const Search( {required this.i});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List paperDetails = [];
  var sometext = "no results found";
  String? subjectname;
  String? shortname;
  String? altername;
  String? year;
  String? semmid;
  String? regulation;
  String? supply;
//  String id =i;

  // String link = "$widget.paperDetails["onefrontsideimg"]";
// void getdatabyid()async{
//      try {
//       var url = Uri.parse('https://10d8-103-57-134-44.ngrok.io/getdatabyid/$i');
//       final response = await http.get(url);
//       var responseData = json.decode(response.body);
//       setState(() {
//         paperDetails = responseData;
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Data base error occured");
//     }
// }

  @override
  void initState() {
    super.initState();
    // getdatabyid();
  }

  void _launchURL(var url) async => await canLaunch(url)
      ? await launch(
          url,
          forceSafariVC: true,
          forceWebView: false,
          // enableJavaScript: true,
        )
      : throw 'Could not launch in web';

  // get onefrontsideimg => Widget.paperDetails["onefrontsideimg"];

  @override
  Widget build(BuildContext context) {
    // print(widget.paperDetails!["twofrontside"].toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Question paper of '${widget.paperDetails!["shortname"]}'"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Subjectname=${widget.paperDetails!["subjectname"]}",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "ALtername='${widget.paperDetails!["altername"]}'",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Year='${widget.paperDetails!["year"]}'",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Paper type='${widget.paperDetails!["semmid"]} '",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Regulation=${widget.paperDetails!["regulation"]}",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Exam type=${widget.paperDetails!["supply"]}",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              Column(
                children: [
                  const Text(
                    "First Paper Front Side",
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 400,
                      width: 250,

                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.paperDetails!["onefrontside"],
                          width: 390,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: SizedBox(
                      //   height: 100,
                      //   width: 50,
                      //   child: PhotoView(

                      //     imageProvider:
                      //         NetworkImage(widget.paperDetails!["onefrontside"]),
                      //   ),
                      // ),
                    ),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      var url = widget.paperDetails!["onefrontside"];
                      //  launch(url);
                      _launchURL(url);
                    },
                    label: const Text("Open image in browser"),
                    icon: const Icon(Icons.launch),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              widget.paperDetails!["onebackside"]!=""?
              Column(
                children: [
                  const Text(
                    "First Paper Back Side",
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 400,
                      width: 250,

                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(width: 0.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.paperDetails!["onebackside"],
                          width: 390,
                          height: 240,
                          fit: BoxFit.cover,
                        ),
                      ),
                      //  child: SizedBox(
                      //   height: 100,
                      //   width: 50,
                      //   child: PhotoView(
                      //     imageProvider:
                      //         NetworkImage(widget.paperDetails!["onebackside"]),
                      //   ),
                      // ),
                    ),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      var url = widget.paperDetails!["onebackside"];
                      //  launch(url);
                      _launchURL(url);
                    },
                    label: const Text("Open image in browser"),
                    icon: const Icon(Icons.launch),
                  ),
                ],
              ):Text(""),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              widget.paperDetails!["twofrontside"] != ""
                  ? Column(
                      children: [
                        const Text(
                          "Second Paper Front Side",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              height: 400,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(width: 0.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  widget.paperDetails!["twofrontside"],
                                  width: 390,
                                  height: 240,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            var url = widget.paperDetails!["twofrontside"];

                            _launchURL(url);
                          },
                          label: const Text("Open image in browser"),
                          icon: const Icon(Icons.launch),
                          // backgroundColor: Colors.blue,
                        )
                      ],
                    )
                  : const Text(""),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              widget.paperDetails!["twobackside"] != ""
                  ? Column(
                      children: [
                        const Text(
                          "Second Paper Back Side",
                          style: TextStyle(color: Colors.black87, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                              height: 400,
                              width: 250,

                              // ignore: prefer_const_constructors
                              decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(width: 0.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  widget.paperDetails!["twobackside"],
                                  width: 390,
                                  height: 240,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            var url = widget.paperDetails!["twobackside"];
                            //  launch(url);

                            _launchURL(url);
                          },
                          label: const Text("Open image in browser"),
                          icon: const Icon(Icons.launch),
                        )
                      ],
                    )
                  : const Text(""),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
