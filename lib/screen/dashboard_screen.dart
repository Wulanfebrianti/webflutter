import 'package:flutter/material.dart';
import '../config/pallete.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: Palette.activeColor,
            unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(1)),
            unselectedLabelTextStyle: TextStyle(color: Colors.white.withOpacity(1)),
            selectedIconTheme: IconThemeData(color: Palette.backgroundColor),
            destinations: [ 
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.bar_chart),
              label: Text('Raport'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              label: Text('Profile'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),NavigationRailDestination(
              icon: Icon(Icons.login),
              label: Text('Login'),
            ),
          ],
          selectedIndex: 0
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(60),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/60202674?v=4',),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.article_outlined, size: 26,),
                                    SizedBox(width: 15,),
                                    Text('Articles', style: TextStyle(fontSize: 26, fontWeight : FontWeight.bold, fontFamily: 'roboto'),)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text('12 Articles', style: TextStyle(fontSize: 46, fontWeight : FontWeight.bold, fontFamily: 'roboto'),)
                              ],
                            ),
                          ),
                        )),
                        Flexible(child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.comment, size: 26,),
                                    SizedBox(width: 15,),
                                    Text('Comments', style: TextStyle(color: Palette.check2,fontSize: 26, fontWeight : FontWeight.bold, fontFamily: 'roboto'),)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text('+12 Comments', style: TextStyle(fontSize: 46, fontWeight : FontWeight.bold, fontFamily: 'roboto', color: Palette.check2),)
                              ],
                            ),
                          ),
                        )),
                        Flexible(child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.people, size: 26,),
                                    SizedBox(width: 15,),
                                    Text('Subscribers', style: TextStyle(color: Palette.check,fontSize: 26, fontWeight : FontWeight.bold, fontFamily: 'roboto'),)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text('3.2M Subscribers', style: TextStyle(fontSize: 46, fontWeight : FontWeight.bold, fontFamily: 'roboto', color: Palette.check),)
                              ],
                            ),
                          ),
                        )),
                        Flexible(child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on_outlined, size: 26,),
                                    SizedBox(width: 15,),
                                    Text('Revenue', style: TextStyle(color: Palette.primary,fontSize: 26, fontWeight : FontWeight.bold, fontFamily: 'roboto'),)
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Text('12 Revenue', style: TextStyle(fontSize: 46, fontWeight : FontWeight.bold, fontFamily: 'roboto', color: Palette.primary),)
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              )
          ))
        ],
      )
    );
  }
}