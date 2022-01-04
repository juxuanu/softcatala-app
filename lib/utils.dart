// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ServerAPI {
  static const String _APERTIUM_SERVER_URL =
      "https://www.softcatala.org/apertium/json/translate";
  static const String _NMT_SERVER_URL =
      "https://www.softcatala.org/sc/v2/api/nmt-engcat/translate";
  static const String _KEY = "NWI0MjQwMzQ2MzYyMzEzNjMyNjQ";

  /// Translate the given [text] from a language to another one
  ///
  /// - [text]: Text to be translated
  /// - [from]: ISO 639-2 language of [text]
  /// - [to]: ISO 639-2 language to translate [text] to
  ///
  /// The response follows this format:
  /// ```
  /// {
  ///  "responseStatus": 200,
  ///  "responseData": {
  ///      "translatedText": "Talk"
  ///  },
  ///  "time": "0:00:00.079905"
  /// }
  /// ```
  static Future<String> translate({
    required BuildContext context,
    required String text,
    required String from,
    required String to,
  }) async {
    String query = "";
    final http.Response? serverResponse;

    if ((from == "en" || from == "ca") && (to == "en" || to == "ca")) {
      // Use NMT server
      query += _NMT_SERVER_URL;
    } else {
      // Use Apertium
      query += _APERTIUM_SERVER_URL;
    }
    query += "?&markUnknown=yes&key=$_KEY&langpair=$from|$to&q=$text";

    try {
      serverResponse = await http.get(Uri.parse(query));
      if (serverResponse.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(serverResponse.body);
        return json['responseData']['translatedText'];
      }
    } catch (e) {
      showDialog(context: context, builder: _buildErrorPopupDialog);
      if (kDebugMode) {
        print("Error: " + e.toString());
      }
      return "Error" + e.toString();
    }
    return "== Error ==";
  }
}

Widget _buildErrorPopupDialog(BuildContext context) {
  return const AlertDialog(
    title: Text("Error en la comunicació amb el servidor."),
    scrollable: false,
  );
}

enum SupportedLanguagePairs {
  en_ca,
  es_ca,
  fr_ca,
  pt_ca,
  oc_ca,
  an_ca,
  ca_en,
  ca_es,
  ca_fr,
  ca_pt,
  ca_oc,
  ca_an,
}
