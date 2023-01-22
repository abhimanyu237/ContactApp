import 'package:contacts/ui/contact_list/contact_list.dart';
import 'package:contacts/ui/contact_list/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contact',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactList(),
      ),
      model: ContactModel()..loadcontacts(),
    );
  }
}
