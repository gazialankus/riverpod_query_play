import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseProvider = Provider<int>(
  (ref) => 0,
);

final dependentProvider = Provider<String>(
  (ref) {
    final q = ref.watch(baseProvider);
    return '$q';
  },
  dependencies: [baseProvider],
);
