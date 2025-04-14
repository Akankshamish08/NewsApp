import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../widgets/no_internet.dart';
import 'connectivity_service.dart';

class ConnectivityListener extends StatelessWidget {
  final Widget child;

  const ConnectivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: ConnectivityService.connectivityStream,
      builder: (context, snapshot) {
        final isConnected =
        !(snapshot.data?.contains(ConnectivityResult.none) ?? true);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!isConnected) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const NoInternetScreen(),
            ));
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);
          }
        });

        return child;
      },
    );
  }
}