// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:contacts/data/contact.dart';
import 'package:contacts/ui/contact_list/model/contact_model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: use_key_in_widget_constructors
class ContactForm extends StatefulWidget {
  final Contact? editContact;
  const ContactForm({Key? key, this.editContact}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String? _name;
  String? _email;
  String? _phone;
  String? _address;
  File? _contactImage;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            if (widget.editContact != null)
              _addavatar()
            else
              _addavatarcreate(),
            TextFormField(
              onSaved: ((newValue) => _name = newValue),
              validator: (_name) {
                if (_name == null || _name.isEmpty) {
                  return 'enter the name';
                } else {
                  return null;
                }
              },
              initialValue: widget.editContact?.name,
              decoration: InputDecoration(
                  labelText: 'name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),

            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) => _phone = newValue,
              validator: (_phone) {
                final regex = RegExp(r'^(?:[+0]9)?[0-9]{10,13}$');
                if (_phone == null || _phone.isEmpty) {
                  return 'enter the Phone Number';
                } else if (!regex.hasMatch(_phone)) {
                  return 'enter valid phone number';
                } else {
                  return null;
                }
              },
              initialValue: widget.editContact?.phonenumber,
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) => _email = newValue,
              validator: (_email) {
                final regex = RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                if (_email != null &&
                    (_email.isNotEmpty) &&
                    !regex.hasMatch(_email)) {
                  return 'enter the valid emial';
                } else {
                  return null;
                }
              },
              initialValue: widget.editContact?.email,
              decoration: InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (newValue) => _address = newValue,
              initialValue: widget.editContact?.address,
              decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                addContact();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text('Save'),
                  Icon(
                    Icons.person,
                    size: 18,
                  )
                ],
              ),
            )
          ],
        ));
  }

  void addContact() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState?.save();
      if (_contactImage == null) {
        if (widget.editContact?.contactImage != null) {
          _contactImage = widget.editContact!.contactImage;
        }
      }
      final newcontact = Contact(
          name: _name,
          email: _email,
          phonenumber: _phone,
          address: _address,
          contactImage: _contactImage);
      if (widget.editContact != null) {
        newcontact.id = widget.editContact!.id;
        ScopedModel.of<ContactModel>(context).updatecontact(newcontact);
      } else {
        ScopedModel.of<ContactModel>(context).addcontact(newcontact);
      }
      Navigator.of(context).pop();
    }
  }

  Widget _addavatar() {
    if (_contactImage != null) {
      File file = File(_contactImage!.path);
      return Hero(
        tag: widget.editContact.hashCode,
        // ignore: prefer_const_constructors
        child: GestureDetector(
          onTap: _addpicture,
          onLongPress: _addpicturec,
          onDoubleTap: _adddefaultpicture,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child: CircleAvatar(
              radius: 80,
              child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        ),
      );
    } else if (widget.editContact!.contactImage != null) {
      File file = File(widget.editContact!.contactImage!.path);
      return Hero(
        tag: widget.editContact.hashCode,
        // ignore: prefer_const_constructors
        child: GestureDetector(
          onTap: _addpicture,
          onLongPress: _addpicturec,
          onDoubleTap: _adddefaultpicture,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child: CircleAvatar(
              radius: 80,
              child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        ),
      );
    } else {
      return Hero(
        tag: widget.editContact.hashCode,
        child: GestureDetector(
          onTap: _addpicture,
          onLongPress: _addpicturec,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child: CircleAvatar(
              child: Text(
                widget.editContact!.name.toString()[0],
                textScaleFactor: 3,
              ),
              radius: 80,
            ),
          ),
        ),
      );
    }
  }

  void _addpicture() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _contactImage = File(pickedFile!.path);
      //print(_contactImage!.path.toString());
    });
  }

  void _adddefaultpicture() {
    _contactImage = null;
    widget.editContact?.contactImage = null;
  }

  void _addpicturec() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _contactImage = File(pickedFile!.path);
      //print(_contactImage!.path.toString());
    });
  }

  Widget _addavatarcreate() {
    if (_contactImage == null) {
      return Hero(
        tag: widget.editContact.hashCode,
        child: GestureDetector(
          onTap: _addpicture,
          onLongPress: _addpicturec,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child: const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 70,
              ),
              radius: 80,
            ),
          ),
        ),
      );
    } else {
      File file = File(_contactImage!.path);
      return Hero(
        tag: widget.editContact.hashCode,
        // ignore: prefer_const_constructors
        child: GestureDetector(
          onTap: _addpicture,
          onLongPress: _addpicturec,
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child: CircleAvatar(
              radius: 80,
              child: ClipOval(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
        ),
      );
    }
  }
}
