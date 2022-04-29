import 'package:corcon/screens/paper_detail_screen.dart';
import 'package:corcon/utils/data.dart';
import 'package:flutter/material.dart';

class ExhibitorScreen extends StatefulWidget {
  const ExhibitorScreen({Key? key}) : super(key: key);

  @override
  State<ExhibitorScreen> createState() => _ExhibitorScreenState();
}

class _ExhibitorScreenState extends State<ExhibitorScreen> {
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
                          "Exhibitor Opportunities",
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
                itemCount: exhibitorList.length,
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          // trailing: const Icon(
                          //   Icons.more_rounded,
                          //   color: Colors.black,
                          // ),
                          title: Text(
                            '${index + 1}.  ${exhibitorList[index]['category']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            '\n${exhibitorList[index]['benefits']}\nWithout Accomodation: ${exhibitorList[index]['withoutAccomodation']}\nTriple Sharing: ${exhibitorList[index]['tripleSharing']}\nDouble Sharing: ${exhibitorList[index]['doubleSharing']}\nSingle Sharing: ${exhibitorList[index]['singleSharing']}\nRate USD: ${exhibitorList[index]['rateUSD']}\n',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PaperDetailScreen(
                                      data: exhibitorList[index],
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
