// Package imports:
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:faro_faro/core/util/permission_handler/enum/permission_enum.dart';

class PermissionConstants {
  static const title = "Permission requise";
  static const errorTitle = "Permission non fournie";

  static const cameraRequest =
      "Cette fonctionnalité à besoin d'un accès à votre appareil photo";
  static const cameraRequestError =
      "Cette fonctionnalité à besoin d'un accès à votre appareil photo.\nVeuillez activer la permission dans les paramètres de votre téléphone.";

  static const galeryRequest =
      "Cette fonctionnalité à besoin d'un accès à votre galerie photo";
  static const galeryRequestError =
      "Cette fonctionnalité à besoin d'un accès à votre galerie photo.\nVeuillez activer la permission dans les paramètres de votre téléphone.";

  static const contactListRequest =
      "Cette fonctionnalité à besoin d'un accès à votre liste de contact";
  static const contactListRequestError =
      "Cette fonctionnalité à besoin d'un accès à votre liste de contact.\nVeuillez activer la permission dans les paramètres de votre téléphone.";

  static const locationRequest =
      "Cette fonctionnalité à besoin d'un accès à votre position";
  static const locationRequestError =
      "Cette fonctionnalité à besoin d'un accès à votre position.\nVeuillez activer la permission dans les paramètres de votre téléphone.";

  static const errorRequest =
      "Cette requête est une erreur, veuillez retenter plus tard.";

  static const pass = "Continuer";

  static const Map<PermissionEnum, Permission> permissionMap = {
    PermissionEnum.camera: Permission.camera,
    PermissionEnum.contact: Permission.contacts,
    PermissionEnum.location: Permission.location,
    PermissionEnum.photos: Permission.photos,
  };
}
