// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i20;

import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:ge_english/common/entitys/article.dart' as _i19;
import 'package:ge_english/pages/application/account/mybookmark.dart' as _i7;
import 'package:ge_english/pages/application/account/remebered_word_detail.dart'
    as _i8;
import 'package:ge_english/pages/application/account/star_detail.dart' as _i9;
import 'package:ge_english/pages/application/application.dart' as _i5;
import 'package:ge_english/pages/application/bookmarks/bookmark_details.dart'
    as _i11;
import 'package:ge_english/pages/application/bookmarks/new_bookmark.dart'
    as _i10;
import 'package:ge_english/pages/application/main/learn.dart' as _i15;
import 'package:ge_english/pages/application/main/review.dart' as _i16;
import 'package:ge_english/pages/category/ocr/camera_page.dart' as _i13;
import 'package:ge_english/pages/category/ocr/image_page.dart' as _i12;
import 'package:ge_english/pages/category/ocr/result_page.dart' as _i14;
import 'package:ge_english/pages/index/index.dart' as _i1;
import 'package:ge_english/pages/search/search_result.dart' as _i6;
import 'package:ge_english/pages/sign_in/sign_in.dart' as _i3;
import 'package:ge_english/pages/sign_up/sign_up.dart' as _i4;
import 'package:ge_english/pages/welcome/welcome.dart' as _i2;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    IndexPageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.IndexPage(),
      );
    },
    WelcomePageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.WelcomePage(),
      );
    },
    SignInPageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignInPage(),
      );
    },
    SignUpPageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SignUpPage(),
      );
    },
    ApplicationPageRoute.name: (routeData) {
      final args = routeData.argsAs<ApplicationPageRouteArgs>(
          orElse: () => const ApplicationPageRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ApplicationPage(
          key: args.key,
          idx: args.idx,
        ),
      );
    },
    SearchResultRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.SearchResult(),
      );
    },
    MyBookMarkRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.MyBookMark(),
      );
    },
    RemeberedWordDetailRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RemeberedWordDetail(),
      );
    },
    StarDetailsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.StarDetails(),
      );
    },
    NewBookMarkRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.NewBookMark(),
      );
    },
    BookMarkDetailRoute.name: (routeData) {
      final args = routeData.argsAs<BookMarkDetailRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.BookMarkDetail(
          args.author,
          key: args.key,
        ),
      );
    },
    CropPageRoute.name: (routeData) {
      final args = routeData.argsAs<CropPageRouteArgs>(
          orElse: () => const CropPageRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.CropPage(
          key: args.key,
          title: args.title,
          image: args.image,
          imageInfo: args.imageInfo,
        ),
      );
    },
    CameraPageRoute.name: (routeData) {
      final args = routeData.argsAs<CameraPageRouteArgs>(
          orElse: () => const CameraPageRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.CameraPage(
          key: args.key,
          title: args.title,
        ),
      );
    },
    ResultPageRoute.name: (routeData) {
      final args = routeData.argsAs<ResultPageRouteArgs>(
          orElse: () => const ResultPageRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.ResultPage(
          key: args.key,
          title: args.title,
          image: args.image,
          ocrContent: args.ocrContent,
        ),
      );
    },
    LearnPageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.LearnPage(),
      );
    },
    ReviewPageRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.ReviewPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.IndexPage]
class IndexPageRoute extends _i17.PageRouteInfo<void> {
  const IndexPageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          IndexPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'IndexPageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.WelcomePage]
class WelcomePageRoute extends _i17.PageRouteInfo<void> {
  const WelcomePageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          WelcomePageRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomePageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SignInPage]
class SignInPageRoute extends _i17.PageRouteInfo<void> {
  const SignInPageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SignInPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInPageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SignUpPage]
class SignUpPageRoute extends _i17.PageRouteInfo<void> {
  const SignUpPageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SignUpPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpPageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ApplicationPage]
class ApplicationPageRoute
    extends _i17.PageRouteInfo<ApplicationPageRouteArgs> {
  ApplicationPageRoute({
    _i18.Key? key,
    dynamic idx = 0,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          ApplicationPageRoute.name,
          args: ApplicationPageRouteArgs(
            key: key,
            idx: idx,
          ),
          initialChildren: children,
        );

  static const String name = 'ApplicationPageRoute';

  static const _i17.PageInfo<ApplicationPageRouteArgs> page =
      _i17.PageInfo<ApplicationPageRouteArgs>(name);
}

class ApplicationPageRouteArgs {
  const ApplicationPageRouteArgs({
    this.key,
    this.idx = 0,
  });

  final _i18.Key? key;

  final dynamic idx;

  @override
  String toString() {
    return 'ApplicationPageRouteArgs{key: $key, idx: $idx}';
  }
}

/// generated route for
/// [_i6.SearchResult]
class SearchResultRoute extends _i17.PageRouteInfo<void> {
  const SearchResultRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SearchResultRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchResultRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MyBookMark]
class MyBookMarkRoute extends _i17.PageRouteInfo<void> {
  const MyBookMarkRoute({List<_i17.PageRouteInfo>? children})
      : super(
          MyBookMarkRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyBookMarkRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RemeberedWordDetail]
class RemeberedWordDetailRoute extends _i17.PageRouteInfo<void> {
  const RemeberedWordDetailRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RemeberedWordDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'RemeberedWordDetailRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i9.StarDetails]
class StarDetailsRoute extends _i17.PageRouteInfo<void> {
  const StarDetailsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          StarDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StarDetailsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i10.NewBookMark]
class NewBookMarkRoute extends _i17.PageRouteInfo<void> {
  const NewBookMarkRoute({List<_i17.PageRouteInfo>? children})
      : super(
          NewBookMarkRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewBookMarkRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.BookMarkDetail]
class BookMarkDetailRoute extends _i17.PageRouteInfo<BookMarkDetailRouteArgs> {
  BookMarkDetailRoute({
    required _i19.Author author,
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          BookMarkDetailRoute.name,
          args: BookMarkDetailRouteArgs(
            author: author,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BookMarkDetailRoute';

  static const _i17.PageInfo<BookMarkDetailRouteArgs> page =
      _i17.PageInfo<BookMarkDetailRouteArgs>(name);
}

class BookMarkDetailRouteArgs {
  const BookMarkDetailRouteArgs({
    required this.author,
    this.key,
  });

  final _i19.Author author;

  final _i18.Key? key;

  @override
  String toString() {
    return 'BookMarkDetailRouteArgs{author: $author, key: $key}';
  }
}

/// generated route for
/// [_i12.CropPage]
class CropPageRoute extends _i17.PageRouteInfo<CropPageRouteArgs> {
  CropPageRoute({
    _i18.Key? key,
    String? title,
    _i20.Image? image,
    _i18.ImageInfo? imageInfo,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          CropPageRoute.name,
          args: CropPageRouteArgs(
            key: key,
            title: title,
            image: image,
            imageInfo: imageInfo,
          ),
          initialChildren: children,
        );

  static const String name = 'CropPageRoute';

  static const _i17.PageInfo<CropPageRouteArgs> page =
      _i17.PageInfo<CropPageRouteArgs>(name);
}

class CropPageRouteArgs {
  const CropPageRouteArgs({
    this.key,
    this.title,
    this.image,
    this.imageInfo,
  });

  final _i18.Key? key;

  final String? title;

  final _i20.Image? image;

  final _i18.ImageInfo? imageInfo;

  @override
  String toString() {
    return 'CropPageRouteArgs{key: $key, title: $title, image: $image, imageInfo: $imageInfo}';
  }
}

/// generated route for
/// [_i13.CameraPage]
class CameraPageRoute extends _i17.PageRouteInfo<CameraPageRouteArgs> {
  CameraPageRoute({
    _i18.Key? key,
    String? title,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          CameraPageRoute.name,
          args: CameraPageRouteArgs(
            key: key,
            title: title,
          ),
          initialChildren: children,
        );

  static const String name = 'CameraPageRoute';

  static const _i17.PageInfo<CameraPageRouteArgs> page =
      _i17.PageInfo<CameraPageRouteArgs>(name);
}

class CameraPageRouteArgs {
  const CameraPageRouteArgs({
    this.key,
    this.title,
  });

  final _i18.Key? key;

  final String? title;

  @override
  String toString() {
    return 'CameraPageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [_i14.ResultPage]
class ResultPageRoute extends _i17.PageRouteInfo<ResultPageRouteArgs> {
  ResultPageRoute({
    _i18.Key? key,
    String? title,
    _i20.Image? image,
    List<String>? ocrContent,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          ResultPageRoute.name,
          args: ResultPageRouteArgs(
            key: key,
            title: title,
            image: image,
            ocrContent: ocrContent,
          ),
          initialChildren: children,
        );

  static const String name = 'ResultPageRoute';

  static const _i17.PageInfo<ResultPageRouteArgs> page =
      _i17.PageInfo<ResultPageRouteArgs>(name);
}

class ResultPageRouteArgs {
  const ResultPageRouteArgs({
    this.key,
    this.title,
    this.image,
    this.ocrContent,
  });

  final _i18.Key? key;

  final String? title;

  final _i20.Image? image;

  final List<String>? ocrContent;

  @override
  String toString() {
    return 'ResultPageRouteArgs{key: $key, title: $title, image: $image, ocrContent: $ocrContent}';
  }
}

/// generated route for
/// [_i15.LearnPage]
class LearnPageRoute extends _i17.PageRouteInfo<void> {
  const LearnPageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LearnPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LearnPageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i16.ReviewPage]
class ReviewPageRoute extends _i17.PageRouteInfo<void> {
  const ReviewPageRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ReviewPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReviewPageRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
