import 'package:compras/views/editaItem.page.dart';
import 'package:compras/views/explicacao1.page.dart';
import 'package:compras/views/explicacao2.page.dart';
import 'package:compras/views/lista.page.dart';
import 'package:compras/views/novoItem.page.dart';
import 'package:flutter/material.dart';
import 'package:compras/views/begin.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: const Color(0xffffffff),
      ),
      routes: {
        '/': (context) => BeginPage(),
        '/explica1': (context) => Explica1Page(),
        '/explica2': (context) => Explica2Page(),
        '/lista': (context) => ListaPage(),
        '/novoItem': (context) => NovoItemPage(),
        '/editaItem': (context) => EditaItemPage(),
      },
      initialRoute: '/',
    );
  }
}
