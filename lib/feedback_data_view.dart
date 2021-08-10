import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_script_example/controllers/appScript_controller.dart';

import 'modals/list_view_modal.dart';


class FeedBackDataView extends StatefulWidget {
  const FeedBackDataView({Key? key}) : super(key: key);

  @override
  _FeedBackDataViewState createState() => _FeedBackDataViewState();
}

class _FeedBackDataViewState extends State<FeedBackDataView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FeedBack View"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: AppScriptController().getFeedbackList(),
            builder: (context, AsyncSnapshot<List<ListViewModal>> snapshot){
              if(snapshot.hasError){
                return Container(
                  alignment: Alignment.center,
                  child: Text("Error"),
                );
              }else if(snapshot.hasData){
                return Expanded(
                  child: ListView(
                    children: List.generate(snapshot.data!.length, (index) => EmployeeCard(snapshot.data![index])),
                  ),
                );
              }else{
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.deepPurple,
                        color: Colors.yellow,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.deepPurple
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('Getting Data...'),
                          WavyAnimatedText('Please Wait...'),
                        ],
                        isRepeatingAnimation: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    )
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
class EmployeeCard extends StatelessWidget {

  final ListViewModal employee;

  EmployeeCard(this.employee);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle
      ),
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new NetworkImage("https://image.flaticon.com/icons/png/128/3135/3135715.png"),
        height: 92.0,
        width: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(
        fontFamily: 'Quicksand'
    );

    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400
    );
    final subHeaderTextStyle = regularTextStyle.copyWith(
        fontSize: 12.0,color: new Color(0xFFF0EDFD)
    );
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w600
    );



    final cardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text("${employee.name}", style: headerTextStyle),
          new Container(height: 10.0),
          new Text("${employee.email}", style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)
          ),
          new Row(
            children: <Widget>[
              Icon(Icons.phone,size: 12.0,color: Colors.white,),
              Text(" ${employee.mobileNo}",style: subHeaderTextStyle,)
            ],
          ),
        ],
      ),
    );


    final employeeCard = new Container(
      child: cardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff8B78FF),Color(0xff5451D6).withOpacity(0.8)]),
        // color:  Color(0xFF5451D6).withOpacity(0.8),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.deepPurple.shade300,
            blurRadius: 5.0,
            offset: new Offset(0.0, 0.5),
          ),
        ],
      ),
    );


    return new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            employeeCard,
            planetThumbnail,
          ],
        )
    );
  }
}

