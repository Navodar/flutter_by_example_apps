import 'package:flutter/material.dart';
import 'package:me_suite/routes.dart' as routes;
import 'package:me_suite/middlewares/auth_middleware.dart';
import 'package:me_suite/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:me_suite/reducers/app_reducer.dart';

void main() => runApp(new MainApp());

class MainApp extends StatelessWidget {
  final String title = 'MeSuite';

  MainApp();

  @override
  Widget build(BuildContext context) {
    var store = new Store<AppState>(
      appReducer,
      initialState: new AppState(),
      distinct: true,
      middleware: []
        ..addAll(createAuthMiddleware(context))
        ..add(new LoggingMiddleware.printer()), //new
    );

    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: title,
        routes: routes.getRoutes(context, store),
        initialRoute: '/login',
      ),
    );
  }
}