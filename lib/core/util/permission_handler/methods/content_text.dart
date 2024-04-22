import 'package:faro_clean_tdd/core/util/permission_handler/constants/permission_constants.dart';
import 'package:faro_clean_tdd/core/util/permission_handler/enum/permission_enum.dart';

/// This method will either return a success String content or an error String content
///
/// Requires a [PermissionEnum] and the success bool to define the content
String contentText(
    {required PermissionEnum requestEnum, required bool isSuccess}) {
  final contentSuccessMap = {
    PermissionEnum.camera: PermissionConstants.cameraRequest,
    PermissionEnum.contact: PermissionConstants.contactListRequest,
    PermissionEnum.location: PermissionConstants.locationRequest,
    PermissionEnum.photos: PermissionConstants.galeryRequest,
  };

  final contentErrorMap = {
    PermissionEnum.camera: PermissionConstants.cameraRequestError,
    PermissionEnum.contact: PermissionConstants.contactListRequestError,
    PermissionEnum.location: PermissionConstants.locationRequestError,
    PermissionEnum.photos: PermissionConstants.galeryRequestError,
  };

  return isSuccess
      ? contentSuccessMap[requestEnum]!
      : contentErrorMap[requestEnum]!;
}
