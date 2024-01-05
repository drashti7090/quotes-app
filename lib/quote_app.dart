import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:quotes_app/share_quote.dart';
import 'package:quotes_app/splash.dart';
import 'package:url_launcher/url_launcher.dart';

import 'language_translate.dart';

class QuotesApp extends StatefulWidget {
  const QuotesApp({super.key});

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  final FlutterTts flutterTts = FlutterTts();
  List favList = [];
  int index = 0;
  String textToSpeak = "";
  Random rnd = Random();
  List randomData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //for speak
    configureTTS();
    //for permission
  }

  //for speak
  Future<void> configureTTS() async {
    await flutterTts.setLanguage(languageCode); // Set your desired language
    await flutterTts.setPitch(0.1); // Adjust pitch if needed
    await flutterTts.setSpeechRate(0.5); // Adjust speech rate if needed
  }

  Future<void> speakQuote({required String text}) async {
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop(); // Stop speaking when the screen is disposed
// Shutdown TTS engine
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade400,
        title: textToTrans(
          input: "Quote App",
        ),
        actions: [
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            },
          ),
          IconButton(
            icon: const Icon(Icons.feedback_outlined),
            onPressed: () {
              launchUrl(Uri.parse(
                  "https://play.google.com/store/search?q=chrome&c=apps&hl=en-IN"));
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: dataList.isEmpty
          ? const SizedBox()
          : [
              ListView.builder(
                itemCount: extraList["data"].length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 20,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87)),
                    child: Column(
                      children: [
                        textToTrans(
                          input: extraList["data"][index]["title"],
                          style: const TextStyle(
                              fontSize: 20, color: Colors.blueGrey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                extraList["data"][index]["fav"] =
                                    !extraList["data"][index]["fav"];
                                extraList["data"][index]["fav"] == true
                                    ? favList
                                        .add(extraList["data"][index]["title"])
                                    : favList.remove(
                                        extraList["data"][index]["title"]);
                                setState(() {});
                              },
                              icon: extraList["data"][index]["fav"] == false
                                  ? const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.blueGrey,
                                    )
                                  : const Icon(Icons.favorite),
                              color: Colors.red,
                            ),
                            IconButton(
                                onPressed: () {
                                  //copy
                                  Clipboard.setData(ClipboardData(
                                      text: extraList["data"][index]["title"]));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Quote copied to clipboard'),
                                    ),
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  color: Colors.blueGrey,
                                )),
                            IconButton(
                                onPressed: () {
                                  speakQuote(
                                      text: extraList["data"][index]["title"]);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.mic_outlined,
                                  color: Colors.blueGrey,
                                )),
                            IconButton(
                              onPressed: () {
                                ShareQuotes.shareQuote(
                                    quote: extraList["data"][index]["title"]);
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.share,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: false,
                itemCount: favList.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Center(
                    child: textToTrans(input: favList[index]),
                  );
                },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          languageCode = "en";
                          setState(() {});
                        },
                        child: const Text("English")),
                    ElevatedButton(
                        onPressed: () {
                          languageCode = "gu";
                          setState(() {});
                        },
                        child: const Text("Gujarati")),
                    ElevatedButton(
                        onPressed: () {
                          languageCode = "hi";
                          setState(() {});
                        },
                        child: const Text("Hindi")),
                  ],
                ),
              )
            ].elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.blueGrey.shade400,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.language), label: ""),
        ],
        onTap: (i) {
          index = i;
          setState(() {});
        },
      ),
    );
  }
}
