import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'controllers/gsheets_package_controller.dart';
import 'views/add_user_using_package_view.dart';
import 'views/add_user_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await GoogleSheetsController.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppScript',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GFTabBarView(controller: tabController, children: <Widget>[
          MyHomePage(title: "Home"),
          AddDataUsingPackageView(title: "Add User",),
        ]),
        bottomNavigationBar: GFTabBar(
          length: 2,
          controller: tabController,
          tabBarHeight: 64.0,
          tabBarColor: Colors.deepPurple,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.description_rounded),
              child: const Text(
                'Using Script',
              ),
            ),
            Tab(
              icon: Icon(Icons.backpack_rounded),
              child: const Text(
                'Using Package',
              ),
            ),
          ],
        ));
  }
}

