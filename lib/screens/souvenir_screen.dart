import 'package:corcon/screens/opportunity_screen.dart';
import 'package:corcon/utils/data.dart';
import 'package:flutter/material.dart';

class SouvenirScreen extends StatefulWidget {
  const SouvenirScreen({Key? key}) : super(key: key);

  @override
  State<SouvenirScreen> createState() => _SouvenirScreenState();
}

class _SouvenirScreenState extends State<SouvenirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 60,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 30,
                        ),
                        child: const Text(
                          "Souvenir Opportunities",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.help),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: souvenirList.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${index + 1}.  ${souvenirList[index]['delegates']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '\nRate: ${souvenirList[index]['rate']}\nGST: ${souvenirList[index]['gst']}\nInclusive GST: ${souvenirList[index]['inclusiveGst']}\nRate USD: ${souvenirList[index]['rateUSD']}\n',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OpportunityScreen(
                                      data: souvenirList[index],
                                    )));
                          },
                          child: const Text('Register Now'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
