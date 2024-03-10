import 'package:flutter/material.dart';
import 'package:task/screens/login/login_screen.dart';

class CardPurchase extends StatelessWidget {
  void showUpgradeModal(BuildContext context) {
    _openUpgradeModal(context);
  }

  void _openUpgradeModal(BuildContext context) {
    final pageRoute = MaterialPageRoute(builder: (context) => LoginScreen());

    Navigator.of(context).pushReplacement(pageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 350.0, // Aumentei a largura do card
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          showUpgradeModal(context);
          // Adicione a lógica para a ação do card aqui
        },
        child: Card(
          color: Colors.blue, // Cor de fundo do card
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Diminuí o raio do borderRadius
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Diminuí o padding interno
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                       const Text(
                          'Task',
                          style: TextStyle(
                            fontSize: 16, // Diminuí o tamanho do texto
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Cor do texto
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal:
                                6.0, // Diminuí o tamanho do padding horizontal
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'PRO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  10.0, // Diminuí o tamanho da fonte da tag PRO
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Use o aplicativo sem anúncios',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white), // Diminuí o tamanho do texto
                    ),
                  ],
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      20.0), // Diminuí o raio do borderRadius
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      showUpgradeModal(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(
                          6.0), // Diminuí o tamanho do padding interno
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                        size: 16.0, // Diminuí o tamanho do ícone
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
