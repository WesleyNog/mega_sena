import 'package:flutter/material.dart';
import 'package:mega_sena/utils/ballNumber.dart';
import 'dart:async';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [];
  List<int> rollingNumbers = [];
  bool isSorted = false;
  bool isRolling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF005CA9), Color(0xFF2CB9B1)],
                stops: [0.5, 0.5],
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 50,
            child: Opacity(
              opacity: 0.9, // Opcional: para dar um leve blend
              child: Image.asset(
                'assets/mega-sena-logo.png',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 70,
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                'assets/megasena.png',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
          ),
          isSorted
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showNumbers(isRolling ? rollingNumbers : numbers),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await sortearNumerosComEfeito();
                              setState(() {
                                isSorted = true;
                              });
                            },
                            child: !isRolling
                                ? Icon(Icons.refresh)
                                : SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1e8fb0),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: !isRolling
                                ? () {
                                    setState(() {
                                      isSorted = false;
                                    });
                                  }
                                : null,
                            child: Text("Voltar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0366b4),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        await sortearNumerosComEfeito();
                        setState(() {
                          isSorted = true;
                        });
                      },
                      child: Text("Sortear", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1e8fb0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> sortearNumerosComEfeito() async {
    isSorted = true;
    isRolling = true;

    numbers = List.generate(6, (_) => 0);
    rollingNumbers = List.generate(6, (_) => Random().nextInt(60) + 1);

    setState(() {});

    final timer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      setState(() {
        rollingNumbers = List.generate(6, (_) => Random().nextInt(60) + 1);
      });
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    timer.cancel();

    // Sorteio real
    numbers.clear();
    while (numbers.length < 6) {
      int n = Random().nextInt(60) + 1;
      if (!numbers.contains(n)) numbers.add(n);
    }

    numbers.sort();

    isRolling = false;
    setState(() {});
  }
}
