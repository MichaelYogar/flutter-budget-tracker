import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker/api/models/item_model.dart';
import 'package:flutter_budget_tracker/api/view_model/item_viewmodel.dart';
import 'package:flutter_budget_tracker/components/widgets/charts/chart_line.dart';
import 'package:flutter_budget_tracker/components/widgets/charts/chart_pie.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ItemViewModel itemViewModel;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    itemViewModel = ItemViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<List<ItemModel>>(
          future: itemViewModel.getItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = items[index];
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.teal,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                    item.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    '${item.category} • ${DateFormat.yMd().format(item.purchaseDate)}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: Text(
                                    '-\$${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  IndexedStack(
                    index: _currentIndex,
                    children: [
                      ChartLine(items: items),
                      ChartPie(items: items),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }
            // Show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.addchart),
            label: 'Line Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_outlined),
            label: 'Pie Chart',
          ),
        ],
      ),
    );
  }
}
