import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercarrentalapp/bloc/car_bloc.dart';
import 'package:fluttercarrentalapp/bloc/car_event.dart';
import 'package:fluttercarrentalapp/data/models/car.dart';
import 'package:fluttercarrentalapp/firebase_options.dart';
import 'package:fluttercarrentalapp/injection_container.dart';
import 'package:fluttercarrentalapp/pages/car_details_page.dart';
import 'package:fluttercarrentalapp/pages/car_list_page.dart';
import 'package:fluttercarrentalapp/pages/intro_page.dart';
import 'package:fluttercarrentalapp/pages/maps_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  initInjection();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CarBloc>()..add(LoadCars()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
        routes: {
          '/intro_page': (context) => const IntroPage(),
          '/car_list_page': (context) => CarListPage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/car_details_page') {
            final car = settings.arguments as Car;
            return MaterialPageRoute(
              builder: (context) {
                return CarDetailsPage(car: car);
              },
            );
          }
      
          if (settings.name == '/maps_details_page') {
            final car = settings.arguments as Car;
            return MaterialPageRoute(
              builder: (context) {
                return MapsDetailsPage(car: car);
              },
            );
          }
      
          return null;
        },
      ),
    );
  }
}
