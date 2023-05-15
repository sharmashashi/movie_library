import 'package:flutter/material.dart';

bool  isMobile(BuildContext context) {
  try {
    return MediaQuery.of(context).size.width <= 600;
  } catch (_) {}
  return false;
}

bool  isTablet(BuildContext context) {
  try {
    return !isMobile(context) &&
        MediaQuery.of(context).size.width <= 1000;
  } catch (_) {}
  return false;
}