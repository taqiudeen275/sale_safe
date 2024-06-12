// ignore: file_names
import 'package:fluent_ui/fluent_ui.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sale_safe/screen/expense.dart';
import 'package:sale_safe/screen/home.dart';
import 'package:sale_safe/screen/inventory.dart';
import 'package:sale_safe/screen/sales.dart';
import 'package:sale_safe/screen/setting.dart';
import 'package:sale_safe/screen/suppliers.dart';
import 'package:sale_safe/utils/components/about_widget.dart';
import 'package:sale_safe/utils/components/modal.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(Iconsax.home),
      title: const Text('Home'),
      body: const HomeScreen(),
    ),
    PaneItemSeparator(),
    PaneItem(
        title: const Text('Inventory'),
        icon: const Icon(Iconsax.box),
        body: const ProductScreen()),
    PaneItem(
        title: const Text('Sales'),
        icon: const Icon(Iconsax.dollar_square),
        body: const SalesScreen()),
    PaneItem(
        title: const Text('Expense'),
        icon: const Icon(Iconsax.receipt),
        body: const ExpenseScreen()),
    PaneItem(
      
        title: const Text('Suppliers'),
        icon: const Icon(FluentIcons.business_card),
        body: const SuppplierScreen()),
  ];

  int topIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: PaneDisplayMode.compact,
        items: items,
        footerItems: [
          PaneItem(
            icon: const Icon(Iconsax.setting_4),
            title: const Text('Settings'),
            body: const SettingsScreen(),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.info),
            title: const Text('About'),
            onTap: () {
              actionModal(
                context,
                    const Text('About'),
              const AboutWidget(),
              [Button(child: const Text("Close"), onPressed: () =>Navigator.pop(context))] 
              );
            },
          ),
        ],
      ),
    );
  }
}
