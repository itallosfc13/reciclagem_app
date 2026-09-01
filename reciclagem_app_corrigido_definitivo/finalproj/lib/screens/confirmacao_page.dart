import 'package:flutter/material.dart';
import 'status_page.dart';

class ConfirmacaoPage extends StatelessWidget {
  final List<String> materiais;
  final String quantidade;
  final String rua;
  final String numero;
  final String bairro;
  final String complemento;

  const ConfirmacaoPage({
    super.key,
    required this.materiais,
    required this.quantidade,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.complemento,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar coleta'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Confirme sua coleta 🚛',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Confira todas as informações antes de solicitar a coleta.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            _buildCard(
              titulo: 'Materiais',
              icone: Icons.recycling,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: materiais.map((material) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 20,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          material,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 15),

            _buildCard(
              titulo: 'Quantidade estimada',
              icone: Icons.scale,
              child: Text(
                '$quantidade kg',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            _buildCard(
              titulo: 'Endereço da coleta',
              icone: Icons.location_on,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    '$rua, $numero',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Bairro: $bairro',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  if (complemento.isNotEmpty) ...[
                    const SizedBox(height: 5),

                    Text(
                      'Complemento: $complemento',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.orange.shade200,
                ),
              ),

              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.info_outline,
                    size: 25,
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'O valor final dos materiais será definido após a pesagem realizada pela equipe de coleta.',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusPage(
                        materiais: materiais,
                        quantidade: quantidade,
                        rua: rua,
                        numero: numero,
                        bairro: bairro,
                        complemento: complemento,
                      ),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.local_shipping,
                ),

                label: const Text(
                  'CONFIRMAR COLETA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text(
                  'Voltar e editar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String titulo,
    required IconData icone,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(icone),

              const SizedBox(width: 10),

              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          child,
        ],
      ),
    );
  }
}