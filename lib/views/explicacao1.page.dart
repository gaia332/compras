import 'package:flutter/material.dart';

class Explica1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            child: Center(
              child: Text(
                "Para adicionar um novo item basta clicar no simbolo de mais no canto da tela",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            child: Center(
              child: Image(
                image: AssetImage('assets/images/explica1.png'),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
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
                    Navigator.of(context).pushNamed("/explica2");
                  },
                  child: Text(
                    "Proximo",
                    style: TextStyle(fontSize: 20),
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
