import 'dart:io';

import 'package:equatable/equatable.dart';

class PickedImage extends Equatable {
  const PickedImage({required this.image});

  final File image;

  @override
  List<Object?> get props => [image];
}
