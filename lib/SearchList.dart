import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  const SearchList({Key? key}) : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  TextEditingController _controller = TextEditingController();

  List dummyList = [
    "Name",
    "Na5me",
    "Na6me",
    "Nam7e",
    "Nafme",
    "Nsame",
    "Naume",
    "Ntyame",
    "Nafhme",
    "Nambvce",
    "Namade",
    "Namvbe",
    "Navxbsdfme",
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Data")),
      body: Container(
          child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(hintText: "Search"),
       
      )),
    );
  }
}
