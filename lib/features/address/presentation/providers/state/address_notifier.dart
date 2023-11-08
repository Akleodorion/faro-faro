import 'package:faro_clean_tdd/core/errors/failures.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_current_location_address.dart';
import 'package:faro_clean_tdd/features/address/domain/usecases/get_selected_location_address.dart';
import 'package:faro_clean_tdd/features/address/presentation/providers/state/address_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressNotifier extends StateNotifier<AddressState> {
  AddressNotifier(
      {required this.getCurrentLocationAddressUsecase,
      required this.getSelectedLocationAddressUsecase})
      : super(Initial());

  final GetCurrentLocationAddress getCurrentLocationAddressUsecase;
  final GetSelectedLocationAddress getSelectedLocationAddressUsecase;

  AddressState get initialState => Initial();

  Future<AddressState?> getCurrentLocationAddress() async {
    state = Loading();
    final response = await getCurrentLocationAddressUsecase.call();

    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (address) {
      state = Loaded(address: address!);
    });
    return state;
  }

  Future<AddressState?> getSelectedLociationAddress(
      double latitude, double longitude) async {
    state = Loading();
    final response =
        await getSelectedLocationAddressUsecase.call(latitude, longitude);
    response!.fold((failure) {
      if (failure is ServerFailure) {
        state = Error(message: failure.errorMessage);
      }
    }, (address) {
      state = Loaded(address: address!);
    });
    return state;
  }
}
