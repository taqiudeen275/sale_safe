import 'package:flutter/material.dart';
import 'package:sale_safe/utils/components/modal.dart';
import 'package:sale_safe/utils/components/orderPick.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
            onPressed: () {
              bigActionModal(
                  context, const Text("Add Sale"), OrderPick(), []);
            },
            child: const Text("Select Product"))
      ],
    );
  }
}
