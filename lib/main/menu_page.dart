// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrical/components/menus.dart';
import 'package:metrical/components/my_button.dart';
import 'package:metrical/provider/menu_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    var supabaseStream =
        Supabase.instance.client.from('Meals').stream(primaryKey: ['id']);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Whats your meal for the day?',
            style: GoogleFonts.alata(wordSpacing: 1),
          ),
          centerTitle: true,
          backgroundColor: Colors.tealAccent,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: StreamBuilder(
                stream: supabaseStream,
                builder: (context, snaps) {
                  if (!snaps.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  dynamic meal = snaps.data!;

                  return Expanded(
                    child: ListView.builder(
                      itemExtent: 300,
                      itemCount: meal.length,
                      itemBuilder: (context, index) {
                        final meals = meal[index];
                        return GestureDetector(
                          onDoubleTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        '${meals['img']}',
                                      ),
                                      Text(
                                          'Calorie result: ${meals['calorie']}'),
                                      MyButton(
                                        onPressed: () {
                                          // Add the meal to the menu provider
                                          final menuProvider =
                                              Provider.of<MenuProvider>(context,
                                                  listen: false);
                                          menuProvider.addMenu(meals);
                                          Navigator.pop(context);
                                        },
                                        label: Text('Select as your order'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                            // ListTile(
                            //   subtitle: Text(
                            //       '${meals['mealName']} \n ${meals['mealDescription']}'),
                            //   title: snaps.connectionState == ConnectionState.waiting
                            //       ? Center(
                            //           child: SpinKitFadingCube(
                            //           color: Colors.amber,
                            //           size: 30,
                            //         ))
                            //       : GestureDetector(
                            //           onDoubleTap: () {
                            //             showDialog(
                            //                 context: context,
                            //                 builder: (context) {
                            //                   return AlertDialog(
                            //                     content: Column(
                            //                       mainAxisSize: MainAxisSize.min,
                            //                       children: [
                            //                         Image.network(
                            //                           '${meals['img']}',
                            //                         ),
                            //                         Text(
                            //                             'Calorie result: ${meals['calorie']}'),
                            //                             MyButton(
                            //                           onPressed: () {
                            //                             // Add the meal to the cart
                            //                             final yourmeal = Provider.of<MenuProvider>(context, listen: false);
                            //                             yourmeal.addProduct(meals);
                            //                             Navigator.pop(context);
                            //                           },
                            //                           label: Text('Select as your order'),)
                            //                       ],
                            //                     ),
                            //                   );
                            //                 });
                            //           },
                            //           child: Card(
                            //             color: Colors.tealAccent,
                            //             elevation: 3,
                            //             shape: Border.all(
                            //               color: Colors.tealAccent,
                            //               width: 6,
                            //             ),
                            //             child: CachedNetworkImage(
                            //               imageUrl: '${meals['img']}',
                            //               placeholder: (context, url) => Center(
                            //                   child: SpinKitFadingCube(
                            //                 color: Colors.amber,
                            //                 size: 30,
                            //               )),
                            //             ),
                            //           ),
                            //         ),
                            // );
                          },
                          child: Menus(
                            image: meals['img'],
                            mealDescription: meals['mealDescription'],
                            title: meals['mealName'],
                          ),
                        );
                      },
                    ),
                  );
                })));
  }
}
