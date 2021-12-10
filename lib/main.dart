import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trans_mobile/back/model.dart';
import 'package:trans_mobile/front/festival_page.dart';

/// Main
/// @author Julien Cochet

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TransModel(),
        child: MaterialApp(
          title: 'Les Trans',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const FestivalPage(title: 'Festival'),
        ));
  }
}
