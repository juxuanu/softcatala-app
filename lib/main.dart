import 'package:flutter/material.dart';
import 'package:softcatala/colors.dart';
import 'package:softcatala/ui/dropdownlanguages.dart';
import 'package:softcatala/ui/textinput.dart';
import 'package:softcatala/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Traductor Softcatalà',
      home: HomePage(title: 'Traductor Softcatalà'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _langFrom = "";
  String _langTo = "";
  final TextEditingController _originTextController = TextEditingController();
  final TextEditingController _translatedTextController =
      TextEditingController();

  void _getTranslatedText() async {
    if (_originTextController.value.text.isEmpty) {
      return;
    }
    String result = await ServerAPI.translate(
        context: context,
        from: _langFrom,
        to: _langTo,
        text: _originTextController.text);
    setState(() {
      // Fill the translated text widget
      _translatedTextController.text = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _langFrom = "en";
    _langTo = "ca";
  }

  void _onLangSelected(SupportedLanguagePairs value) {
    setState(() {
      String pair = value.toString().split('.').last;
      _langTo = pair.split('_').last;
      _langFrom = pair.split('_').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: SoftcatalaColors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDownLanguages(onLangSelected: _onLangSelected),
                  TextButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: SoftcatalaColors.grey)),
                    ),
                    onPressed: _getTranslatedText,
                    child: Text(
                      "Tradueix",
                      style:
                          TextStyle(fontSize: 20, color: SoftcatalaColors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 40, 12, 20),
              child: TextInput(
                isInput: true,
                textController: _originTextController,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 40),
              child: TextInput(
                isInput: false,
                textController: _translatedTextController,
              ),
            ),
          )
        ],
      ),
    );
  }
}
