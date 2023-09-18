import 'package:amazon_clone/features/account/view/widgets/account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopButtons extends ConsumerStatefulWidget {
  const TopButtons({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopButtonsState();
}

class _TopButtonsState extends ConsumerState<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {})
          ],
        ),
        Row(
          children: [
            AccountButton(text: 'Log out', onTap: () {}),
            AccountButton(text: 'You wish list', onTap: () {})
          ],
        ),
      ],
    );
  }
}
