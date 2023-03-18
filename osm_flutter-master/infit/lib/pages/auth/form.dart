import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const UserForm());
}

enum SingingCharacter { male, female, other }

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  SingingCharacter? _character = SingingCharacter.male;
  var email = TextEditingController();
  var name = TextEditingController();
  var age = TextEditingController();
  var medical = TextEditingController();
  var level = TextEditingController();
  var height = TextEditingController();
  var weight = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Enter your full name',
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.mail),
                          hintText: 'Enter your email address',
                          labelText: 'email address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid email address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: age,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: 'Enter your age',
                          labelText: 'Age',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid age';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: level,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.align_vertical_bottom_sharp),
                          hintText:
                          'Enter your level of training(Beginner,Intermediate,Advanced)',
                          labelText: 'Level',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid level';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: medical,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          hintText: 'Ex. Sugar,BP,Gastric,None',
                          labelText: 'Medical Problems',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter valid data';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: height,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.height_outlined),
                          hintText: 'Enter your height in feet',
                          labelText: 'height',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height in feet';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: weight,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.monitor_weight_outlined),
                          hintText: 'Enter your weight in kgs',
                          labelText: 'weight',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight in kgs';
                          }
                          return null;
                        },
                      ),
                      ListTile(
                        title: const Text("Male"),
                        horizontalTitleGap: 10,
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.male,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("Female"),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.female,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("Other"),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.other,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final sex = _character.toString().split('.');
                              print(name.text);
                              print(email.text);
                              print(age.text);
                              print(level.text);
                              print(medical.text);
                              print(height.text);
                              print(weight.text);
                              print(sex[1].toString());
                              var dweight = double.parse(weight.text);
                              var dheight = double.parse(height.text);
                              var bmi = dweight / (dheight * dheight);

                              await firestore
                                  .collection("user_data")
                                  .doc(email.text)
                                  .set({
                                'user_name': name.text,
                                'email': email.text,
                                'age': age.text,
                                'height': height.text,
                                'weight': weight.text,
                                'bmi': bmi.toString(),
                                'level': level.text,
                                'medical': medical.text,
                                'sex': sex[1].toString(),
                              });
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}