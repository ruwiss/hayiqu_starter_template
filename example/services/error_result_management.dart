import 'package:hayiqu/hayiqu.dart';

class AuthService {
  Future<int> getUserId() => Future.value(1);
}

Future<Result<int, Exception>> getUserId() async {
  final AuthService authService = AuthService();
  try {
    final userId = await authService.getUserId();
    return Result.value(input: userId);
  } catch (e) {
    return Result.error(input: e as Exception);
  }
}

void main() async {
  final result = await getUserId();

  if (result.hasError) {
    result.requireError.log();
  } else {
    result.requireValue.log();
  }
}
