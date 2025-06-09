import 'dart:io';
import 'package:flutter/material.dart';

ImageProvider<Object>? imageProviderFromPath(String? path) {
  if (path == null || path.isEmpty) return null;
  return path.startsWith('http')
      ? NetworkImage(path) as ImageProvider<Object>
      : FileImage(File(path)) as ImageProvider<Object>;
}
