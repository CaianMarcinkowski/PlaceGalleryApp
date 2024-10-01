import 'package:flutter/material.dart';
import 'package:place_gallery/providers/great_places.dart';
import 'package:place_gallery/screens/place_detail_screen.dart';
import 'package:place_gallery/screens/place_form_screen.dart';
import 'package:place_gallery/screens/places_list_screen.dart';
import 'package:place_gallery/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Places Gallery',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.deepOrange,
              secondary: Colors.black87,
            ),
            scaffoldBackgroundColor: Colors.white),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.PLACES_FORM: (ctx) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAILS: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
