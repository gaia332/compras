import 'package:flutter/material.dart';

class BeginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: Container(
                child: Image(
                  image: AssetImage('assets/images/title.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Center(
              child: Container(
                child: Image(
                  image: AssetImage('assets/images/compras.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orangeAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed("/explica1");
                },
                child: Text(
                  "Abrir Lista",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
