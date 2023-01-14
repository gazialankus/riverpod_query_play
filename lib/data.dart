import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseProvider = Provider<int>(
  (ref) => 0,
);

final familyProvider = Provider.family<String, int>(
  (ref, arg) => 'model $arg',
);

final dependentProvider = Provider<String>(
  (ref) {
    final q = ref.watch(baseProvider);
    final m = ref.watch(familyProvider(q));
    return m;
  },
  dependencies: [
    baseProvider,
    familyProvider,
  ],
);
