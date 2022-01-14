import 'dart:convert';
import 'dart:io';

import 'package:flutter_budget_tracker/api/models/failure_model.dart';
import 'package:flutter_budget_tracker/api/models/item_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class BudgetService {
  static const String _prefix = 'https://api.notion.com/v1/';

  final http.Client _client;

  BudgetService({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<ItemModel>> getItems() async {
    try {
      final String url =
          '${_prefix}databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      final Uri uri = Uri.parse(url);
      final response = await _client.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2021-08-16',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List)
            .map((result) => ItemModel.fromJSON(result))
            .toList()
          ..sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));
      } else {
        throw const FailureModel(
          message: 'Something went wrong!',
          statusCode: 400,
        );
      }
    } catch (err) {
      print(err);
      throw const FailureModel(
        message: 'Something went wrong!',
        statusCode: 400,
      );
    }
  }
}