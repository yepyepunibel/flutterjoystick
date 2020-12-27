import 'package:flutter/material.dart';
import 'joystick.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int secilengaleri = 0;
  int secilenresim = 0;
  @override
  Widget build(BuildContext context) {
    List<List<String>> galeri = [
      [
        "kuslar/ku1.jpg",
        "kuslar/ku2.jpg",
        "kuslar/ku3.jpg",
      ],
      [
        "/kopekler/ko1.jpg",
        "/kopekler/ko2.jpg",
        "/kopekler/ko3.jpg",
      ],
      [
        "/kediler/k1.jpg",
        "/kediler/k2.jpg",
        "/kediler/k3.jpg",
      ],
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(galeri[secilengaleri][secilenresim]),
            fit: BoxFit.cover,
          ),
        ),
        child: Joystick(
          saydamlik: 0.5,
          kelime: "< Taşı >",
          tasinabilirmi: true,
          arkaplanRengi: Colors.yellow,
          ikonRengi: Colors.black,
          boyut: 150,
          tiklaYukari: () {
            if (secilengaleri > 0)
              setState(() {
                secilengaleri -= 1;
              });
          },
          tiklaSaga: () {
            if (secilenresim > 0)
              setState(() {
                secilenresim -= 1;
              });
          },
          tiklaSola: () {
            if (secilenresim + 1 < galeri[secilengaleri].length)
              setState(() {
                secilenresim += 1;
              });
          },
          tiklaAsagi: () {
            if (secilengaleri + 1 < galeri.length)
              setState(() {
                secilengaleri = secilengaleri + 1;
              });
          },
          nereTiklandi: (_gelen) {
            print(_gelen);
          },
          kullanilabilinenler: JoyistickMode.hepsi,
        ),
      ),
      appBar: AppBar(
        title: Text("Galeri"),
      ),
    );
  }
}
