import 'package:contacts/data/contact.dart';
import 'package:contacts/ui/contact_list/contact/contact_form.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ContactEditPage extends StatelessWidget {
  final Contact editContact;
  const ContactEditPage({Key? key, required this.editContact})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: ContactForm(
        editContact: editContact,
      ),
    );
  }
}
