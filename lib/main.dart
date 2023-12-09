import 'package:expenses_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/dark_mode_prov.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((_) =>  runApp(const MyApp()),);
 
}
var mycolorschem= ColorScheme.fromSeed(seedColor:Colors.teal.shade800);
var myDarkcolorschem= ColorScheme.fromSeed(seedColor:Colors.teal.shade800);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 8, 49, 17),brightness:
          themeProvider.isDarkMode?Brightness.dark: Brightness.light,
           
           ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const Expenses() ,
      );
        },
      ),
    );
    
  }
}



