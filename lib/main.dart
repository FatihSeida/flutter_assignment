// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final pertanyaanController = TextEditingController();
  final jawabanController = TextEditingController();
  final kataKunciController = TextEditingController();
  String kataKunci = "";
  String jawaban = "";

  static int noOfCharacter = 256;
  int maxOfAnB(int a, int b) => (a > b) ? a : b;

  List<int> badCharacterHeuristic(String str) {
    List<int> badChar = new List<int>(noOfCharacter);
    int i;

    for (i = 0; i < noOfCharacter; i++) {
      badChar[i] = -1;
    }

    for (i = 0; i < str.length - 1; i++) {
      var index = str.indexOf(str[i]);
      badChar[index] = i;
    }
    return badChar;
  }

  // A kataKunci searching function
  void search(String jawaban, String kataKunci) {
    int m = kataKunci.length - 1;
    int n = jawaban.length - 1;

    List<int> badchar = badCharacterHeuristic(kataKunci);

    int s = 0;
    while (s <= (n - m)) {
      int j = m - 1;
      while (j >= 0 && kataKunci[j] == jawaban[s + j]) {
        Text(kataKunci[j]);
        Text(jawaban[s + j]);
        j--;
      }
      if (j < 0) {
        print("kataKunci occur at shift = $s");
        var index = jawaban.indexOf(jawaban[s + m]);
        s += (s + m < n) ? m - badchar[index] : 1;
      } else {
        var index = jawaban.indexOf(jawaban[s + j]);
        s += maxOfAnB(1, j - badchar[index]);
      }
    }
  }

  @override
  void dispose() {
    pertanyaanController.dispose();
    jawabanController.dispose();
    kataKunciController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).cursorColor;
    const sizedBoxSpace = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Assignment'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            sizedBoxSpace,
            TextFormField(
              controller: pertanyaanController,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Pertanyaan',
                labelText: 'Pertanyaan',
              ),
            ),
            sizedBoxSpace,
            TextFormField(
              controller: jawabanController,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Jawaban',
                labelText: 'Jawaban',
              ),
            ),
            sizedBoxSpace,
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Text(
                    jawaban,
                  ),
                ],
              ),
            ),
            sizedBoxSpace,
            TextFormField(
              controller: kataKunciController,
              cursorColor: cursorColor,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Kata Kunci',
                labelText: 'Kata Kunci',
              ),
            ),
            sizedBoxSpace,
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  Text(
                    kataKunci,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      setState(() {
                        jawaban = jawabanController.text;
                        kataKunci = kataKunciController.text;
                        search(jawaban, kataKunci);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
