import 'package:flutter/material.dart';
import '../controllers/appScript_controller.dart';

import 'feedback_data_view.dart';

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

  final formKey = GlobalKey<FormState>();

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
    FocusManager.instance.primaryFocus!.unfocus();
    final form = formKey.currentState;

    final isValid = form!.validate();
    if(isValid) {
      Map formData = {
        "name": _nameController!.text,
        "email": _emailController!.text,
        "mobileNo": _mobileNumberController!.text,
        "age": _ageController!.text
      };
      AppScriptController().saveForm(formData, callback);
    }
  }


  callback(String response) {
    if (response == "SUCCESS") {
      clearAllTextFields();
      _showSnackBar("Data Saved Successfully");
    } else {
      // Error Occurred while saving data in Google Sheets.
      _showSnackBar("Error Occurred!");
    }
  }

  clearAllTextFields(){
    _nameController!.clear();
    _ageController!.clear();
    _mobileNumberController!.clear();
    _emailController!.clear();
  }

  _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message),backgroundColor: Colors.deepPurple,behavior: SnackBarBehavior.floating,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 32.0,),
                  GetTextWidget(text: "Name"),
                  GetTextFormFieldWidget.getTextFormField(formFieldController: _nameController,keyboardType: TextInputType.text,hintText: "Enter Name Here",
                      validator: (value) => value != null && value.isEmpty ? "Enter name":null),
                  GetTextWidget(text: "Mobile Number"),
                  GetTextFormFieldWidget.getTextFormField(formFieldController: _mobileNumberController,keyboardType: TextInputType.numberWithOptions(),hintText: "Enter Mobile Number Here",
                      validator: (value) => ((value != null && value.isEmpty)&& (value.length >9 &&value.length<12) )? "Enter Mobile Number": null),
                  GetTextWidget(text: "Age"),
                  GetTextFormFieldWidget.getTextFormField(formFieldController: _ageController,keyboardType: TextInputType.numberWithOptions(),hintText: "Enter Age Here",
                      validator: (value) => value != null && value.isEmpty ? "Enter Age":null),
                  GetTextWidget(text: "Email"),
                  GetTextFormFieldWidget.getTextFormField(formFieldController: _emailController,keyboardType: TextInputType.emailAddress,hintText: "Enter Email Here",
                      validator: (value) => value != null && !value.contains("@") ? "Enter Email":null),
                  SizedBox(height: 32,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(onPressed: saveForm, child: Text("Save User"),style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 12.0),
                        primary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                    )),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(onPressed: (){
                      FocusManager.instance.primaryFocus!.unfocus();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeedBackDataView()));
                    }, child: Text("Get Users"),style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 12.0),
                        primary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class GetTextWidget extends StatelessWidget {
  const GetTextWidget({Key? key,required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),
          child: Text(text));
    }
}

class GetTextFormFieldWidget {

  static Widget getTextFormField({FormFieldValidator<String>? validator,Function? editingComplete,TextEditingController? formFieldController,String? hintText,
    int? maxLines,TextInputType? keyboardType,Function? onChanged,FocusNode? focus}
      ){
    return Container(
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: formFieldController,
        maxLines: maxLines,
        autocorrect: true,
        focusNode: focus,
        style: TextStyle(fontSize: 14.0,color:const Color(0xff292929) ),
        decoration: new InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black12,style: BorderStyle.solid,width: 1.0),),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black12,style: BorderStyle.solid,width: 1.0),),
          errorStyle: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w400,color: Colors.red),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black12,style: BorderStyle.solid,width: 1.0),),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black12,style: BorderStyle.solid,width: 1.0),),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black12,style: BorderStyle.solid,width: 1.0),),
          border: OutlineInputBorder(
            borderRadius:BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.red,style: BorderStyle.none,),),
          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
          filled: true,
          fillColor: Color(0xFFF2F3F7),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.0,color:const Color(0xff94979B),fontFamily: 'Quicksand',fontWeight: FontWeight.w300),
        ),
        keyboardType: keyboardType,
        cursorColor: Colors.blue,
      ),
    );
  }
}
