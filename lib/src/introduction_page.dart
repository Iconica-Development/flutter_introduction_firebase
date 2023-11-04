// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

@immutable
class IntroductionPageData {
  const IntroductionPageData({
    required this.title,
    required this.content,
    required this.image,
  });

  /// The title of the introduction page
  final String title;

  /// The content of the introduction page
  final String content;

  /// The imageUrl of the introduction page
  final String image;
}
