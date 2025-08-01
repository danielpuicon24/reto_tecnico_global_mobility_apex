import 'package:flutter/material.dart';
import '../../config/router/navigation_service.dart';

void showFloatingSuccessSnackbar(String message) {
  final context = NavigationService.navigatorKey.currentContext;
  if (context == null) return;
  final snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showFloatingErrorSnackbar(String message) {
  final context = NavigationService.navigatorKey.currentContext;
  if (context == null) return;
  final snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


void showFloatingInformationSnackbar(String message) {
  final context = NavigationService.navigatorKey.currentContext;
  if (context == null) return;
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 24),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    backgroundColor: Colors.yellow,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

