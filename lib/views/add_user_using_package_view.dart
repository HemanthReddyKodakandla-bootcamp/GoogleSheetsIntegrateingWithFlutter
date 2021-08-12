import 'package:flutter/material.dart';
import '../controllers/gsheets_package_controller.dart';
import '../modals/user_fields.dart';
import 'user_view.dart';

import 'add_user_view.dart';

class AddDataUsingPackageView extends StatefulWidget {
  const AddDataUsingPackageView({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  _AddDataUsingPackageViewState createState() => _AddDataUsingPackageViewState();
}

class _AddDataUsingPackageViewState extends State<AddDataUsingPackageView> {

    late TextEditingController? _nameController;
    late TextEditingController? _mobileNumberController;
    late TextEditingController? _ageController;
    late TextEditingController? _emailController;

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

      final form = formKey.currentState;

      final isValid = form!.validate();
      if(isValid){
        final user = {
          UserFields.name : _nameController!.text,
          UserFields.mobileNumber: _mobileNumberController!.text,
          UserFields.email: _emailController!.text,
          UserFields.age: _ageController!.text
        };
        final status = await GoogleSheetsController.insert([user]);
        _showSnackBar(status);
      }
    }


    clearAllTextFields(){
      _nameController!.clear();
      _ageController!.clear();
      _mobileNumberController!.clear();
      _emailController!.clear();
    }

    _showSnackBar(bool status) {
      final snackBar = SnackBar(content: Text(status ? 'User Added Successfully' : "Failed to Add user"),backgroundColor: status ? Colors.green : Colors.red,behavior: SnackBarBehavior.floating,);
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
                      child: ElevatedButton(onPressed: () async{
                        FocusManager.instance.primaryFocus!.unfocus();
                        saveForm();
                      }, child: Text("Save User"),style: ElevatedButton.styleFrom(
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserView()));
                      }, child: Text("View Users"),style: ElevatedButton.styleFrom(
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
