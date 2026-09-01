import 'package:flutter/material.dart';
import '../app_data.dart';
import '../material_data.dart';
import 'endereco_page.dart';

class ColetaPage extends StatefulWidget {
  const ColetaPage({super.key});

  @override
  State<ColetaPage> createState() => _ColetaPageState();
}

class _ColetaPageState extends State<ColetaPage> {
  String? materialSelecionado;

  final pesoController = TextEditingController();
  final observacaoController = TextEditingController();

  @override
  void dispose() {
    pesoController.dispose();
    observacaoController.dispose();
    super.dispose();
  }

  double get valorEstimado {
    if (materialSelecionado == null) {
      return 0;
    }

    final material = MaterialData.materiais.firstWhere(
      (item) => item.nome == materialSelecionado,
    );

    final peso =
        double.tryParse(
          pesoController.text.replaceAll(',', '.'),
        ) ??
        0;

    return material.valorPorKg * peso;
  }

  String formatarDinheiro(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> escolherEndereco() async {
    if (materialSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione um material primeiro.',
          ),
        ),
      );
      return;
    }

    final peso =
        double.tryParse(
          pesoController.text.replaceAll(',', '.'),
        ) ??
        0;

    if (peso <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe uma quantidade aproximada válida.',
          ),
        ),
      );
      return;
    }

    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const EnderecoPage(),
      ),
    );

    if (!mounted) {
      return;
    }

    if (resultado == true) {
      setState(() {});
    }
  }

  void confirmarColeta() {
    if (materialSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione um material.',
          ),
        ),
      );
      return;
    }

    final peso =
        double.tryParse(
          pesoController.text.replaceAll(',', '.'),
        ) ??
        0;

    if (peso <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe uma quantidade aproximada válida.',
          ),
        ),
      );
      return;
    }

    if (AppData.estado == null ||
        AppData.cidade == null ||
        AppData.bairro == null ||
        AppData.rua == null ||
        AppData.numero == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Informe o endereço da coleta.',
          ),
        ),
      );
      return;
    }

    AppData.solicitarColeta(
      material: materialSelecionado!,
      peso: peso,
      observacao:
          observacaoController.text.trim(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Coleta solicitada! ♻️',
          ),
          content: const Text(
            'Sua solicitação foi registrada. Nossa equipe poderá analisar o pedido e realizar a coleta no endereço informado.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'CONCLUÍDO',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final enderecoCompleto =
        AppData.rua != null
            ? '${AppData.rua}, ${AppData.numero} - ${AppData.bairro}'
            : 'Nenhum endereço informado';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solicitar coleta',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Solicite sua coleta 🚛',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Informe o material e uma estimativa da quantidade que será coletada.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              '1. Escolha o material',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: materialSelecionado,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Material',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.recycling,
                ),
              ),
              items: MaterialData.materiais.map(
                (material) {
                  return DropdownMenuItem<String>(
                    value: material.nome,
                    child: Text(material.nome),
                  );
                },
              ).toList(),
              onChanged: (valor) {
                setState(() {
                  materialSelecionado = valor;
                });
              },
            ),

            const SizedBox(height: 30),

            const Text(
              '2. Quantidade aproximada',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Informe uma estimativa. A quantidade oficial será definida pela pesagem realizada pela equipe.',
              style: TextStyle(
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: pesoController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Peso aproximado',
                hintText: 'Ex: 10',
                suffixText: 'kg',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.scale_outlined,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    color: Colors.green.shade700,
                    size: 30,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Valor estimado',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          formatarDinheiro(
                            valorEstimado,
                          ),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight:
                                FontWeight.bold,
                            color:
                                Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              '3. Endereço da coleta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 30,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      enderecoCompleto,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: escolherEndereco,
                icon: const Icon(
                  Icons.edit_location_alt_outlined,
                ),
                label: Text(
                  AppData.rua == null
                      ? 'INFORMAR ENDEREÇO'
                      : 'ALTERAR ENDEREÇO',
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              '4. Observações',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: observacaoController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Observações',
                hintText:
                    'Ex: O material estará separado na garagem.',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: confirmarColeta,
                icon: const Icon(
                  Icons.local_shipping_outlined,
                ),
                label: const Text(
                  'SOLICITAR COLETA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'O peso e o valor finais serão definidos após a pesagem.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}