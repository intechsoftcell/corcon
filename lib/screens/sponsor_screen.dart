import 'package:corcon/screens/paper_detail_screen.dart';
import 'package:corcon/utils/data.dart';
import 'package:flutter/material.dart';

class SponsorScreen extends StatefulWidget {
  const SponsorScreen({Key? key}) : super(key: key);

  @override
  State<SponsorScreen> createState() => _SponsorScreenState();
}

class _SponsorScreenState extends State<SponsorScreen> {
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
                          "Sponsor Opportunities",
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
                itemCount: sponsorList.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${index + 1}.  ${sponsorList[index]['category']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '\n${sponsorList[index]['benefits']}\nWithout Accomodation: ${sponsorList[index]['withoutAccomodation']}\nTriple Sharing: ${sponsorList[index]['tripleSharing']}\nDouble Sharing: ${sponsorList[index]['doubleSharing']}\nSingle Sharing: ${sponsorList[index]['singleSharing']}\nRate USD: ${sponsorList[index]['rateUSD']}\n',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaperDetailScreen(
                                      data: sponsorList[index],
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
