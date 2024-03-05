import 'dart:convert';

import 'package:faro_clean_tdd/core/constants/server_constants.dart';
import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/list_to_batches.dart';
import 'package:faro_clean_tdd/features/contacts/data/models/contact_model.dart';
import 'package:faro_clean_tdd/features/contacts/domain/entities/contact.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names

abstract class ContactRemoteDataSource {
  Future<List<Contact>> fetchContacts({required List<String> numbersList});
  Future<List<Contact>> fetchContactsInBatches(
      {required List<String> numbersList});
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final http.Client client;

  ContactRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Contact>> fetchContactsInBatches(
      {required List<String> numbersList}) async {
    print(numbersList);
    List<Contact> allContacts = [];

    final List<dynamic> batches = ListToBatchesImpl().listToBatches(
      batchSize: 100,
      list: numbersList,
    );

    for (List<String> batch in batches) {
      List<Contact> contacts = await fetchContacts(numbersList: batch);
      allContacts.addAll(contacts);
    }

    return allContacts;
  }

  @override
  Future<List<Contact>> fetchContacts(
      {required List<String> numbersList}) async {
    final Map<String, List<String>> params = {"phone_numbers[]": numbersList};

    final uri =
        Uri.parse(ServerConstants.userUrl).replace(queryParameters: params);

    //Fait la requête
    final response = await client.get(
      uri,
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      late List<Contact> contacts = [];
      final List<dynamic> array = json.decode(response.body);

      for (var element in array) {
        contacts.add(
          ContactModel.fromJson(element),
        );
      }

      return contacts;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      throw ServerException(
        errorMessage: json.decode(response.body)["error"][0],
      );
    } else {
      throw ServerException(
        errorMessage: "An error as occured please try again later",
      );
    }
  }
}
