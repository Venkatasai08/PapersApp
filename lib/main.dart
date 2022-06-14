// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:papersapp/RadioButton.dart';
import 'package:shimmer/shimmer.dart';

import 'searchpaper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Splash Screen',
      // home:  showonboarding ? const Onboarding():const MyHomePage(showonboarding: showonboarding(),),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? showonBoarding = false;
  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // final showonboarding = prefs.getBool('showonboarding') ?? false;
    bool? showonboarding = prefs.getBool("showonboarding");
    setState(() {
      // if(showonboarding==true||)
      showonBoarding = showonboarding;
    });
  }

  String? sometext = "Loading";
  getdata() async {
    sometext = "Checking Internet Connection";
    Future.delayed(const Duration(milliseconds: 2350), () {
      setState(() {
        sometext = "Getting all the Papers ";
      });
    });
  }

  @override
  void initState() {
    getPrefs();
    super.initState();
    getdata();
    Timer(
      const Duration(milliseconds: 4000),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => showonBoarding == true || showonBoarding == null
              ? const Onboarding()
              : const SecondScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset(
                  "assets/PapersLoading.json",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                sometext!,
                style: const TextStyle(color: Colors.green, fontSize: 20),
              )
            ],
          ))
          // FlutterLogo(size: MediaQuery.of(context).size.height),
          ),
    );
  }
}

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var branch;
  void alertselectedforbranch(var selectedvalue) {
    setState(() {
      branch = selectedvalue;
    });
  }

  final controller = PageController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  bool islastpage = true;

  var height;
  @override
  void dispose() {
    controller.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
    emailcontroller.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(
              () {
                islastpage = index == 2;
              },
            );
          },
          children: [
            // Container(
            //   //  Page 1 with lottie animation
            //   color: const Color.fromARGB(255, 175, 168, 168),
            //   child: Center(
            //     child: Stack(
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             // Lottie.network(
            //             //     "https://assets9.lottiefiles.com/datafiles/ogIQ10UnwnKiBZS/data.json"),
            //             Lottie.asset("assets/cycling.json"),
            //             const Text(
            //               "This App is just to get good understanding about the Questions and Question Papers",
            //               style: TextStyle(
            //                 fontSize: 30,
            //               ),
            //               textAlign: TextAlign.center,
            //             )
            //           ],
            //         ),
            //         Center(child: Lottie.asset("assets/happy.json")),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   color: const Color.fromRGBO(0, 158, 152, 1),
            //   alignment: Alignment.center,
            //   child: Center(
            //     child: Stack(
            //       children: [
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             // Lottie.network(
            //             //     "https://assets8.lottiefiles.com/private_files/lf30_4uTjNk.json"),
            //             Lottie.asset("assets/trophy.json"),
            //             const Text(
            //               "'A Prefect Practice Makes A Man Perfect '",
            //               style: TextStyle(
            //                 fontSize: 30,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //             const Text(
            //               "So Practice well and write well  ",
            //               style: TextStyle(
            //                 fontSize: 15,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //             const Text(
            //               "All the best for Exams",
            //               style: TextStyle(
            //                 fontSize: 15,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //             const Text(
            //               "Congrats in advance",
            //               style: TextStyle(
            //                 fontSize: 15,
            //               ),
            //               textAlign: TextAlign.center,
            //             )
            //           ],
            //         ),
            //         Center(child: Lottie.asset("assets/happy.json")),
            //         // Center(
            //         //   child: Lottie.network(
            //         //       "https://assets9.lottiefiles.com/packages/lf20_i6sqnxav.json"),
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              color: Colors.white,
              child: Center(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50.0,
                    ),
                    const Text(
                      "Yourdetails",
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: Colors.green,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Name ',
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your HallTicket Number';
                            }
                            return null;
                          },
                          controller: emailcontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'HallTicket Number ',
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            prefixIcon:
                                const Icon(Icons.school, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(
                                5.0,
                                5.0,
                              ),
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: AlertRadio(
                          data: const [
                            "ECE",
                            "CSE",
                            "EEE",
                            "MECH",
                            "CIVIL",
                          ],
                          title: 'Choose Branch',
                          selected: alertselectedforbranch,
                          initialText: "Select Branch",
                        ),
                      ),
                    ),
                    // Lottie.network(
                    //     "https://assets1.lottiefiles.com/packages/lf20_totrpclr.json")
                    GestureDetector(
                      onTap: () => print(branch),
                      child: Lottie.asset(
                        "assets/thanks.json",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: islastpage
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: SizedBox(
                    width: 200,
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        var email = emailcontroller.text;
                        var name = namecontroller.text;

                        if (name.isEmpty || email.isEmpty || branch == null) {
                          Fluttertoast.showToast(
                            msg: "Please enter all the Detailes",
                          );
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool("showonboarding", false);
                          prefs.setString("name", namecontroller.text);
                          prefs.setString("email", emailcontroller.text);
                          prefs.setString("branch", branch);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SecondScreen(),
                            ),
                          );
                          print(branch);
                        }
                      },
                      label: const Text("Get Started"),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: const Text("SKIP"),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: const Text("NEXT"),
                  ),
                ],
              ),
            ),
    );
  }
}

class Navigationdrawer extends StatelessWidget {
  const Navigationdrawer({Key? key}) : super(key: key);

  // ignore: non_constant_identifier_names
  final Padding = const EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: Container(
          padding: Padding,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/logo.png")),
                  Column(
                    children: [
                      
                      Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.white,
                          direction: ShimmerDirection.ltr,
                          period: Duration(milliseconds: 3000),
                          child: Text(
                            "Papers App",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.white,
                height: 3,
              ),
              buildmenuitem(
                  text: "Kranthi Dev Sai",
                  icon: Icons.developer_mode_rounded,
                  subtext: "Frontend Developer",
                  toast: "Flutter Frontend Dev"),
              Divider(
                color: Colors.white,
                height: 3,
              ),
              buildmenuitem(
                  text: "Shiva Ram",
                  icon: Icons.developer_mode,
                  subtext: "Graphic Designer",
                  toast: "Figma Developer"),
              Divider(
                color: Colors.white,
                height: 3,
              ),
              buildmenuitem(
                  text: "Venkata Sai",
                  icon: Icons.stacked_bar_chart,
                  subtext: "Backend Developer",
                  toast: "Flutter Backend Dev"),
              Divider(
                color: Colors.white,
                height: 3,
              ),
              buildmenuitem(
                  text: "Bommera Akhil",
                  icon: Icons.text_fields,
                  subtext: "App Tester",
                  toast: "Integration Tester"),
              Divider(
                color: Colors.white,
                height: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildmenuitem(
      {required String text,
      required IconData icon,
      required String subtext,
      required String toast}) {
    const color = Colors.white;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
      subtitle: Text(
        subtext,
        style: const TextStyle(color: color),
      ),
      onTap: () {
        Fluttertoast.showToast(msg: toast);
      },
    );
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  void alertmethod() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showAlertDialogforbeta(context);
      }
    } on SocketException catch (_) {
      showAlertDialogofinternet(context);
    }
  }

  String name = "";
  getEmail2SF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nameSF = prefs.getString('name');
    setState(
      () {
        name = nameSF!;
        print(name);
      },
    );
    return name;
  }
    getBranchSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? branchSF = prefs.getString('branch');
    setState(
      () {
        branch = branchSF!;
        print(branch);
      },
    );
    return branch;
  }
  String branch = "";
  @override
  void initState() {
    super.initState();
    getEmail2SF();
    getBranchSF();
    alertmethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navigationdrawer(),
      appBar: AppBar(
        title: const Text("Model papers world"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dear"),
              Text(
                name,
                style: const TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "welcome ",
                      style: TextStyle(fontSize: 30, color: Colors.blue),
                    ),
                    Text(
                      "to the ",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    Text(
                      "world",
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    )
                  ],
                ),
              ),
              const Text(
                "of",
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
              ),
              const Text(
                "Questions Papers",
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
              const Padding(padding: EdgeInsets.all(20.0)),
              SizedBox(
                height: 40.0,
                width: 100.0,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Entering to the world",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.purple,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Searchpaper(branch: branch,),
                      ),
                    );
                  },
                  label: const Icon(Icons.logout),
                ),
              )
            ],
          ),
        ),
        // child: const Text("welcome to my app"),
      ),
    );
  }
}

showAlertDialogofinternet(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: const Text("Close"),
    onPressed: () {
      // Navigator.of(context).pop();
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    },
  );

  // Create AlertDialog
  AlertDialog alertforinternet = AlertDialog(
    title: const Text("OOPPPPPs"),
    content: const Text(
        "You dont have an active internet connection please connect to internet"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertforinternet;
    },
  );
}

showAlertDialogforbeta(BuildContext context) async {
  // Create button

  Widget okButton = FlatButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Notice"),
    content: const Text(
        "This app is in the beta version if you found any bugs please kindly report"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
