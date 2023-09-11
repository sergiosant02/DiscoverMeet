import 'dart:io';

class JwtExpiredException implements Exception {
  final String message;

  JwtExpiredException({required this.message});
}
