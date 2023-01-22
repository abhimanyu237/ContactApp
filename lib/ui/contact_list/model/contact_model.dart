import 'package:scoped_model/scoped_model.dart';

import '../../../data/contact.dart';
import '../../../data/db/contact_dao.dart';

class ContactModel extends Model {
  final contactdao = ContactDao();
  List<Contact> _mylist = [];
  bool isloding = true;
  List<Contact> get contacts {
    loadcontacts();
    return _mylist;
  }

  Future loadcontacts() async {
    isloding = true;
    notifyListeners();
    _mylist = await contactdao.getallinSortedorder();
    isloding = false;
    notifyListeners();
  }

  Future addcontact(Contact contact) async {
    // _mylist.add(contact);
    // notifyListeners();
    // print(contact.email);
    await contactdao.insert(contact);
    notifyListeners();
    await loadcontacts();
  }

  Future deleteContact(Contact contact) async {
    await contactdao.delete(contact);
    notifyListeners();
    await loadcontacts();
    // _mylist.removeAt(index);
    // notifyListeners();
  }

  Future changeFavoriteStatus(Contact contact) async {
    contact.isfavorite = !contact.isfavorite;
    updatecontact(contact);
    notifyListeners();
    _mylist = await contactdao.getallinSortedorder();
    notifyListeners();
  }

  Future updatecontact(Contact contact) async {
    await contactdao.update(contact);
    notifyListeners();
    await loadcontacts();
    // _mylist[index] = contact;
    // notifyListeners();
  }
  // Future search(String name) async{
  //    for(int i=0;i<_mylist.length;i++){

  //   }
  // }
  // void sortc() {
  //   _mylist.sort((a, b) {
  //     int result;
  //     result = favoritesort(a, b);
  //     if (result == 0) {
  //       result = namesort(a, b);
  //     }
  //     return result;
  //   });
  // }

  // int namesort(Contact a, Contact b) {
  //   return a.name.toString().compareTo(b.name.toString());
  // }

  // int favoritesort(Contact a, Contact b) {
  //   if (a.isfavorite) {
  //     return -1;
  //   } else if (b.isfavorite) {
  //     return 1;
  //   } else {
  //     return 0;
  //   }
  // }
}
