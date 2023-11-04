// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_introduction_firebase/src/introduction_page.dart';

const _introductionDocumentRef = 'introduction';

class FirebaseIntroductionService {
  FirebaseIntroductionService({
    DocumentReference<Map<String, dynamic>>? documentRef,
  }) : _documentRef = documentRef ??
            FirebaseFirestore.instance.doc(_introductionDocumentRef);

  final DocumentReference<Map<String, dynamic>> _documentRef;
  List<IntroductionPageData> _pages = [];

  Future<List<IntroductionPageData>> getIntroductionPages() async {
    if (_pages.isNotEmpty) return _pages;
    var pagesDocuments =
        await _documentRef.collection('pages').orderBy('order').get();

    return _pages = pagesDocuments.docs.map((document) {
      var data = document.data();
      return IntroductionPageData(
        title: data['title'] as String,
        content: data['content'] as String,
        image: data['image'] as String,
      );
    }).toList();
  }

  Future<bool> shouldAlwaysShowIntroduction() async {
    var document = await _documentRef.get();
    return document.data()!['always_show'] as bool? ?? false;
  }

  Future<void> loadIntroductionPages(
    BuildContext context,
  ) async {
    for (var page in _pages) {
      if (context.mounted)
        await precacheImage(CachedNetworkImageProvider(page.image), context);
    }
  }
}
