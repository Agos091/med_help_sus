import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Med Help-SUS'),
          backgroundColor: Colors.blue,
        ),
        body: RansonCalculator(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class RansonCalculator extends StatefulWidget {
  @override
  _RansonCalculatorState createState() => _RansonCalculatorState();
}

class _RansonCalculatorState extends State<RansonCalculator> {
  String nome = '';
  int idade = 0;
  int leucocitos = 0;
  double glicemia = 0.0;
  int astTgo = 0;
  int ldh = 0;
  bool litaseBiliar = false;

  // armazenar a pontuacao
  int pontuacao = 0;
  String mortalidade = '';

  Widget buildInputField(String label, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget buildIntInputField(String label, Function(int) onChanged) {
    return TextField(
      onChanged: (value) => onChanged(int.parse(value)),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
    );
  }

  void _calcularEscoreRanson() {
    pontuacao = 0;

    if (!litaseBiliar) {
      if (idade > 55) pontuacao++;
      if (leucocitos > 16000) pontuacao++;
      if (glicemia > 11) pontuacao++;
      if (astTgo > 250) pontuacao++;
      if (ldh > 350) pontuacao++;
    } else {
      if (idade > 70) pontuacao++;
      if (leucocitos > 18000) pontuacao++;
      if (glicemia > 12.2) pontuacao++;
      if (astTgo > 250) pontuacao++;
      if (ldh > 400) pontuacao++;
    }
    if (pontuacao >= 7) {
      mortalidade = '100%';
    } else if (pontuacao >= 5) {
      mortalidade = '40%';
    } else if (pontuacao >= 3) {
      mortalidade = '15%';
    } else {
      mortalidade = '2%';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Formulário de Paciente', style: TextStyle(fontSize: 18)),
              buildInputField('Nome', (value) => nome = value),
              buildIntInputField('Idade', (value) => idade = value),
              buildIntInputField('Leucócitos', (value) => leucocitos = value),
              buildInputField(
                  'Glicemia', (value) => glicemia = double.parse(value)),
              buildIntInputField('AST/TGO', (value) => astTgo = value),
              buildIntInputField('LDH', (value) => ldh = value),
              Row(
                children: [
                  Text('Litíase biliar: '),
                  Checkbox(
                    value: litaseBiliar,
                    onChanged: (value) {
                      setState(() {
                        litaseBiliar = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _calcularEscoreRanson();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Calcular',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              if (pontuacao > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pontuação: $pontuacao',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Taxa de Mortalidade: $mortalidade',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
