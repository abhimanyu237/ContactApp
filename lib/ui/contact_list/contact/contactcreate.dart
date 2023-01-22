import 'package:contacts/ui/contact_list/contact/contact_form.dart';
import 'package:flutter/material.dart';

import '../../../data/contact.dart';

// ignore: use_key_in_widget_constructors
class CreateContactPage extends StatelessWidget {
  final Contact? editContact;
  final int? contactIndex;
  const CreateContactPage({
    Key? key,
    this.editContact,
    this.contactIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      // ignore: prefer_const_constructors
      body: ContactForm(),
    );
  }
}
