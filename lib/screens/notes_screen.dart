// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert' as convert;

import 'package:corcon/model/list_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<ListData> listData = [];
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  int selectedIndex = -1;

  Future<List<String>> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList("Notes") == null
        ? []
        : prefs.getStringList("Notes")!;
  }

  Future<void> saveNotes(String title, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = await loadNotes();
    tempList
        .add(convert.jsonDecode(convert.jsonEncode(title + '*' + description)));
    prefs.setStringList("Notes", tempList);
  }

  Future<void> deleteNotes(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = await loadNotes();
    tempList.removeAt(index);
    prefs.setStringList("Notes", tempList);
  }

  Future<void> updateNotes(int index, String dataString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = await loadNotes();
    tempList.insert(index, dataString);
    prefs.setStringList("Notes", tempList);
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Add Notes",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                  future: loadNotes(),
                  builder: (context, snapshot) {
                    final items =
                        snapshot.data == null ? [] : snapshot.data as List;
                    return ListView.builder(
                        itemCount: items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                selectedIndex = index;
                                AlertDialog alert = AlertDialog(
                                  title: const Text("Delete Task"),
                                  content: const Text(
                                      "Are you sure you want to delete the task?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                showLoaderDialog(
                                                    context, false);
                                              },
                                              child: const Text("Update"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  deleteNotes(index);
                                                });
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF959595),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  title: Text(
                                      items[index].toString().split("*").first),
                                  subtitle: Text(
                                      items[index].toString().split("*").last),
                                ),
                              ),
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            showLoaderDialog(context, true);
          });
        },
        backgroundColor: const Color(0xff152238),
        icon: const Icon(Icons.add),
        label: const Text("Add Notes"),
      ),
    );
  }

  showLoaderDialog(BuildContext context, bool value) {
    final _formKey = GlobalKey<FormState>();
    AlertDialog alert = AlertDialog(
      title: value
          ? const Text("Enter your task")
          : const Text("Update your task"),
      content: SizedBox(
        height: 170,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleCtrl,
                validator: (value) {
                  if (value!.isEmpty) return "Please enter title";
                  if (value == "") return "Please enter title";
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  label: Text("Enter title"),
                ),
              ),
              TextFormField(
                controller: descCtrl,
                validator: (value) {
                  if (value!.isEmpty) return "Please enter description";
                  if (value == "") return "Please enter description";
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  label: Text("Enter description"),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (value) {
                ListData listDataNew = ListData(titleCtrl.text, descCtrl.text);
                setState(() {
                  saveNotes(titleCtrl.text, descCtrl.text);
                  listData.add(listDataNew);
                });
                Navigator.of(context).pop();
                titleCtrl.text = "";
                descCtrl.text = "";
              } else {
                setState(() {
                  deleteNotes(selectedIndex).then((value) {
                    updateNotes(
                        selectedIndex, titleCtrl.text + '*' + descCtrl.text);
                    Navigator.of(context).pop();
                    titleCtrl.text = "";
                    descCtrl.text = "";
                  });
                });
              }
            }
          },
          child: value ? const Text("Create") : const Text("Update"),
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
