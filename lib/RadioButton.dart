import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlertRadio extends StatefulWidget {
  List data;
  String title;
  final selected;
  String initialText;
  AlertRadio(
      {Key? key,
      required this.data,
      required this.title,
      required this.initialText,
      required this.selected})
      : super(key: key);

  @override
  State<AlertRadio> createState() => _AlertRadioState();
}

class _AlertRadioState extends State<AlertRadio> {
  // ignore: prefer_typing_uninitialized_variables
  late String setgroupValue;

  @override
  void initState() {
    super.initState();

    setgroupValue = widget.initialText;
  }

  Widget BuildRadios() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.data.map(
        (value) {
          return RadioListTile<String>(
              value: value,
              groupValue: setgroupValue,
              title: Text(value),
              onChanged: (value) {
                setState(
                  () {
                    // print(value);
                    setgroupValue = value!;
                  },
                );
                widget.selected(setgroupValue);
                Navigator.of(context).pop();
              });
        },
      ).toList(),
    );
  }
  // void additemtolist(var size){
  //   widget.items.add(number*10);
  // }

  Future showAlertforpopup() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(widget.title),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: BuildRadios(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlertforpopup();
      },
      child: Container(
        width: 140.0,
        height: 60,
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                setgroupValue,
                style: const TextStyle(fontSize: 17),
              ),
              const Icon(
                FontAwesomeIcons.caretDown,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
