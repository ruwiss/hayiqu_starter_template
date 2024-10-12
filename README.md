<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Hayiqu Starter Template

Hayiqu, çoğu projenizde kullanacağınız yapıları içerir. Aynı kodları tekrar tekrar yazmak yerine Hayiqu'u kullanmanızı öneririz.

## Hayiqu Neleri İçerir?

* Provider ile State Yönetimi ve Dependency Injection için `GetIt` paketi ile beraber `BaseViewModel` yapısını,

* Navigasyon içn `GoRouter` paketi,

* Cihaz kontrolünü sağlayabilmek için `DeviceInfoUtils`, `DeviceOrientationSettings` ve `PackageInfoUtils` paketlerini,

* Birbirinden farklı `Context, DateTime, Number, String` eklentilerini,

* Yükleme ekranlarında kullanabilmek için `SkeletonLoader` widget yapısını,

* Dio paketinin özelleştirilmiş ve kullanımı kolay hale getirilmiş olan `HttpService` yapısını,

* Uygulama teması için `BaseTheme` yapısını,

* UI üzerinde kullanmak üzere `gap`, `flutter_svg`, `cached_network_image`, `toastification`, `modal_bottom_sheet` paketini ve `fluid dialog` widget yapısını,

* Cache yönetimi için `flutter_cache_manager` paketini,

* Şifreleme için `crypto` paketini içerir.

## Kullanım Örnekleri

Provider ile oluşturulan ViewModel yapısına kolaylaştırıcı özellikler kazandırmak için BaseViewModel yapısını extend edebilirsiniz.

```dart
class HomeViewmodel extends BaseViewModel {
  final _apiService = getIt<ApiRepository>();
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  HomeViewmodel() {
    runBusyFuture(_getTodos());
  }

  Future<void> _getTodos() async {
    _todos = await _apiService.getTodos();
  }
}
```

___
Dependency Injection için GetIt paketini kullanabilirsiniz.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Varsayılan olarak HttpService, GetIt üzerinde kayıtlıdır.
  await setupLocator(() {
    // GetIt servis kayıtlarınızı burada yapınız
    getIt.registerLazySingleton<ApiRepository>(() => ApiService());
  });
  runApp(const MyApp());
}
```

___

Mevcut cihaz ile ilgili detaylı bilgi almak için;
```dart
await DeviceInfoUtils().init();

print(await DeviceInfoUtils().getPlatformName());
print(await DeviceInfoUtils().getDeviceId());
print(await DeviceInfoUtils().getDeviceInfo());
```
___
Cihaz yönelimli ekranları için;
```dart
await DeviceOrientationSettings.screenVertical();
await DeviceOrientationSettings.screenHorizontal();
await DeviceOrientationSettings.screenRight();
await DeviceOrientationSettings.screenLeft();
```
___
Uygulama hakkında bilgi almak için;
```dart
await PackageInfoUtils().init();

print(await PackageInfoUtils().getAppVersion());
print(await PackageInfoUtils().getAppName());
```
___

İçerikleri yükleme (bekleme) ekranları için;
```dart
SkeletonLoader(
  loading: true,
  ...
  child: const HomeScreen(),
);
```
___
HttpService'i özelleştirmek veya kullanmak için;
```dart
final _httpService = getIt<HttpService>();

_httpService.enableLogger(true);
_httpService.setBaseUrl(baseUrl);
_httpService.setHeaders(headers);

_httpService.dio.options.connectTimeout = Duration(seconds: 5);
_httpService.dio.interceptors.add(...dummyInterceptor);

// GET isteği (Önbellek ile birlikte)
await _httpService.get(endpoint, useCache: true);

// POST isteği
await _httpService.post(endpoint);

// PUT isteği
await _httpService.put(endpoint);

// DELETE isteği
await _httpService.delete(endpoint);

// Tek dosya indirme
await _httpService.download(
  url: url,
  savePath: savePath,
  onProgress: (received, total) {
    // İlerleme işlemi
  },
);
```
___
Uygulama teması için;
```dart
// app/theme.dart
class ThemeProvider extends BaseTheme {}


// main.dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
      ],
      builder: (context, child) {
        final themeProvider = context.watch<ThemeProvider>();
        return MaterialApp.router(
          title: 'Örnek',
          theme: themeProvider.themeData,
          themeMode: themeProvider.themeMode,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
```
___
Gap kullanımı
```dart
Row(
    children: [
      Gap(10),
      Text('Hello'),
      Gap(10),
    ],
)
...
Column(
    children: [
      Gap(5),
      Text('World'),
      Gap(5),
    ],
)
```
___
Fluid Dialog kullanımı
```dart
OutlinedButton(
    onPressed: () {
        showDialog(
        context: context,
        builder: (context) => FluidDialog(
            rootPage: FluidDialogPage(
            alignment: Alignment.bottomCenter,
            builder: (context) => const TestDialog(),
            ),
        ),
        );
    },
    child: const Text('Open Dialog'),
),

//--- TestDialog Widget

TextButton(
  onPressed: () => DialogNavigator.of(context).push(
    FluidDialogPage(
        // Görüntülenecek yeni diyalog sayfası
      builder: (context) => const SecondDialogPage(),
    ),
  ),
  child: const Text('Go to next page'),
),
```
___
Kullanışlı Eklentiler
```dart
<!-- String Extensions -->
"örNek".capitalize; // 'Örnek'
"ornek@gmail.com".isMail; // true
"örNek".toLowerCaseTurkish; // 'örnek'
"örNek".toUpperCaseTurkish; // 'ÖRNEK'
"örNek".onlyLatin; // 'rNek'
"<h1>Örnek</h1>".removeHtmlTags; // 'Örnek'
"Örnek metin".countWords; // 2
"örnek124d3".removeNumbers; // 'örnekd'
"örnek124d3".onlyNumbers; // '1243'
"(asda/!@#\$%^".removeSpecialChars; // 'asda'
"es4e5523nt1is".removeLetters; // '455231'
"sLuG Case".toSlug; // 'sLuG_Case'
"SNAKE CASE".toSnakeCase; // 'snake_case'
"Find max of array".toCamelCase; // 'findMaxOfArray'
"Merhaba sevgili kardeşim".toTitleCase; // 'Merhaba Sevgili Kardeşim'


<!-- DateTime Extensions -->
DateTime.now.passingTime(DateTime.now().add(Duration(days: 1))); // '1 gün önce'
DateTime.now.passingTime(DateTime.now().add(Duration(days: 30))); // '30 gün önce'

DateTime.now.passingTimeSort(DateTime.now().add(Duration(days: 1))); // '1g'
DateTime.now.passingTimeSort(DateTime.now().add(Duration(days: 30))); // '30g'


<!-- Number Extensions -->
12.sbh(); // SizedBox(height: 12)
12.sbw(); // SizedBox(width: 12)
0.2.vw; // Screen Width * 0.2
0.2.vh; // Screen Height * 0.2

<!-- Context Extensions -->
context.colors; // Theme.of(context).colorScheme
context.textTheme; // Theme.of(context).textTheme
context.mediaQuery; // MediaQuery.of(context)
context.height; // MediaQuery.sizeOf(context).height
context.width; // MediaQuery.sizeOf(context).width

context.lowValue; // context.height * 0.01
context.defaultValue; // context.height * 0.02
context.highValue; // context.height * 0.05
context.veryhighValue1x; // context.height * 0.1
context.veryhighValue2x; // context.height * 0.2
context.veryhighValue3x; // context.height * 0.3
context.veryhighValue4x; // context.height * 0.4
context.veryhighValue5x; // context.height * 0.5

context.dynamicWidth(0.2); // context.width * 0.2
context.dynamicHeight(0.2); // context.height * 0.2

context.paddingAllLow; // EdgeInsets.all(context.lowValue)
context.paddingAllDefault; // EdgeInsets.all(context.defaultValue)
context.paddingAllHigh; // EdgeInsets.all(context.highValue)
context.paddingHorizontalLow; // EdgeInsets.symmetric(horizontal: context.lowValue)
context.paddingHorizontalDefault; // EdgeInsets.symmetric(horizontal: context.defaultValue)
context.paddingHorizontalHigh; // EdgeInsets.symmetric(horizontal: context.highValue)

context.paddingVerticalLow; // EdgeInsets.symmetric(vertical: context.lowValue)
context.paddingVerticalDefault; // EdgeInsets.symmetric(vertical: context.defaultValue)
context.paddingVerticalHigh; // EdgeInsets.symmetric(vertical: context.highValue)

context.paddingRightLow; // EdgeInsets.only(right: context.lowValue)
context.paddingRightDefault; // EdgeInsets.only(right: context.defaultValue)
context.paddingRightHigh; // EdgeInsets.only(right: context.highValue)

context.paddingLeftLow; // EdgeInsets.only(left: context.lowValue)
context.paddingLeftDefault; // EdgeInsets.only(left: context.defaultValue)
context.paddingLeftHigh; // EdgeInsets.only(left: context.highValue)

context.paddingTopLow; // EdgeInsets.only(top: context.lowValue)
context.paddingTopDefault; // EdgeInsets.only(top: context.defaultValue)
context.paddingTopHigh; // EdgeInsets.only(top: context.highValue)

context.paddingBottomLow; // EdgeInsets.only(bottom: context.lowValue)
context.paddingBottomDefault; // EdgeInsets.only(bottom: context.defaultValue)
context.paddingBottomHigh; // EdgeInsets.only(bottom: context.highValue)
```
