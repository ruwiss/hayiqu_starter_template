[![Language - English](https://img.shields.io/badge/(Current)-English-9FE2BF)]()
[![Language - Türkçe](https://img.shields.io/badge/Language-Türkçe-2ea44f)](./README-tr.md)

# Hayiqu Starter Template

```bash
flutter pub add hayiqu
```

Hayiqu includes structures that you will use in most of your projects. We recommend using Hayiqu instead of writing the same codes over and over again.

## What does Hayiqu include?

* Provider for State Management and Dependency Injection with `GetIt` package along with `BaseViewModel` structure,

* `GoRouter` package for navigation,

* `DeviceInfoUtils`, `DeviceOrientationSettings`, and `PackageInfoUtils` packages to control the device,

* Different extensions for `Context`, `DateTime`, `Number`, and `String`,

* [SkeletonLoader](cci:2://file:///c:/Users/omer/Documents/Projeler/hayiqu/lib/src/ui/skeleton_loader.dart:9:0-29:1) widget structure for loading screens,

* A customized and easy-to-use `HttpService` structure based on Dio package,

* `BaseTheme` structure for application theme,

* `gap`, `flutter_svg`, `cached_network_image`, `toastification`, `modal_bottom_sheet` package, and `fluid dialog` widget structure for UI,

* `flutter_cache_manager` package for cache management,

* `crypto` package for encryption,

## Usage Examples

To add facilitating features to the ViewModel structure created with Provider, you can extend the `BaseViewModel` structure.



## Usage Examples

You can extend the BaseViewModel structure to add convenient features to the ViewModel structure created with Provider.


```dart
// Example usage
class MyViewModel with BaseViewModel {
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
You can use the GetIt package for Dependency Injection.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // HttpService is registered on GetIt by default.
  await setupLocator(() {
    // Register your GetIt service here
    getIt.registerLazySingleton<ApiRepository>(() => ApiService());
  });
  runApp(const MyApp());
}
```

___

To get detailed information about the current device;
```dart
print(await DeviceInfoUtils().getPlatformName());
print(await DeviceInfoUtils().getDeviceId());
```
___
For device-oriented screens;
```dart
await DeviceOrientationSettings.screenVertical();
await DeviceOrientationSettings.screenHorizontal();
await DeviceOrientationSettings.screenRight();
await DeviceOrientationSettings.screenLeft();
```
___
To get information about the application;
```dart
await PackageInfoUtils().init();

print(await PackageInfoUtils().getAppVersion());
print(await PackageInfoUtils().getAppName());
```
___

For loading (waiting) screens with content;
```dart
SkeletonLoader(
  loading: true,
  ...
  child: const HomeScreen(),
);
```
___
To customize or use HttpService;
```dart
final _httpService = getIt<HttpService>();

_httpService.enableLogger(true);
_httpService.setBaseUrl(baseUrl);
_httpService.setHeaders(headers);

_httpService.dio.options.connectTimeout = Duration(seconds: 5);
_httpService.dio.interceptors.add(...dummyInterceptor);

// GET request (with cache)
final Result result = await _httpService.get(endpoint, useCache: true);
if (result.hasValue) {...}
if (result.hasError) { result.requireError.message.log(); // type: DioException }

// POST request
await _httpService.post(endpoint);

// PUT request
await _httpService.put(endpoint);

// DELETE request
await _httpService.delete(endpoint);

// Single file download
await _httpService.download(
  url: url,
  savePath: savePath,
  onProgress: (received, total) {
    // Progress handling
  },
);
```
___
Error / Result Management for [Result]
```dart
Future<Result<int, FirebaseException>> getUserId() async {
    try {
      final userId = await _authService.getUserId();
      return Result.value(input: userId);
    } on FirebaseException catch (e) {
      return Result.error(input: e);
    }
}

final result = await getUserId();

if (result.hasError) {
  result.requireError.log();
} else {
  result.requireValue.log();
}
```
___
For application theme;
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
          title: 'Example',
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
Gap usage
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
Fluid Dialog usage
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
      // New dialog page to be displayed
      builder: (context) => const SecondDialogPage(),
    ),
  ),
  child: const Text('Go to next page'),
),
```
___

Figma-style text with stroke effect
```dart
TextWithStroke(
    text: 'Flutter with Stroke',
    style: TextStyle(
    fontSize: 120,
    color: Color(0xFF7DCFFF),
    ),
),
```
___
RichTextWidget
```dart
body: Padding(
    padding: const EdgeInsets.all(8.0),
    child: RichTextWidget(
        styleForAll: Theme.of(context).textTheme.displayMedium,
        texts: [
        BaseText.plain(
            text: 'Welcome to my blog at ',
        ),
        BaseText.link(
            text: 'https://example.com/',
            onTap: () {
            'Tapped'.log();
            },
        ),
        ],
    ),
);
),
```
___
## Useful Extensions
### String Extensions
```dart
"exAmpLE".capitalize; // 'Example'
"example@gmail.com".isMail; // true
"örNek".toLowerCaseTurkish; // 'örnek'
"örNek".toUpperCaseTurkish; // 'ÖRNEK'
"örNek".onlyLatin; // 'rNek'
"<h1>Example</h1>".removeHtmlTags; // 'Example'
"Example text".countWords; // 2
"exam47p34le".removeNumbers; // 'example'
"exa1m24pl3e".onlyNumbers; // '1243'
"(example/!@#\$%^".removeSpecialChars; // 'example'
"es4e5523nt1is".removeLetters; // '455231'
"sLuG Case".toSlug; // 'sLuG_Case'
"SNAKE CASE".toSnakeCase; // 'snake_case'
"Find max of array".toCamelCase; // 'findMaxOfArray'
"Hello my name is example".toTitleCase; // 'Hello My Name Is Example'

// Reads the file on the Assets
// Returns Uint8List data
await 'images/template.png'.localFileData())
```
___
### DateTime Extensions
```dart
DateTime.now.passingTime(DateTime.now().add(Duration(days: 1))); // '1 day ago'
DateTime.now.passingTime(DateTime.now().add(Duration(days: 30))); // '30 days ago'
DateTime.now.passingTime(short: true, DateTime.now().add(Duration(days: 30))); // '30d'
```
___
### Number Extensions
```dart
12.sbh(); // SizedBox(height: 12)
12.sbw(); // SizedBox(width: 12)
0.2.vw; // Screen Width * 0.2
0.2.vh; // Screen Height * 0.2

```
___
### Context Extensions
```dart
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

... and more
```
___
### Function Extensions
```dart
// Waiting operation in VoidCallback functions
_counterClockwiseRotationController.forward.delayedCall(
    const Duration(
    seconds: 1,
    ),
);

// Future Unwrap function (Null Safety)
static Future<File> pickImageFromGallery() => _imagePicker
    .pickImage(source: ImageSource.gallery)
    .unwrap() // null check
    .then((xFile) => xFile.path)
    .then((filePath) => File(filePath))


// Future.futureBuilder() function
// This function performs the same function as FutureBuilde

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

    Future<String> getName() => Future.delayed(
        const Duration(seconds: 2),
        () => 'Example',
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getName().futureBuilder(
          onData: (_, name) => Text(name),
          onNone: onNone,
          // onError: ..,
          // onDoneWithoutDataOrError: ..,
          // onWaiting: ..,
        ),
      ),
    );
  }
}

```
___
### Stream Extensions
```dart
// Waiting operation between events
await for (final name in getNames().withTimeoutBetweenEvents(
    const Duration(
      seconds: 3,
    ),
  )) {
    // object.log extension
    name.log();
  }


// Stream Error Recovery operation
Stream<String> getNames() async* {
  yield 'Foo';
  yield 'Bar';
  throw Exception('Something went wrong');
}

final names = getNames().onErrorRecoverWith(
    (error) {
      error.log();
      return 'Baz';
    },
  );

await for (final name in names) {
    name.log(); // Foo, Bar, Baz
}

// Stopping the Stream itself if an error occurs
Stream<String> getNames() async* {
  yield 'Vandad';
  await Future.delayed(const Duration(seconds: 1));
  yield 'John';
  await Future.delayed(const Duration(seconds: 1));
  throw 'Enough names for you';
}

Future<void> testIt() async {
  await for (final name in getNames().absorbErrors()) {
    name.log(); // Vandad, John, then stream closes
  }
}
```
___
### Object Extensions
```dart
// Flattening the list
void testIt() {
  final flat = [
    [[1, 2, 3], 4, 5],
    [6, [7, [8, 9]], 10],
    11,12
  ].flatten().log();
  // (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
}

// Advanced Where filtering operation on Map object

people.where((key, value) => key.length > 4 && value > 20).log();
// {Peter: 22}

people.whereKey((key) => key.length < 5).log();
// {John: 20, Mary: 21}

people.whereValue((value) => value.isEven).log();
// {John: 20, Peter: 22}
```
