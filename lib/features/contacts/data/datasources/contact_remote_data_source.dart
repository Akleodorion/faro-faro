import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';

abstract class ContactRemoteDataSource {
  Future<List<Contact>?> fetchContacts();
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  @override
  Future<List<Contact>?> fetchContacts() async {
    // récupère la liste des contacts du téléphone.

    // fait la requête http.

    // si la réponse est bonne renvoyer la liste

    // Si non Serveur Exception.

    return null;
  }
}
