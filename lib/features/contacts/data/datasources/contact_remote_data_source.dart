import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/get_contact_list.dart';
import 'package:faro_clean_tdd/features/contacts/data/models/contact_model.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const INDEX_GET_URL = "http://localhost:3001/users";

abstract class ContactRemoteDataSource {
  Future<List<Contact>?> fetchContacts();
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final GetContactList getContactList;
  final http.Client client;
  ContactRemoteDataSourceImpl(
      {required this.getContactList, required this.client});
  @override
  Future<List<Contact>?> fetchContacts() async {
    // récupère la liste des contacts du téléphone.
    final Map<String, List<String>> params = {"phone_numbers": []};
    final contactList = await getContactList.getContacts();

    if (contactList == null) {
      throw ServerException(
          errorMessage:
              "nous n'avons pas reçu l'autorisation d'accéder à vos contacts.");
    }
    params["phone_numbers"] = contactList;

    final uri = Uri.parse(INDEX_GET_URL).replace(queryParameters: params);
    final response = await client.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      late List<Contact> contacts = [];
      final List<dynamic> array = json.decode(response.body);

      for (var element in array) {
        contacts.add(ContactModel.fromJson(element));
      }
      return contacts;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
          errorMessage: json.decode(response.body)["error"][0]);
    } else {
      throw ServerException(
          errorMessage: "An error as occured please try again later");
    }
  }
}
