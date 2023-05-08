import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_f9/presentation/root_container/widgets/desktop_root_container.dart';
import 'package:task_f9/presentation/root_container/widgets/mobile_root_container.dart';

class RootContainer extends StatelessWidget {
  static const String routeName = '/root';

  const RootContainer({super.key});

  static bool get isMobilePlatform => (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    return isMobilePlatform ? const MobileRootContainer() : const DesktopRootContainer();
  }
}
