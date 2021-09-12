import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.blueAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return this._userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAtNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(this._addNewTransaction),
        );
      },
    );
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    setState(() {
      final newTx = Transaction(
        DateTime.now().toString(),
        txTitle,
        txAmount,
        txDate,
      );
      this._userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      this._userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  double _getWidgetHeight(appBar, double ratio) {
    final mediaQuery = MediaQuery.of(context);
    return (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
        ratio;
  }

  List<Widget> _buildPortraitWidgets(appBar) {
    return [
      Container(
        height: _getWidgetHeight(appBar, 0.3),
        child: Chart(_recentTransactions),
      ),
      Container(
        height: _getWidgetHeight(appBar, 0.7),
        child: TransactionList(_userTransactions, _deleteTransaction),
      ),
    ].toList();
  }

  List<Widget> _buildLandscapeWidgets(appBar) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: this._showChart,
            onChanged: (val) {
              setState(() {
                this._showChart = val;
              });
            },
          ),
        ],
      ),
      this._showChart
          ? Container(
              height: _getWidgetHeight(appBar, 0.7),
              child: Chart(_recentTransactions),
            )
          : Container(
              height: _getWidgetHeight(appBar, 0.7),
              child: TransactionList(_userTransactions, _deleteTransaction),
            ),
    ].toList();
  }

  Widget _buildAppBar(BuildContext ctx) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => this._startAtNewTransaction(ctx),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => this._startAtNewTransaction(ctx),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = this._buildAppBar(context);
    final bodyWidget = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: isLandscape
              ? _buildLandscapeWidgets(appBar)
              : _buildPortraitWidgets(appBar),
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: bodyWidget,
            navigationBar: appBar as CupertinoNavigationBar,
          )
        : Scaffold(
            appBar: appBar as AppBar,
            body: bodyWidget,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAtNewTransaction(context),
            ),
          );
  }
}
