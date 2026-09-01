import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  final List<String> materiais;
  final String quantidade;
  final String rua;
  final String numero;
  final String bairro;
  final String complemento;

  const StatusPage({
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
        title: const Text('Minha coleta'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Ícone de sucesso
            Center(
              child: Container(
                width: 90,
                height: 90,

                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.check,
                  size: 55,
                  color: Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Título
            const Center(
              child: Text(
                'Coleta solicitada!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                'Sua solicitação foi registrada com sucesso.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Número da solicitação
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                children: [
                  const Text(
                    'Número da solicitação',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '#${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Status da coleta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _buildStatus(
              icone: Icons.check_circle,
              titulo: 'Solicitação recebida',
              descricao: 'Sua solicitação foi registrada.',
              ativo: true,
            ),

            _buildLinha(),

            _buildStatus(
              icone: Icons.calendar_month,
              titulo: 'Aguardando agendamento',
              descricao: 'Nossa equipe irá definir a data da coleta.',
              ativo: false,
            ),

            _buildLinha(),

            _buildStatus(
              icone: Icons.local_shipping,
              titulo: 'Caminhão a caminho',
              descricao: 'Você será avisado quando a equipe estiver a caminho.',
              ativo: false,
            ),

            _buildLinha(),

            _buildStatus(
              icone: Icons.scale,
              titulo: 'Pesagem',
              descricao: 'Os materiais serão pesados pela equipe.',
              ativo: false,
            ),

            _buildLinha(),

            _buildStatus(
              icone: Icons.done_all,
              titulo: 'Coleta concluída',
              descricao: 'O valor e os pontos serão registrados.',
              ativo: false,
            ),

            const SizedBox(height: 25),

            // Informações
            _buildInfoCard(),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },

                icon: const Icon(
                  Icons.home,
                ),

                label: const Text(
                  'VOLTAR PARA O INÍCIO',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus({
    required IconData icone,
    required String titulo,
    required String descricao,
    required bool ativo,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(
          width: 42,
          height: 42,

          decoration: BoxDecoration(
            color: ativo
                ? Colors.green.shade100
                : Colors.grey.shade200,
            shape: BoxShape.circle,
          ),

          child: Icon(
            icone,
            color: ativo
                ? Colors.green
                : Colors.grey,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ativo
                      ? Colors.green
                      : Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                descricao,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinha() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        top: 5,
        bottom: 5,
      ),

      height: 25,

      width: 2,

      color: Colors.grey.shade300,
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),

        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            'Resumo da coleta',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Materiais:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            materiais.join(', '),
          ),

          const SizedBox(height: 12),

          const Text(
            'Quantidade estimada:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            '$quantidade kg',
          ),

          const SizedBox(height: 12),

          const Text(
            'Endereço:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            '$rua, $numero\n'
            '$bairro'
            '${complemento.isNotEmpty ? '\n$complemento' : ''}',
          ),
        ],
      ),
    );
  }
}