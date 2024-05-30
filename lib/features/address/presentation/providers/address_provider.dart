// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:faro_faro/features/address/domain/entities/address.dart';
import 'package:faro_faro/features/address/domain/usecases/get_current_location_address.dart';
import 'package:faro_faro/features/address/domain/usecases/get_selected_location_address.dart';
import 'package:faro_faro/features/address/presentation/providers/state/address_notifier.dart';
import 'package:faro_faro/features/address/presentation/providers/state/address_state.dart';
import 'package:faro_faro/injection_container.dart';

final addressProvider =
    StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  final GetCurrentLocationAddress getCurrentLocationAddress =
      sl<GetCurrentLocationAddress>();
  final GetSelectedLocationAddress getSelectedLocationAddress =
      sl<GetSelectedLocationAddress>();
  return AddressNotifier(
      getCurrentLocationAddressUsecase: getCurrentLocationAddress,
      getSelectedLocationAddressUsecase: getSelectedLocationAddress);
});

final pickedAddressProvider = Provider<Address?>((ref) {
  final state = ref.read(addressProvider);
  if (state is Loaded) {
    return state.address;
  }
  return null;
});
