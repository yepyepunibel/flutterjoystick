import 'package:flutter/material.dart';

enum Yonler { yukari, asagi, saga, sola }
enum JoyistickMode { hepsi, sadeceDikey, sadeceYatay }

class Joystick extends StatefulWidget {
  final Color arkaplanRengi;
  final Color ikonRengi;
  final double saydamlik;
  final String kelime;
  final double boyut;
  final bool tasinabilirmi;
  final JoyistickMode kullanilabilinenler;
//callbacks
  final VoidCallback tiklaYukari;
  final VoidCallback tiklaAsagi;
  final VoidCallback tiklaSola;
  final VoidCallback tiklaSaga;
  final Function(Yonler) nereTiklandi;

  Joystick({
    this.arkaplanRengi,
    this.saydamlik,
    this.kullanilabilinenler,
    this.tasinabilirmi,
    this.ikonRengi,
    this.kelime,
    @required this.boyut,
    this.tiklaYukari,
    this.tiklaSaga,
    this.tiklaSola,
    this.tiklaAsagi,
    this.nereTiklandi,
  })  : assert(boyut != null),
        assert(tasinabilirmi != null); //zorunlu alan, boş bırakılırsa bağır :);
  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double _x = 0.0;
  double _y = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: _x,
          right: _y,
          child: Container(
            height: widget.boyut,
            width: widget.boyut,
            decoration: BoxDecoration(
                color:
                    widget.arkaplanRengi.withOpacity(widget.saydamlik ?? 1) ??
                        Colors.grey.withOpacity(widget.saydamlik ?? 1),
                shape: BoxShape.circle),
            child: Column(
              children: [
                //up
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        child: widget.kullanilabilinenler ==
                                JoyistickMode.sadeceYatay
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: widget.ikonRengi,
                                ),
                                tooltip: "Önceki Galeri...",
                                onPressed: () {
                                  if (widget.tiklaYukari != null)
                                    widget.tiklaYukari();
                                  if (widget.nereTiklandi != null)
                                    widget.nereTiklandi(Yonler.yukari);
                                },
                              ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ), //middle
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: widget.kullanilabilinenler ==
                                JoyistickMode.sadeceDikey
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_left,
                                  color: widget.ikonRengi,
                                ),
                                tooltip: "Önceki resim...",
                                onPressed: () {
                                  if (widget.tiklaSaga != null)
                                    widget.tiklaSaga();
                                  if (widget.nereTiklandi != null)
                                    widget.nereTiklandi(Yonler.saga);
                                },
                              ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: GestureDetector(
                            child: Center(
                              child: Text(
                                widget.kelime,
                                style: TextStyle(
                                    color: widget.ikonRengi,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPanUpdate: (_value) {
                              if (widget.tasinabilirmi) {
                                setState(() {
                                  _x -= _value.delta.dy;
                                  _y -= _value.delta.dx;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: widget.kullanilabilinenler ==
                                JoyistickMode.sadeceDikey
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: widget.ikonRengi,
                                ),
                                tooltip: "Sonraki resim...",
                                onPressed: () {
                                  if (widget.tiklaSola != null)
                                    widget.tiklaSola();
                                  if (widget.nereTiklandi != null)
                                    widget.nereTiklandi(Yonler.sola);
                                },
                              ),
                      ),
                    ],
                  ),
                ), //down
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        child: widget.kullanilabilinenler ==
                                JoyistickMode.sadeceYatay
                            ? SizedBox()
                            : IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: widget.ikonRengi,
                                ),
                                tooltip: "Sonraki Galeri...",
                                onPressed: () {
                                  if (widget.tiklaAsagi != null)
                                    widget.tiklaAsagi();
                                  if (widget.nereTiklandi != null)
                                    widget.nereTiklandi(Yonler.asagi);
                                },
                              ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
