import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String dropDownFrom = 'English';
  String dropDownTo = 'Urdu';
  String userInput = '';
  String result = '';

  List<String> availableLang = <String>[
    'English',
    'Urdu',
    'Arabic',
    'Hindi',
    'Bengali',
    'Japnease',
    'Korean',
    'French',
    'Russian',
    'Italian'
  ];
  List<String> countryCode = <String>[
    'en',
    'ur',
    'ar',
    'hi',
    'be',
    'ja',
    'ko',
    'fr',
    'ru',
    'it'
  ];
  resultTranslate() async {
    final translator = GoogleTranslator();
    translator.translate(userInput,
        from: countryCode[availableLang.indexOf(dropDownFrom)],
        to: countryCode[availableLang.indexOf(dropDownTo)]);
    var translation = await translator.translate(userInput,
        to: countryCode[availableLang.indexOf(dropDownTo)]);
    setState(() {
      result = translation.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translator'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'From: ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: DropdownButton<String>(
                            value: dropDownFrom,
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.brown,
                            ),
                            iconSize: 20,
                            elevation: 16,
                            style: TextStyle(color: Colors.brown, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: const Color.fromARGB(255, 99, 98, 98),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownFrom = newValue!;
                              });
                            },
                            items: availableLang
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text('$value'));
                            }).toList(),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'To: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: DropdownButton<String>(
                            value: dropDownTo,
                            icon: Icon(
                              Icons.arrow_downward,
                              color: Colors.blue,
                            ),
                            iconSize: 20,
                            elevation: 16,
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: const Color.fromARGB(255, 99, 98, 98),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropDownTo = newValue!;
                              });
                            },
                            items: availableLang
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text('$value'));
                            }).toList(),
                          ))
                    ],
                  ),
                  TextField(
                    maxLines: 5,
                    onChanged: (value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter something',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      resultTranslate();
                    },
                    height: 50,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Translate',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 2),
                        borderRadius: BorderRadius.circular(23)),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Result: ',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                        TextSpan(
                          text: '$result',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
