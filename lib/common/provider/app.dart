import 'package:flutter/material.dart';
import 'package:ge_english/common/entitys/entitys.dart';
import 'package:ge_english/common/utils/utils.dart';
import 'package:ge_english/common/values/values.dart';

/// 系统相应状态
class AppState with ChangeNotifier {
  bool? _isGrayFilter;
  int? _remainWords;
  int? _reReviewWords;
  List<Translate>? _items = [];
  int? _time;

  get isGrayFilter => _isGrayFilter;

  get remainWords => _remainWords;

  get reReviewWords => _reReviewWords;

  get items => _items;

  get time => _time;

  AppState({bool isGrayFilter = false, remainWords = 0}) {
    this._isGrayFilter = isGrayFilter;
    this._remainWords = StorageUtil().getInt(STORAGE_REMAIN_WORDS_KEY);
    if (_remainWords == null) {
      StorageUtil().setInt(STORAGE_REMAIN_WORDS_KEY, 0);
    }
    // 复习单词初始化
    this._reReviewWords = StorageUtil().getInt(STORAGE_REMAIN_REVIEW_WORDS_KEY);
    if (_reReviewWords == null) {
      StorageUtil().setInt(STORAGE_REMAIN_REVIEW_WORDS_KEY, 0);
    }
    // 每日刷新背诵记录
    this._time = StorageUtil().getInt(STORAGE_TIME_KEY);
    if (_time == null ||
        ((DateTime.now().millisecondsSinceEpoch - _time!) / (24 * 3600 * 1000))
                .floor() >
            0) {
      StorageUtil()
          .setInt(STORAGE_TIME_KEY, DateTime.now().millisecondsSinceEpoch);
      _remainWords = 0;
      _reReviewWords = 0;
      StorageUtil().setInt(STORAGE_REMAIN_WORDS_KEY, 0);
      StorageUtil().setInt(STORAGE_REMAIN_REVIEW_WORDS_KEY, 0);
    }
    _items = TranslateListObject.fromJson(
            StorageUtil().getJSON(STORAGE_TRANSLATION_RES_KEY))
        .translateList!;
  }

  // 切换灰色滤镜
  switchGrayFilter() {
    _isGrayFilter = !_isGrayFilter!;
    notifyListeners();
  }

  wordPlusOne() {
    _remainWords ??= 0;
    _remainWords = _remainWords!+1;
    StorageUtil().setInt(STORAGE_REMAIN_WORDS_KEY, _remainWords!);
    notifyListeners();
  }

  reviewWordPlusOne() {
    _reReviewWords ??= 0;
    _reReviewWords = _reReviewWords!+1;
    StorageUtil().setInt(STORAGE_REMAIN_REVIEW_WORDS_KEY, _reReviewWords!);
    notifyListeners();
  }

  removeData(Datum item) {
    for (var i = 0; i < _items!.length; i++) {
      if (item.id == _items?[i].id) {
        _items?[i].isCollection = false;
        notifyListeners();
        return;
      }
    }
  }
}
