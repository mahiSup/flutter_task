import 'helpers/bloc_fallbacks.dart';

Future<void> testExecutable(
    Future<void> Function() main,
    ) async {
  registerBlocFallbacks();

  await main();
}