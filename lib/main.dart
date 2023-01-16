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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var overridingValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProviderScope(
              overrides: [
                baseProvider.overrideWithValue(overridingValue),
              ],
              child: const MyConsumer(),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ++overridingValue;
                });
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
    // the print line in listen below is executed only when this line is commented out
    // If you uncomment this line, the print line is not executed anymore.
    //
    // final q = ref.watch(baseProvider);

    // using a proxy provider bypasses this issue.
    // this is a dummy provider that relays baseProvider
    // baseProvider above still prevents listen. however this one allows listen.
    final c = ref.watch(baseProxyProvider);

    ref.listen(
      dependentProvider,
      (previous, next) {
        print('Listened to $previous -> $next');
      },
    );

    return const SizedBox.shrink();
  }
}
