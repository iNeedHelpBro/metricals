/*

  Create Stats class to display statistics of the app.

 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:metrical/provider/menu_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text('Statistics', style: GoogleFonts.alata(wordSpacing: 1)),
          centerTitle: true,
        ),
        body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [buildRecentMeals(context), buildPieChart()]));
  }
}

//Display the recent meals when user or customer chooses a meal from the menu page.
Widget buildRecentMeals(BuildContext context) {
  final menu = Provider.of<MenuProvider>(context).menu;

  return menu.isEmpty
      ? const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 50),
          child: Center(
            child: Text('Your Recent Meals are empty'),
          ),
        )
      : Expanded(
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
        );
}

Widget buildPieChart() {
  var supabaseStream =
      Supabase.instance.client.from('Meals').stream(primaryKey: ['id']);
  return StreamBuilder(
    stream: supabaseStream,
    builder: (context, snaps) {
      if (!snaps.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
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
        color: const Color.fromARGB(255, 173, 171, 162),
        child: AspectRatio(
          aspectRatio: 2,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 20,
              sections: sections,
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
