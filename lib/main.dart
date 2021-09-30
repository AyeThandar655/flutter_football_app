import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'football.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
  fontWeight: FontWeight.bold
);

const kLabelTextStyle1 = TextStyle(
  fontSize: 16.0,
  color: Colors.white,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/splash.png"),
          ),
        ),
      )
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Football> _fetchData() async {
    final url = Uri.parse(
        'https://doubleaagent-84973-default-rtdb.asia-southeast1.firebasedatabase.app/data.json');
    final response = await http.get(url);

    print(response.body);
    Football data2 = Football.fromJson(jsonDecode(response.body));
    print("Data2 : >>> $data2");
    return data2;
  }

  _matchList(league) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: league.matches.length,
        itemBuilder: (context, mIndex) {
          Match match = league.matches[mIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 2,
                    color: Colors.black12,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            match.image1,
                            width: 30,
                            height: 30,
                            fit:BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 40),
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            match.image2,
                            width: 30,
                            height: 30,
                            fit:BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.only(left: 5.0,right: 5.0),
                               child: new Text( match.team1,
                                 textAlign: TextAlign.center,
                                 style: kLabelTextStyle1,),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(8),
                          ),
                          primary: Colors.red,
                        ),
                        icon: Icon(Icons.play_circle_fill_outlined),
                        label: Text('Play'),
                        onPressed: () async {
                          String url = league.matches[mIndex].url;
                          var urlLaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                          if (urlLaunchable) {
                            await launch(url); //launch is from url_launcher package to launch URL
                          } else {
                            print("URL can't be launched.");
                          }
                        },
                      ),
                      Expanded(
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.only(left: 5.0,right: 5.0),
                              child: new Text(
                                match.team2,
                                textAlign: TextAlign.center,
                                style: kLabelTextStyle1,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        body: SafeArea(
          child: Column(children: [
            Column(
              children: <Widget>[
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/ads.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                    primary: Colors.lightBlue[800],
                  ),
                  onPressed: () {
                    setState(() {
                      _fetchData();
                    });
                  },
                  icon: Icon(Icons.refresh_outlined),
                  label: Text('Refresh'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8),
                    ),
                    primary: Colors.lightBlue[800],
                  ),
                  onPressed: () async {
                    String url = "https://ibet789.com/";
                    var urlLaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                    if (urlLaunchable) {
                      await launch(url); //launch is from url_launcher package to launch URL
                    } else {
                      print("URL can't be launched.");
                    }
                  },
                  icon: Icon(Icons.info_sharp),
                  label: Text('ibet789.com - Live Odds'),
                ),
               FutureBuilder<Football>(
                  future: _fetchData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Football> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        //height: 340,
                        height:MediaQuery.of(context).size.height * 0.5,  //10% of screen height
                        child: ListView.builder(
                            itemCount: snapshot.data!.league.length,
                            itemBuilder: (context, lIndex) {
                              League league = snapshot.data!.league[lIndex];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 10),
                                child: Card(
                                  elevation: 2,
                                  color: Colors.lightBlue[800],
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        league.title,
                                        style: kLabelTextStyle,
                                      ),
                                      _matchList(league),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8.0),
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 20),
                            Text("LOADING DATA..."),
                          ],
                        ),
                      );
                  },
                ),
              ],
            ),
            //_ListView(context),
          ]),
        ),
      ),
    );
  }
}
