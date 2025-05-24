
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Item {
  String name;
  double deposit;
  double withdraw;

  Item({required this.name, this.deposit = 0, this.withdraw = 0});

  double get total => deposit - withdraw;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'محاسب قهوة المصريين',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: AccountingPage(),
    );
  }
}

class AccountingPage extends StatefulWidget {
  @override
  _AccountingPageState createState() => _AccountingPageState();
}

class _AccountingPageState extends State<AccountingPage> {
  final List<Item> items = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController depositController = TextEditingController();
  final TextEditingController withdrawController = TextEditingController();

  void addItem() {
    final name = nameController.text;
    final deposit = double.tryParse(depositController.text) ?? 0;
    final withdraw = double.tryParse(withdrawController.text) ?? 0;

    if (name.isNotEmpty) {
      setState(() {
        items.add(Item(name: name, deposit: deposit, withdraw: withdraw));
        nameController.clear();
        depositController.clear();
        withdrawController.clear();
      });
    }
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('محاسب قهوة المصريين')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(controller: nameController, decoration: InputDecoration(labelText: 'الصنف'))),
                SizedBox(width: 8),
                Expanded(child: TextField(controller: depositController, decoration: InputDecoration(labelText: 'إيداع (+)'), keyboardType: TextInputType.number)),
                SizedBox(width: 8),
                Expanded(child: TextField(controller: withdrawController, decoration: InputDecoration(labelText: 'سحب (-)'), keyboardType: TextInputType.number)),
                SizedBox(width: 8),
                ElevatedButton(onPressed: addItem, child: Text('إضافة')),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('إيداع: +${item.deposit}'),
                          Text('سحب: -${item.withdraw}'),
                          Text('الإجمالي: ${item.total}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteItem(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
