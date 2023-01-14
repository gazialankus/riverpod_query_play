import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_query_play/data.dart';

void main() {
  runApp(const ProviderScope(child: AppRoot()));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  var overridingValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MyConsumer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ++overridingValue;
                });
                ref.read(baseProvider.notifier).state = overridingValue;
              },
              child: const Text('increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyConsumer extends ConsumerWidget {
  const MyConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // When we use a StateProvider instead of ProviderScope, listen
    // always run if we have this line or not
    //
    // final q = ref.watch(baseProvider);

    ref.listen(
      dependentProvider,
      (previous, next) {
        print('Listened to $previous -> $next');
      },
    );

    return const SizedBox.shrink();
  }
}
