part of 'extensions.dart';

extension StringExtension on String {
  /// Converts the `String` text to normal form
  /// ### Example
  /// ```dart
  /// String foo = 'öRnEK';
  /// String cFoo = foo.capitalize; // 'Örnek' will be returned.
  /// ```
  String get capitalize {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Checks if the given `String` is an email address
  /// ### Example
  /// ```dart
  /// String foo = 'ornek@mail.com';
  /// bool isMail = foo.isMail; // returns true
  /// ```
  bool get isMail {
    if (isEmpty) return false;
    final regex = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(this);
  }

  /// Rewrites the given `String` Turkish text in lowercase
  String toLowerCaseTurkish() {
    String result = "";
    for (var char in characters) {
      switch (char) {
        case 'I':
          result += 'ı';
          break;
        case 'İ':
          result += 'i';
          break;
        case 'Ğ':
          result += 'ğ';
          break;
        case 'Ü':
          result += 'ü';
          break;
        case 'Ö':
          result += 'ö';
          break;
        case 'Ş':
          result += 'ş';
          break;
        case 'Ç':
          result += 'ç';
          break;
        default:
          result += char.toLowerCase();
      }
    }
    return result;
  }

  /// Rewrites the given `String` Turkish text in uppercase
  String toUpperCaseTurkish() {
    String result = "";
    for (var char in characters) {
      switch (char) {
        case 'ı':
          result += 'I';
          break;
        case 'i':
          result += 'İ';
          break;
        case 'ğ':
          result += 'Ğ';
          break;
        case 'ü':
          result += 'Ü';
          break;
        case 'ö':
          result += 'Ö';
          break;
        case 'ş':
          result += 'Ş';
          break;
        case 'ç':
          result += 'Ç';
          break;
        default:
          result += char.toUpperCase();
      }
    }
    return result;
  }

  /// Returns only the Latin characters from the `String`
  /// ### Example
  /// ```dart
  /// String foo = '4*%^55/ru4w5523it1s';
  /// String onlyLatin = foo.onlyLatin; // 'ruwis' will be returned
  /// ```
  String get onlyLatin {
    if (isEmpty) return '';
    final regex = RegExp(r'[^a-zA-Z\s]+');
    return replaceAll(regex, '');
  }

  /// Removes HTML tags from the given `String`
  String removeHtmlTags() => replaceAll(RegExp(r'<[^>]*>'), '');

  /// Returns the number of words in the given `String`
  ///
  /// The pattern is based on spaces.
  /// ### Example
  /// ```dart
  /// String foo = 'Merhaba sevgili kardeşim bugün nasılsın?';
  /// int count = foo.countWords; // 5 will be returned.
  /// ```
  int get countWords {
    if (isEmpty) return 0;
    final words = trim().split(RegExp(r'\s+'));
    final filteredWords = words.where((e) => e.onlyLatin.isNotEmpty);
    return filteredWords.length;
  }

  /// Removes numbers from the given `String`
  /// ### Example 1
  /// ```dart
  /// String foo = 'ru2784w3982is';
  /// String noNumbers = foo.removeNumbers; // 'ruwis' will be returned.
  /// ```
  String get removeNumbers {
    if (isEmpty) return '';
    final regex = RegExp(r'\d+');
    return replaceAll(regex, '');
  }

  /// Returns only the numbers from the given `String`
  /// ### Example
  /// ```dart
  /// String foo = '4*%^55/es4e5523nt1is';
  /// String onlyNumbers = foo.onlyNumbers; // '455455231' will be returned.
  /// ```
  String get onlyNumbers {
    if (isEmpty) return '';
    final regex = RegExp(r'[^0-9]+');
    return replaceAll(regex, '');
  }

  /// Removes all special characters from the `String`
  /// ### Example
  /// ```dart
  /// String foo = '/!@#\$%^\-&*()+",.?":{}|<>~_-`*%^/ese?:"///ntis/!@#\$%^&*(),.?":{}|<>~_-`';
  /// String removed = foo.removeSpecialChars; // 'esentis' will be returned.
  /// ```
  String get removeSpecialChars {
    if (isEmpty) return '';
    final regex = RegExp(r'[!@#$%^&*(),.?":{}|<>~`]');
    return replaceAll(regex, '');
  }

  /// Checks if the given `String` is a valid IPv4 address
  /// ### Example 1
  /// ```dart
  /// String foo = '192.168.1.14';
  /// bool isIpv4 = foo.isIpv4; // returns true
  /// ```
  bool get isIpv4 {
    if (isEmpty) return false;
    final regex = RegExp(
        r'^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    return regex.hasMatch(this);
  }

  /// Checks if the given `String` is a valid IPv6 address
  /// ### Example 1
  /// ```dart
  /// String foo = '2001:0db8:85a3:0000:0000:8a2e:0370:7334';
  /// bool isIpv6 = foo.isIpv6; // returns true
  /// ```
  bool get isIpv6 {
    if (isEmpty) return false;
    substring(0, 1);
    var regex = RegExp(
        r'(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))');
    return regex.hasMatch(this);
  }

  /// Checks whether the `String` is a valid URL.
  /// ### Example 1
  /// ```dart
  /// String foo = 'foo.1com';
  /// bool isUrl = foo.isUrl; // returns false
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = 'google.com';
  /// bool isUrl = foo.isUrl; // returns true
  /// ```
  bool get isUrl {
    if (isEmpty) return false;
    var regex = RegExp(
        r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)');
    return regex.hasMatch(this);
  }

  /// Checks whether the given `String` is a valid `DateTime`.
  ///
  /// ### Valid formats
  ///
  /// * dd/mm/yyyy
  /// * dd-mm-yyyy
  /// * dd.mm.yyyy
  /// * yyyy-mm-dd
  /// * yyyy-mm-dd hrs
  /// * 20120227 13:27:00
  /// * 20120227T132700
  /// * 20120227
  /// * +20120227
  /// * 2012-02-27T14Z
  /// * 2012-02-27T14+00:00
  /// * -123450101 00:00:00 Z": in the year -12345
  /// * 2002-02-27T14:00:00-0500": Same as "2002-02-27T19:00:00Z
  bool get isDate {
    if (isEmpty) return false;
    var regex = RegExp(
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$');
    if (regex.hasMatch(this)) {
      return true;
    }
    try {
      DateTime.parse(this);
      return true;
    } on FormatException {
      return false;
    }
  }

  /// Checks whether the given `String` is a valid `json`.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo = '{"name":"John","age":30,"cars":null}';
  /// bool isJson = foo.isJson; // returns true.
  /// ```
  bool isJson() {
    if (isEmpty) return false;
    try {
      jsonDecode(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Removes all letters from the `String`.
  /// ### Example 1
  /// ```dart
  /// String foo = 'es4e5523nt1is';
  /// String noLetters = foo.removeLetters; // returns '455231'.
  /// ```
  /// ### Example 2
  /// ```dart
  /// String foo = '1244e*s*4e*5523n*t*1i*s';
  /// String noLetters = foo.removeLetters; // returns '1244**4*5523**1*'.
  /// ```
  String? get removeLetters {
    if (isEmpty) return this;
    // ignore: unnecessary_raw_strings
    var regex = RegExp(r'([a-zA-Z]+)');
    return replaceAll(regex, '');
  }

  /// Converts the given `String` to slug case.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'sLuG Case';
  /// String fooSlug = foo.toSlug; // returns 'sLuG_Case'.
  /// ```
  String? get toSlug {
    if (isEmpty) return this;

    var words = trim().split(RegExp(r'(\s+)'));
    var slugWord = '';

    if (length == 1) return this;
    for (var i = 0; i <= words.length - 1; i++) {
      if (i == words.length - 1) {
        slugWord += words[i];
      } else {
        slugWord += '${words[i]}_';
      }
    }
    return slugWord;
  }

  /// Converts the given `String` to snake case.
  ///
  /// ### Example
  /// ```dart
  /// String foo = 'SNAKE CASE';
  /// String fooSnake = foo.toSnakeCase; // returns 'snake_case'.
  /// ```
  String? get toSnakeCase {
    if (isEmpty) return this;

    var words = toLowerCase().trim().split(RegExp(r'(\s+)'));
    var snakeWord = '';

    if (length == 1) return this;
    for (var i = 0; i <= words.length - 1; i++) {
      if (i == words.length - 1) {
        snakeWord += words[i];
      } else {
        snakeWord += '${words[i]}_';
      }
    }
    return snakeWord;
  }

  /// Converts the given `String` to camel case.
  /// ### Example
  /// ```dart
  /// String foo = 'Find max of array';
  /// String camelCase = foo.toCamelCase; // returns 'findMaxOfArray'.
  /// ```
  String? get toCamelCase {
    if (isEmpty) return this;

    var words = trim().split(RegExp(r'(\s+)'));
    var result = words[0].toLowerCase();
    for (var i = 1; i < words.length; i++) {
      result += words[i].substring(0, 1).toUpperCase() +
          words[i].substring(1).toLowerCase();
    }
    return result;
  }

  /// Converts the given `String` to title case.
  /// ### Example
  /// ```dart
  /// String foo = 'Hello dear sibling, how are you?';
  /// String titleCased = foo.toTitleCase; // returns 'Hello Dear Sibling, How Are You'.
  /// ```
  String? get toTitleCase {
    if (isEmpty) return this;

    var words = trim().toLowerCase().split(' ');
    for (var i = 0; i < words.length; i++) {
      words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1);
    }

    return words.join(' ');
  }

  /// Reads a file located in the assets.
  /// ```dart
  /// await 'images/template.png'.localFileData();
  /// ```
  Future<Uint8List> localFileData() => rootBundle.load(this).then(
        (byteData) => byteData.buffer.asUint8List(),
      );
}
