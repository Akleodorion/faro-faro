// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:faro_faro/features/events/domain/repositories/event_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/event_model.dart';
import '../entities/event.dart';

class PostAnEvent {
  PostAnEvent({required this.repository});

  final EventRepository repository;

  Future<Either<Failure, Event>> execute(
      {required EventModel event, required File image}) async {
    return repository.postAnEvent(event: event, image: image);
  }
}
