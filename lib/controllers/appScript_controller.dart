import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_script_example/modals/list_view_modal.dart';
import 'package:http/http.dart' as http;

class AppScriptController {


  static const String url = "https://script.google.com/macros/s/AKfycbzusPaWHOsZS_9KrqRtffLMJNPXLxkIU3jNQhxPmOZR2Mc5eLJFcG3XtLMZo8WHP1eaGw/exec";

  saveForm(Map formData,void Function(String) callback) async {

    try {
      await http.post(Uri.parse(url), body: formData).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }


  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<ListViewModal>> getFeedbackList() async {
    return await http.get(Uri.parse(url)).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      List<ListViewModal> viewData = listViewModalFromMap(convert.jsonEncode(jsonFeedback));
      return viewData;
    });
  }
}