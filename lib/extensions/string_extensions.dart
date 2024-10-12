part of 'extensions.dart';

extension StringExtension on String {
  /// `String` metni normal forma çevirir
  /// ### Örnek
  /// ```dart
  /// String foo = 'öRnEK';
  /// String cFoo = foo.capitalize; // 'Örnek' dönecektir.
  /// ```
  String? get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Verilen `String` ifadenin mail adresi olup olmadıgını kontrol eder
  /// ### Örnek
  /// ```dart
  /// String foo = 'ornek@mail.com';
  /// bool isMail = foo.isMail; // true döner
  /// ```
  bool get isMail {
    if (isEmpty) return false;
    var regex = RegExp(r"(^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$)");
    return regex.hasMatch(this);
  }

  /// Verilen `String` Türkçe metni küçük harflerle tekrar yazar
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
        case 'Ü':
          result += 'ü';
        case 'Ö':
          result += 'ö';
        case 'Ş':
          result += 'ş';
        case 'Ç':
          result += 'ç';
        default:
          result += char.toLowerCase();
      }
    }
    return result;
  }

  /// Verilen `String` Türkçe metni büyük harflerle tekrar yazar
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
        case 'ü':
          result += 'Ü';
        case 'ö':
          result += 'Ö';
        case 'ş':
          result += 'Ş';
        case 'ç':
          result += 'Ç';
        default:
          result += char.toUpperCase();
      }
    }
    return result;
  }

  /// Yalnızca latin harflere sahip olan `String`i döndürür
  /// ### Örnek
  /// ```dart
  /// String foo = '4*%^55/ru4w5523it1s';
  /// String onlyLatin = foo.onlyLatin; // 'ruwis' döner
  /// ```
  String? get onlyLatin {
    if (isEmpty) return this;
    var regex = RegExp(r'([^a-zA-Z\s]+)');
    return replaceAll(regex, '');
  }

  /// Verilen `String` içindeki HTML etiketlerini kaldırır
  String removeHtmlTags() => replaceAll(RegExp(r'<[^>]*>'), '');

  /// Verilen `String` metnin kaç kelime olduğunu döndürür
  ///
  /// The pattern is based on spaces.
  /// ### Example
  /// ```dart
  /// String foo = 'Merhaba sevgili kardeşim bugün nasılsın?';
  /// int count = foo.countWords; // 5 dönecektir.
  /// ```
  int get countWords {
    if (isEmpty) return 0;
    var words = trim().split(RegExp(r'(\s+)'));
    // Sembol ve sayıları [onlyLatin] eklentisiyle filtreliyoruz
    var filteredWords = words.where((e) => e.onlyLatin!.isNotEmpty);
    return filteredWords.length;
  }

  /// Verilen `String` ifadeden sayıları siler
  /// ### Örnek 1
  /// ```dart
  /// String foo = 'ru2784w3982is';
  /// String noNumbers = foo.removeNumbers; // 'ruwis' dönecektir.
  /// ```
  /// ### Örnek 2
  /// ```dart
  /// String foo = 'r-uw9043*is24';
  /// String noNumbers = foo.removeNumbers; // 'r-uw*is' dönecektir.
  /// ```
  String? get removeNumbers {
    if (isEmpty) return this;
    var regex = RegExp(r'(\d+)');
    return replaceAll(regex, '');
  }

  /// Verieln `String` metinden sadece sayıları döndürür
  /// ### Örnek
  /// ```dart
  /// String foo = '4*%^55/es4e5523nt1is';
  /// String onyNumbers = foo.onlyNumbers; // '455455231' dönecektir.
  /// ```
  String? get onlyNumbers {
    if (isEmpty) return this;
    var regex = RegExp(r'([^0-9]+)');
    return replaceAll(regex, '');
  }

  /// `String` metinden tüm özel karakterleri siler
  /// ### Örnek
  /// ```dart
  /// String foo = '/!@#\$%^\-&*()+",.?":{}|<>~_-`*%^/ese?:"///ntis/!@#\$%^&*(),.?":{}|<>~_-`';
  /// String removed = foo.removeSpecial; // 'esentis' dönecektir.
  /// ```
  String? get removeSpecialChars {
    if (isEmpty) return this;
    // ignore: unnecessary_raw_strings
    var regex = RegExp(r'[/!@#$%^\-&*()+",.?":{}|<>~_-`]');
    return replaceAll(regex, '');
  }

  /// Verilen `String` metnin bir IPv4 adresi olup olmadığını kontrol eder
  /// ### Örnek 1
  /// ```dart
  /// String foo = '192.168.1.14';
  /// bool isIpv4 = foo.isIpv4; // true dönecektir.
  /// ```
  /// ### Örnek 2
  /// ```dart
  /// String foo = '192.168.1.14.150.1225';
  /// bool isIpv4 = foo.isIpv4; // false dönecektir.
  /// ```
  bool get isIpv4 {
    if (isEmpty) return false;
    var regex = RegExp(
        r'((?:^|\s)([a-z]{3,6}(?=://))?(://)?((?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?)\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?))(?::(\d{2,5}))?(?:\s|$))');
    return regex.hasMatch(this);
  }

  /// Verilen `String` metnin bir IPv6 adresi olup olmadığını kontrol eder
  /// ### Örnek 1
  /// ```dart
  /// String foo = '2001:0db8:85a3:0000:0000:8a2e:0370:7334';
  /// bool isIpv6 = foo.isIpv6; // true dönecektir.
  /// ```
  /// ### Örnek 2
  /// ```dart
  /// String foo = '192.168.1.14.150.1225';
  /// bool isIpv6 = foo.isIpv6; // false dönecektir.
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

  /// Verilen `String` metnin bir `DateTime` olup olmadığını kontrol eder
  ///
  /// ### Doğru formatlar
  ///
  /// * dd/mm/yyyy
  /// * dd-mm-yyyyy
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

  /// Verilen `String`'in doğru bir `json` olup olmadığını kontrol eder.
  ///
  /// ### Örnek
  ///
  /// ```dart
  /// String foo = '{"name":"John","age":30,"cars":null}';
  /// bool isJson = foo.isJson; // true dönecektir.
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

  /// `String` metinden sadece harfleri siler.
  /// ### Örnek 1
  /// ```dart
  /// String foo = 'es4e5523nt1is';
  /// String noLetters = foo.removeLetters; // '455231' dönecektir.
  /// ```
  /// ### Örnek 2
  /// ```dart
  /// String foo = '1244e*s*4e*5523n*t*1i*s';
  /// String noLetters = foo.removeLetters; // '1244**4*5523**1*' dönecektir.
  /// ```
  String? get removeLetters {
    if (isEmpty) return this;
    // ignore: unnecessary_raw_strings
    var regex = RegExp(r'([a-zA-Z]+)');
    return replaceAll(regex, '');
  }

  /// Verilen `String` metni slug case biçimine dönüştürür.
  ///
  /// ### Örnek
  /// ```dart
  /// String foo = 'sLuG Case';
  /// String fooSlug = foo.toSlug; // 'sLuG_Case' dönecektir.
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

  /// Verilen `String` metni snake case biçimine dönüştürür.
  ///
  /// ### Örnek
  /// ```dart
  /// String foo = 'SNAKE CASE';
  /// String fooSNake = foo.toSnakeCase; // 'snake_case' dönecektir.
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

  /// Verilen `String` metni camel case biçimine dönüştürür.
  /// ### Örnek
  /// ```dart
  /// String foo = 'Find max of array';
  /// String camelCase = foo.toCamelCase; // 'findMaxOfArray' dönecektir.
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

  /// Verilen `String` metni title case biçimine dönüştürür.
  /// ### Örnek
  /// ```dart
  /// String foo = 'Merhaba sevgili kardeşim nasılsın?';
  /// Sting titleCased = foo.toTitleCase; // 'Merhaba Sevgili Kardeşim Nasılsın' dönecektir.
  /// ```
  String? get toTitleCase {
    if (isEmpty) return this;

    var words = trim().toLowerCase().split(' ');
    for (var i = 0; i < words.length; i++) {
      words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1);
    }

    return words.join(' ');
  }
}
