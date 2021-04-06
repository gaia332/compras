import 'package:flutter/material.dart';

class Explica2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: 300,
              child: Center(
                child: Text(
                  "Deslize o item para esquerda ou direita para vizualizar as opções",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Icon(
              Icons.swipe,
              color: Colors.orange,
              size: 50,
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/desliza1.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/desliza2.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed("/lista");
                    },
                    child: Text(
                      "Proximo",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
