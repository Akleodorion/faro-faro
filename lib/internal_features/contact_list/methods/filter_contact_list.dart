// Package imports:
import 'package:contacts_service/contacts_service.dart';

List<String> filterContactList({
  required List<Contact> contacts,
  required int digits,
  required int prefix,
}) {
  final cleanContacts = cleanContact(contacts);
  final items = contactsToItemList(cleanContacts);
  return formatItemListToPhoneList(items, digits, prefix);
}

List<Contact> cleanContact(List<Contact> contacts) {
  return contacts.where(
    (element) {
      final bool isNotNull = element.phones != null;
      final bool isNotEmpty = element.phones!.isNotEmpty;
      final bool isValid = isNotEmpty && isNotNull;

      return isValid;
    },
  ).toList();
}

List<Item> contactsToItemList(List<Contact> contacts) {
  return contacts.expand((contact) => contact.phones!).toList();
}

List<String> formatItemListToPhoneList(
    List<Item> items, int digits, int prefix) {
  final filteredList = keepValidItems(items, digits, prefix);
  return filteredList.map((phone) {
    final trimmedPhoneNumber = phone.value!.replaceAll(' ', '');
    if (trimmedPhoneNumber.length == digits) {
      return "+$prefix$trimmedPhoneNumber";
    } else {
      return trimmedPhoneNumber;
    }
  }).toList();
}

List<Item> keepValidItems(List<Item> items, int digits, int prefix) {
  return items.where((phone) {
    final trimmedPhoneNumber = phone.value!.replaceAll(' ', '');

    final bool isTenDigits = trimmedPhoneNumber.length == digits;
    final bool isPrefixPhoned = trimmedPhoneNumber.contains("+$prefix");

    return isTenDigits || isPrefixPhoned;
  }).toList();
}
