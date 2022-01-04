import 'package:flutter/material.dart';
import 'package:softcatala/utils.dart';

class DropDownLanguages extends StatefulWidget {
  const DropDownLanguages({Key? key, required this.onLangSelected})
      : super(key: key);
  final Function(SupportedLanguagePairs) onLangSelected;

  @override
  _DropDownLanguagesState createState() => _DropDownLanguagesState();
}

class _DropDownLanguagesState extends State<DropDownLanguages> {
  late SupportedLanguagePairs selectedLang = SupportedLanguagePairs.en_ca;
  List<DropdownMenuItem<SupportedLanguagePairs>> _buildOptions() {
    return <DropdownMenuItem<SupportedLanguagePairs>>[
      // Idioma -> Català
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.en_ca,
        child: Text("Anglès → Català"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.fr_ca,
        child: Text("Francès → Català"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.es_ca,
        child: Text("Castellà → Català"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.oc_ca,
        child: Text("Occità/Aranès → Català"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.pt_ca,
        child: Text("Portuguès → Català"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.an_ca,
        child: Text("Aragonès → Català"),
      ),
      // Català -> Idioma
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.ca_en,
        child: Text("Català → Anglès"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.ca_fr,
        child: Text("Català → Francès"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.ca_es,
        child: Text("Català → Castellà"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.ca_oc,
        child: Text("Català → Occità/Aranès"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.ca_pt,
        child: Text("Català → Portuguès"),
      ),
      const DropdownMenuItem<SupportedLanguagePairs>(
        value: SupportedLanguagePairs.ca_an,
        child: Text("Català → Aragonès"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<SupportedLanguagePairs>(
      items: _buildOptions(),
      value: selectedLang,
      onChanged: (value) {
        if (value != null) {
          setState(() {
            selectedLang = value;
          });
          widget.onLangSelected(value);
        }
      },
    );
  }
}
