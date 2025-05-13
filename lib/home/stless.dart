import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_trade/home/navigation.dart';
import 'package:pro_trade/provider/declare.dart';

class H extends ConsumerWidget {
  const H({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userControllerProvider); // Update to your provider name
    return Scaffold(
      body: Center(
        child: userState.when(
          data: (user) {
            if (user == null) {
              return const Text("No user data available");
            }
            return Scaffold(

            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text("Error: $error"),
        ),
      ),
    );
  }
}
