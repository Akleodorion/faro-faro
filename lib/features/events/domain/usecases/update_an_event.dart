import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:faro_clean_tdd/features/events/domain/repositories/event_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/event_model.dart';
import '../entities/event.dart';

class UpdateAnEventUsecase {
  final EventRepository repository;
  UpdateAnEventUsecase({required this.repository});

  Future<Either<Failure, Event>?> execute({
    required EventModel event,
    required File image,
  }) async {
    return await repository.updateAnEvent(event: event, image: image);
  }
}
