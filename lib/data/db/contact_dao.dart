import 'package:contacts/data/contact.dart';
import 'package:contacts/data/db/app_database.dart';
import 'package:sembast/sembast.dart';

class ContactDao {
  // ignore: constant_identifier_names
  static const String CONTACT_STORE_NAME = 'contacts';
  final _contactstore = intMapStoreFactory.store(CONTACT_STORE_NAME);
  Future<Database> get _db async => await AppDatabase.instance.database;
  Future insert(Contact contact) async {
    await _contactstore.add(
      await _db,
      contact.tomap(),
    );
  }

  Future update(Contact contact) async {
    //print(contact.contactImage);
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactstore.update(
      await _db,
      contact.tomap(),
      finder: finder,
    );
  }

  Future delete(Contact contact) async {
    final finder = Finder(filter: Filter.byKey(contact.id));
    await _contactstore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Contact>> getallinSortedorder() async {
    final finder = Finder(sortOrders: [
      SortOrder('isfavorite', false),
      SortOrder('name'),
    ]);

    var recordsnapshot = await _contactstore.find(
      await _db,
      finder: finder,
    );

    var temp = recordsnapshot.map((snapshot) {
      final contact = Contact.frommap(snapshot.value);
      contact.id = snapshot.key;
      return contact;
    }).toList();
    return temp;
  }
}
