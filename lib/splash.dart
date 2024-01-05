import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:quotes_app/quote_app.dart';

Map dataList = {};
Map extraList = {};
List titleList = [];

class SplashScreenQuotes extends StatefulWidget {
  const SplashScreenQuotes({super.key});

  @override
  State<SplashScreenQuotes> createState() => _SplashScreenQuotesState();
}

class _SplashScreenQuotesState extends State<SplashScreenQuotes> {
  bool isGetDataProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: Center(
          child: Lottie.asset("assets/images/quotes_splash_logo.json",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width)),
    );
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          "https://development.frontbitsolutions.com/my_api/api.php?package_name=com.gameloft.android.ANMP.GloftGGHM&api_key=dk123"),
    );
    setState(() {});
    if (response.statusCode == 200) {
      dataList = jsonDecode(response.body);
      extraList = jsonDecode(dataList["extra"]);
      extraList["data"].shuffle();
      Fluttertoast.showToast(
          msg: "data get successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const QuotesApp(),
          ),
              (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
