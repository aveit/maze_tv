import 'dart:convert';

import 'package:maze_tv/domain/entities/image.dart';

class TVImageModel {
  const TVImageModel({
    this.medium,
    this.original,
  });
  factory TVImageModel.fromJson(Map<String, dynamic> json) {
    return TVImageModel(
      medium: json['medium'] as String?,
      original: json['original'] as String?,
    );
  }

  final String? medium;
  final String? original;

  TVImage toEntity() {
    return TVImage(
      medium: medium ?? '',
      original: original ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (medium != null) {
      result.addAll({'medium': medium});
    }
    if (original != null) {
      result.addAll({'original': original});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
