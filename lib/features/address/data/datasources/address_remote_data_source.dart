import 'dart:convert';

import 'package:faro_clean_tdd/core/errors/exceptions.dart';
import 'package:faro_clean_tdd/core/util/get_location.dart';
import 'package:faro_clean_tdd/features/address/data/models/address_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
final APIKEY = dotenv.env['API_KEY'];

abstract class AddressRemoteDataSource {
  /// Fait une requête http à l'API Geocoding de Google.
  ///
  /// La localisation utilisée est celle choisie sur la carte interactive
  ///
  /// Jette une [ServerException] en cas d'erreur
  Future<AddressModel?> fetchAddressDataFromMap(
      double latitude, double longitude);

  /// Fait une requête http à l'API Geocoding de Google.
  ///
  /// La localisation utilisée est celle de la position GPS du téléphone
  ///
  /// Jette une [ServerException] en cas d'erreur
  Future<AddressModel?> fetchAddressDataFromCurrentLocation();
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  AddressRemoteDataSourceImpl({required this.location, required this.client});

  final GetLocationImpl location;
  final http.Client client;
  @override
  Future<AddressModel?> fetchAddressDataFromCurrentLocation() async {
    // récupérer la position du téléphone
    final setLocation = await location.getLocation();

    if (setLocation == null) {
      throw ServerException(
          errorMessage: "We have not managed to retrieve your position");
    }
    // faire la requête http
    final uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${setLocation['latitude']},${setLocation['longitude']}&key=$APIKEY");

    final response = await client.get(uri);
    // Si la réponse est bonne créer le model et le retourner
    if (response.statusCode == 200) {
      return AddressModel.fromJson(json.decode(response.body));
    } else {
      // Si la requête est infructueuse
      throw ServerException(errorMessage: response.body);
    }
  }

  @override
  Future<AddressModel?> fetchAddressDataFromMap(
      double latitude, double longitude) async {
    // faire la requête http
    final uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$APIKEY");

    final response = await client.get(uri);
    // Si la réponse est bonne créer le model et le retourner
    if (response.statusCode == 200) {
      return AddressModel.fromJson(json.decode(response.body));
    } else {
      // Si la requête est infructueuse
      throw ServerException(errorMessage: response.body);
    }
  }
}
