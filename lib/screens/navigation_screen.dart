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
    'Sponsor Opportunities',
    'Exhibitor Opportunities',
    'Advertisement Opportunities',
    'Delegate Opportunities',
    'Login',
    'FAQ'
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
                  GestureDetector(
                    onTap: () {},
                    child: const Image(
                      image: AssetImage(
                        './assets/icons/menu.png',
                      ),
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
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
                          child: Center(
                            child: Text(
                              items[index].toString(),
                              textAlign: TextAlign.center,
                              // overflow: TextOverfl,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
