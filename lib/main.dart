import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:local_sell/auth/auth.dart';
import 'package:local_sell/components/constants.dart';
import 'package:local_sell/firebase_options.dart';
import 'package:local_sell/pages/cart_page.dart';
import 'package:local_sell/pages/favorites_page.dart';
import 'package:local_sell/pages/product_upload.dart';
import 'package:local_sell/pages/profile.dart';
import 'package:local_sell/pages/shop.dart';
import 'package:local_sell/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const AuthPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/bag.png",
              height: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Urban Stride",
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.grey.shade100),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Style beyond boundaries",
              style: GoogleFonts.lato(
                color: Colors.grey.shade200,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Shop())),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  List<Widget> pages = [
    const Shop(),
    const CartPage(),
    const UploadPage(),
    const FavoritesPage(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: pages[selectedIndex],
      bottomNavigationBar: GNav(
          activeColor: Colors.red,
          tabBackgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
          selectedIndex: selectedIndex,
          onTabChange: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          tabs: [
            GButton(
              icon: Icons.home_outlined,
              iconColor: Colors.grey.shade400,
            ),
            GButton(
              icon: Icons.shopping_bag_outlined,
              iconColor: Colors.grey.shade400,
            ),
            GButton(
              icon: Icons.cloud_upload_outlined,
              iconColor: Colors.grey.shade400,
            ),
            GButton(
              icon: Icons.favorite_outline,
              iconColor: Colors.grey.shade400,
            ),
            GButton(
              icon: Icons.person_3_outlined,
              iconColor: Colors.grey.shade400,
            )
          ]),
    );
  }
}
