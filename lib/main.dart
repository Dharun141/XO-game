import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'X O Game',
      theme: ThemeData.dark(),
      home: const TicTacToeHome(),
    );
  }
}

class TicTacToeHome extends StatefulWidget {
  const TicTacToeHome({super.key});

  @override
  State<TicTacToeHome> createState() => _TicTacToeHomeState();
}

class _TicTacToeHomeState extends State<TicTacToeHome> {
  List<String> board = List.filled(9, '');
  bool isXTurn = true;
  String winner = '';

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      isXTurn = true;
      winner = '';
    });
  }

  void handleTap(int index) {
    if (board[index] != '' || winner != '') return;

    setState(() {
      board[index] = isXTurn ? 'X' : 'O';
      isXTurn = !isXTurn;
      winner = checkWinner();
    });
  }

  String checkWinner() {
    const List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a == b && b == c && a != '') {
        return a;
      }
    }

    if (!board.contains('')) return 'Draw';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('X O Game'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              winner == ''
                  ? 'Turn: ${isXTurn ? "X" : "O"}'
                  : winner == 'Draw'
                      ? 'It\'s a Draw!'
                      : 'Winner: $winner',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Board with fixed size (no scroll)
            SizedBox(
              width: 300,
              height: 300,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => handleTap(index),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        border: Border.all(color: Colors.white30, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(
                            color: board[index] == 'X'
                                ? Colors.redAccent
                                : Colors.greenAccent,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Restart Game',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

