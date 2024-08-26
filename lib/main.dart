// lib/main.dart
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:innovators/presentation/pages/health_page.dart';
import 'package:innovators/presentation/pages/home_pages.dart';
import 'package:innovators/presentation/pages/light_mode.dart';
import 'package:innovators/presentation/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Curved Navigation Bar App',
          theme: themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: MainPage(),
        );
      },
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
int _pageIndex = 0;
GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
WebViewController? _webViewController;
String? _currentUrl;

void _openWebView(String url) {
  setState(() {
    _currentUrl = url;
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  });
}

@override
Widget build(BuildContext context) {
  final List<Widget> pages = [
    HomePage(openWebView: (url) => _openWebView(url)),
    LightModePage(),
    SettingsPage(),
    HealthPage(),
  ];

  return Scaffold(
    body: Column(
      children: [
        Expanded(
          child: pages[_pageIndex],
        ),
        if (_webViewController != null)
          Container(
            height: MediaQuery.of(context).size.height * 4 / 7,
            child: WebViewWidget(controller: _webViewController!),
          ),
      ],
    ),
    bottomNavigationBar: CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.lightbulb_outline, size: 30),
        Icon(Icons.settings, size: 30),
        Icon(Icons.mood, size: 30),
        Icon(Icons.favorite, size: 30),
      ],
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.blueAccent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _pageIndex = index;
        });
      },
      letIndexChange: (index) => true,
    ),
  );
}
}
