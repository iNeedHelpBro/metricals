/*

  Create Stats class to display statistics of the app.

 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:metrical/pages/log_in.dart';
import 'package:metrical/pages/profile_setting_page.dart';
import 'package:metrical/provider/menu_provider.dart';
import 'package:metrical/services/supabase_auth.dart';
import 'package:metrical/utils/dump.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final user = SupabaseAuth.instance.getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkScheme,
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(79, 225, 220, 206),
          child: ListView(
            children: [
              DrawerHeader(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: yellowScheme,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person,
                        size: 80,
                      ),
                      Text(
                        '$user',
                        style: GoogleFonts.nunitoSans(fontSize: 30),
                      )
                    ],
                  ),
                ),
              )),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    leading: Text(
                      'Settings',
                      style: GoogleFonts.nunitoSans(fontSize: 20),
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.settings,
                        color: yellowScheme,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileSettingPage()));
                      },
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Log Out',
                      style: GoogleFonts.nunitoSans(fontSize: 20),
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.logout_rounded,
                        color: yellowScheme,
                      ),
                      onTap: () async {
                        SupabaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: yellowScheme,
          title: Text(
            'Statistics',
            style: GoogleFonts.alata(wordSpacing: 1),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(itemExtent: 340, children: [
              buildRecentMeals(context),
              buildPieChart(),
            ])));
  }
}

Widget buildRecentMeals(BuildContext context) {
  final menu = Provider.of<MenuProvider>(context).menu;

  return menu.isEmpty
      ? const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 50),
          child: Center(
            child: Text('Your Recent Meals is empty'),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 340),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Your Recent Meals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemExtent: 240,
                    scrollDirection: Axis.horizontal,
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      final meal = menu[index];

                      return ListTile(
                        subtitle: Column(
                          children: [
                            Image.network(
                              '${meal['img']}',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              meal['mealName'],
                              style: GoogleFonts.alata(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
}

Widget buildPieChart() {
  var supabaseStream =
      Supabase.instance.client.from('Meals').stream(primaryKey: ['id']);
  return StreamBuilder(
    stream: supabaseStream,
    builder: (context, snaps) {
      if (!snaps.hasData) {
        return Center(
          child: SpinKitDualRing(color: yellowScheme),
        );
      }

      final meals = snaps.data!;

      final List<PieChartSectionData> sections =
          meals.map<PieChartSectionData>((meal) {
        return PieChartSectionData(
          color: _getColorForMeal(meal['id']),
          value: meal['calorie']?.toDouble() ?? 0.0,
          title: '${meal['calorie']} cal',
          radius: 50,
        );
      }).toList();

      return Card(
        elevation: 20,
        shape: Border.symmetric(horizontal: BorderSide(width: 2)),
        color: const Color.fromARGB(255, 249, 255, 214),
        child: Padding(
          padding: const EdgeInsets.only(right: 180),
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 50,
                sections: sections,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Color _getColorForMeal(int id) {
  const colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
  return colors[id % colors.length];
}
