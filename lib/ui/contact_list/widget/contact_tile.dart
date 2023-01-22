import 'dart:io';

import 'package:contacts/data/contact.dart';
import 'package:contacts/ui/contact_list/model/contact_model.dart';
import 'package:contacts/ui/editform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({Key? key, required this.contactIndex}) : super(key: key);
  final int contactIndex;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ContactModel>(
        builder: (context, child, model) {
      final displaycontact = model.contacts[contactIndex];
      return _buildUi(model, displaycontact, context);
    });
  }

  Slidable _buildUi(
    ContactModel model,
    Contact displaycontact,
    BuildContext context,
  ) {
    return Slidable(
      direction: Axis.horizontal,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          // ignore: prefer_const_constructors
          SlidableAction(
            onPressed: (context) => _CallPhoneNumber(
                context, displaycontact.phonenumber.toString()),
            backgroundColor: const Color.fromARGB(255, 46, 219, 152),
            foregroundColor: Colors.white,
            icon: Icons.call,
            label: 'call',
          ),
          SlidableAction(
            onPressed: (context) => _messagephonenumber(
                context, displaycontact.phonenumber.toString()),
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.message,
            label: 'Message',
          ),
        ],
      ),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) =>
              _mailemailid(context, displaycontact.email.toString()),
          backgroundColor: const Color.fromARGB(255, 30, 44, 229),
          foregroundColor: Colors.white,
          icon: Icons.mail,
          label: 'mail',
        ),
        SlidableAction(
          onPressed: (context) {
            model.deleteContact(displaycontact);
          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ]),
      child: ListTile(
        title: Text(displaycontact.name.toString()),
        subtitle: Text(displaycontact.phonenumber.toString() +
            '\n' +
            displaycontact.email.toString()),
        leading: Hero(
          tag: displaycontact.hashCode,
          child: _addImageinList(displaycontact),
        ),
        trailing: IconButton(
          icon:
              Icon(displaycontact.isfavorite ? Icons.star : Icons.star_border),
          color: displaycontact.isfavorite ? Colors.amber : Colors.blueGrey,
          onPressed: () {
            model.changeFavoriteStatus(displaycontact);
          },
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContactEditPage(
              editContact: displaycontact,
            ),
          ));
        },
      ),
    );
  }

  CircleAvatar _addImageinList(Contact displaycontact) {
    if (displaycontact.contactImage == null) {
      return CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(displaycontact.name.toString()[0]),
      );
    } else {
      File file = File(displaycontact.contactImage!.path);
      return CircleAvatar(
        radius: 25,
        child: ClipOval(
          child: AspectRatio(
              aspectRatio: 1,
              child: Image.file(
                file,
                fit: BoxFit.cover,
              )),
        ),
      );
    }
  }

  // ignore: non_constant_identifier_names
  Future _CallPhoneNumber(BuildContext context, String number) async {
    final url = Uri.parse('tel:$number');

    if (!await launchUrl(
      url,
      mode: url_launcher.LaunchMode.externalApplication,
    )) {
      const snackBar = SnackBar(content: Text("Can't make a call"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future _messagephonenumber(BuildContext context, String number) async {
    final url = Uri.parse('sms:$number');

    if (!await launchUrl(
      url,
      mode: url_launcher.LaunchMode.externalApplication,
    )) {
      const snackBar = SnackBar(content: Text("Can't send a message"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future _mailemailid(BuildContext context, String email) async {
    final url = Uri.parse('mailto:$email');

    if (email.isEmpty ||
        !await launchUrl(
          url,
          mode: url_launcher.LaunchMode.externalApplication,
        )) {
      const snackBar = SnackBar(content: Text("Can't send a mail"));
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
