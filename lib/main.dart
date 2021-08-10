import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_script_example/controllers/appScript_controller.dart';
import 'package:flutter_app_script_example/feedback_data_view.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Script Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  TextEditingController? _nameController;
  TextEditingController? _mobileNumberController;
  TextEditingController? _ageController;
  TextEditingController? _emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _mobileNumberController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController!.dispose();
    _ageController!.dispose();
    _mobileNumberController!.dispose();
    _emailController!.dispose();
  }

  saveForm() async{
    Map formData = {
      "name": _nameController!.text,
      "email": _emailController!.text,
      "mobileNo": _mobileNumberController!.text,
      "age": _ageController!.text
    };
    AppScriptController().saveForm(formData, callback);
    }


  callback(String response) {
    print("Response: $response");
    if (response == "SUCCESS") {
      _showSnackBar("Feedback Submitted");
    } else {
      // Error Occurred while saving data in Google Sheets.
      _showSnackBar("Error Occurred!");
    }
  }
  _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Name"),
              TextFormField(
                controller: _nameController,
              ),
              Text("Mobile Number"),
              TextFormField(
                controller: _mobileNumberController,
              ),
              Text("Age"),
              TextFormField(
                controller: _ageController,
              ),
              Text("Email"),
              TextFormField(
                controller: _emailController,
              ),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: saveForm, child: Text("Save Form")),
              SizedBox(height: 16,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeedBackDataView()));
              }, child: Text("Get Form Data"))
            ],
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
