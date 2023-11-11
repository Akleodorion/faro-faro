import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/event.dart';

class PostAnEvent {
  PostAnEvent({required this.repository});

  final EventRepository repository;

  Future<Either<Failure, Event>?> execute({
    required String title,
    required String description,
    required DateTime date,
    required String address,
    required double latitude,
    required double longitude,
    required Category category,
    required String imageUrl,
    required int userId,
    required ModelEco modelEco,
    required int standardTicketPrice,
    required int maxStandardTicket,
    required String standardTicketDescription,
    required int vipTicketPrice,
    required int maxVipTicket,
    required String vipTicketDescription,
    required int vvipTicketPrice,
    required int maxVvipTicket,
    required String vvipTicketDescription,
  }) async {
    return repository.postAnEvent(
        title: title,
        description: description,
        date: date,
        address: address,
        longitude: longitude,
        latitude: latitude,
        category: category,
        imageUrl: imageUrl,
        userId: userId,
        modelEco: modelEco,
        standardTicketPrice: standardTicketPrice,
        maxStandardTicket: maxStandardTicket,
        standardTicketDescription: standardTicketDescription,
        vipTicketPrice: vipTicketPrice,
        maxVipTicket: maxVipTicket,
        vipTicketDescription: vipTicketDescription,
        vvipTicketPrice: vvipTicketPrice,
        maxVvipTicket: maxVvipTicket,
        vvipTicketDescription: vvipTicketDescription);
  }
}
