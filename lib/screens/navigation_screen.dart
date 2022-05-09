import 'package:corcon/screens/delegate_screen.dart';
import 'package:corcon/screens/exhibitor_screen.dart';
import 'package:corcon/screens/login_screen.dart';
import 'package:corcon/screens/souvenir_screen.dart';
import 'package:corcon/screens/sponsor_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List items = [
    {'title': 'Sponsor Opportunities', 'icon': Icons.monetization_on},
    {'title': 'Exhibitor Opportunities', 'icon': Icons.display_settings},
    {
      'title': 'Advertisement Opportunities',
      'icon': Icons.photo_size_select_actual
    },
    {'title': 'Delegate Opportunities', 'icon': Icons.person},
    {'title': 'Login', 'icon': Icons.login},
    {'title': 'FAQ', 'icon': Icons.help}
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff152238),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Corcon 2022",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              height: size.height,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SponsorScreen()));
                        }
                        if (index == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ExhibitorScreen()));
                        }
                        if (index == 2) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SouvenirScreen()));
                        }
                        if (index == 3) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DelegateScreen()));
                        }
                        if (index == 4) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        }
                      },
                      child: Card(
                        color: const Color(0xffffffff),
                        // color: const Color(0xffd5d5d5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ,
                            Icon(
                              items[index]['icon'],
                              size: 32,
                              color: const Color(0xff152238),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              items[index]['title'].toString(),
                              textAlign: TextAlign.center,
                              // overflow: TextOverfl,
                            ),
                          ],
                        ),
                      ),
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
}
