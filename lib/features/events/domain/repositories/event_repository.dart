import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/event.dart';

abstract class EventRepository {
  // Récupère tous les évènements
  Future<Either<Failure, List<Event>>?> fetchAllEvents();

  // Poste un évènement
  Future<Either<Failure, Event>?> postAnEvent({
    required String title,
    required String description,
    required DateTime date,
    required String address,
    required double longitude,
    required double latitude,
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
  });
}
