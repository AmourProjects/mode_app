import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        dark: ThemeData(
          primarySwatch: Colors.red,
          appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
        ),
          brightness: Brightness.dark,
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
              title: 'Flutter Dark and Light mode',
              theme: theme,
              darkTheme: darkTheme,
              home: const MyHomePage(title: 'Flutter Dark mode'),
            ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDarkMode = false;
  dynamic themeMode;
  String iconAdress = '';

  // @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    themeMode = await AdaptiveTheme.getThemeMode();
    if (themeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('Mode sombre');
      setState(() {
        isDarkMode = true;
        iconAdress = 'assets/icons/dark-mode.png';
      });
    } else {
      print('Mode clair');
      setState(() {
        isDarkMode = false;
        iconAdress = 'assets/icons/light-mode.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              child: iconAdress != '' ? Image.asset(iconAdress) : Container(),
            ),
            SizedBox(height: 40),
            Text(
              'Changer de mode',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              child: Text(
                'Vous pouvez changer le mode de votre interface en cliquant sur le bouton ci-dessous',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (isDarkMode == true) {
                    AdaptiveTheme.of(context).setLight();
                    iconAdress = 'assets/icons/light-mode.png';
                  } else {
                    AdaptiveTheme.of(context).setDark();
                    iconAdress = 'assets/icons/dark-mode.png';
                  }
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
                child: Text('Changer de mode')),
            SizedBox(height: 20),
            SwitchListTile(
                title: Text('Mode sombre'),
                // activeColor: Colors.red,
                value: isDarkMode,
                onChanged: (bool value) {
                  if (value == true) {
                    AdaptiveTheme.of(context).setDark();
                    iconAdress = 'assets/icons/dark-mode.png';
                  } else {
                    AdaptiveTheme.of(context).setLight();
                    iconAdress = 'assets/icons/light-mode.png';
                  }
                  setState(() {
                    isDarkMode = value;
                  });
                })
          ],
        ),
      ),
    );
  }
}
