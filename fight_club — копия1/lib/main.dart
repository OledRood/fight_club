import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.pressStart2pTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attacingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(213, 222, 240, 1),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("You"),
                    SizedBox(
                      height: 13,
                    ),
                    Text("1"),
                    Text("1"),
                    Text("1"),
                    Text("1"),
                    Text("1"),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text("Enemy"),
                    SizedBox(
                      height: 13,
                    ),
                    Text("1"),
                    Text("1"),
                    Text("1"),
                    Text("1"),
                    Text("1"),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text("Defeand".toUpperCase()),
                    SizedBox(
                      height: 13,
                    ),
                    BodyPartButton(
                        bodyPart: BodyPart.head,
                        selected: defendingBodyPart == BodyPart.head,
                        BodyPartSetter: _selectDefendingBodyPart),
                    SizedBox(
                      height: 14,
                    ),
                    BodyPartButton(
                        bodyPart: BodyPart.torso,
                        selected: defendingBodyPart == BodyPart.torso,
                        BodyPartSetter: _selectDefendingBodyPart),
                    SizedBox(
                      height: 14,
                    ),
                    BodyPartButton(
                        bodyPart: BodyPart.legs,
                        selected: defendingBodyPart == BodyPart.legs,
                        BodyPartSetter: _selectDefendingBodyPart),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(children: [
                  Text("Atack".toUpperCase()),
                  SizedBox(
                    height: 13,
                  ),
                  BodyPartButton(
                    bodyPart: BodyPart.head,
                    selected: attacingBodyPart == BodyPart.head,
                    BodyPartSetter: _selectAttacingBodyPart,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  BodyPartButton(
                    bodyPart: BodyPart.torso,
                    selected: attacingBodyPart == BodyPart.torso,
                    BodyPartSetter: _selectAttacingBodyPart,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: attacingBodyPart == BodyPart.legs,
                      BodyPartSetter: _selectAttacingBodyPart),
                ]),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (attacingBodyPart != null && defendingBodyPart != null) {
                    setState(() {
                      attacingBodyPart = null;
                      defendingBodyPart = null;
                    });
                  }
                },
                child: SizedBox(
                  height: 40,
                  child: ColoredBox(
                    color:
                        (attacingBodyPart != null && defendingBodyPart != null)
                            ? Colors.black
                            : Color.fromRGBO(0, 0, 0, 0.38),
                    child: Center(
                      child: Text(
                        "Go".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttacingBodyPart(final BodyPart value) {
    setState(() {
      attacingBodyPart = value;
    });
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final bool selected;
  final ValueSetter<BodyPart> BodyPartSetter;
  final BodyPart bodyPart;

  const BodyPartButton({
    required this.bodyPart,
    super.key,
    required this.selected,
    required this.BodyPartSetter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? const Color.fromRGBO(28, 121, 206, 1)
              : Color.fromRGBO(0, 0, 0, 0.38),
          child: Center(
              child: Text(
            bodyPart.name.toUpperCase(),
            style: TextStyle(
                color: selected
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : Color.fromRGBO(6, 13, 20, 1)),
          )),
        ),
      ),
    );
  }
}
