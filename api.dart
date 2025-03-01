import 'package:http/http.dart' as http;
import 'package:quotes_of_the_day/quotes_model.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Api {
  static const String baseurl = 'https://zenquotes.io/api/';

  static Future<QuotesModel> fetchRandomQuotes() async {
    final response = await http.get(Uri.parse("${baseurl}random"));
    debugPrint('API response: ${response.body}');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return QuotesModel.fromJson(data[0]);
    } else {
      throw Exception('Failed to load Quotes');
    }
  }
}
