import 'package:contacts/ui/contact_list/contact/contactcreate.dart';
import 'package:contacts/ui/contact_list/model/contact_model.dart';
import 'package:contacts/ui/contact_list/widget/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: use_key_in_widget_constructors
class ContactList extends StatefulWidget {
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ScopedModelDescendant<ContactModel>(
              builder: (context, child, model) {
                if (model.isloding) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: ListView.builder(
                      itemCount: model.contacts.length,
                      itemBuilder: (context, index) {
                        return ContactTile(
                          contactIndex: index,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // ignore: prefer_const_constructors
              return CreateContactPage();
            }),
          );
        },
      ),
    );
  }
}
