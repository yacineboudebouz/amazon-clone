import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudinaryProvider = Provider((ref) {
  return cloudinary;
});
final cloudinary = CloudinaryPublic('dqredsqta', 'apqf0kxh');
