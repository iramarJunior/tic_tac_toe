import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/alert_dialog.dart';
import 'package:tic_tac_toe/components/player.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) => Container();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOf = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _clearBoard();
              })
        ],
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildPointsTable(),
            _buildGrid(),
            _buildTurn(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsTable() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Player(score: _scoreO, name: 'Player O'),
            Player(score: _scoreX, name: 'Player X')
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Expanded(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _tapped(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.0),
                ),
                child: Center(
                  child: Text(
                    _xOrOList[index],
                    style: TextStyle(
                      color:
                          _xOrOList[index] == 'x' ? Colors.blue : Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTurn() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Text(
          _turnOf ? 'Turn of O' : 'Turn of X',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (_turnOf && _xOrOList[index] == '') {
        _xOrOList[index] = 'o';
        _filledBoxes += 1;
      } else if (!_turnOf && _xOrOList[index] == '') {
        _xOrOList[index] = 'x';
        _filledBoxes += 1;
      }

      _turnOf = !_turnOf;
      _checkTheWinner();
    });
  }

  void _checkTheWinner() {
    // check first row
    if (_xOrOList[0] == _xOrOList[1] &&
        _xOrOList[0] == _xOrOList[2] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second row
    if (_xOrOList[3] == _xOrOList[4] &&
        _xOrOList[3] == _xOrOList[5] &&
        _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      return;
    }

    // check third row
    if (_xOrOList[6] == _xOrOList[7] &&
        _xOrOList[6] == _xOrOList[8] &&
        _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      return;
    }

    // check first column
    if (_xOrOList[0] == _xOrOList[3] &&
        _xOrOList[0] == _xOrOList[6] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second column
    if (_xOrOList[1] == _xOrOList[4] &&
        _xOrOList[1] == _xOrOList[7] &&
        _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      return;
    }

    // check third column
    if (_xOrOList[2] == _xOrOList[5] &&
        _xOrOList[2] == _xOrOList[8] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    // check diagonal
    if (_xOrOList[0] == _xOrOList[4] &&
        _xOrOList[0] == _xOrOList[8] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check diagonal
    if (_xOrOList[2] == _xOrOList[4] &&
        _xOrOList[2] == _xOrOList[6] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'The match ended in a draw'
            : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOrOList[i] = '';
      }
    });

    _filledBoxes = 0;
  }
}
