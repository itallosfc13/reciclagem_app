import 'package:flutter/material.dart';
import '../app_data.dart';

class EnderecoPage extends StatefulWidget {
  const EnderecoPage({super.key});

  @override
  State<EnderecoPage> createState() =>
      _EnderecoPageState();
}

class _EnderecoPageState
    extends State<EnderecoPage> {
  final cidadeController = TextEditingController();
  final bairroController = TextEditingController();
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController =
      TextEditingController();

  String estadoSelecionado = 'São Paulo';
  String tipoResidencia = 'Casa';

  final List<String> estados = [
    'Acre',
    'Alagoas',
    'Amapá',
    'Amazonas',
    'Bahia',
    'Ceará',
    'Distrito Federal',
    'Espírito Santo',
    'Goiás',
    'Maranhão',
    'Mato Grosso',
    'Mato Grosso do Sul',
    'Minas Gerais',
    'Pará',
    'Paraíba',
    'Paraná',
    'Pernambuco',
    'Piauí',
    'Rio de Janeiro',
    'Rio Grande do Norte',
    'Rio Grande do Sul',
    'Rondônia',
    'Roraima',
    'Santa Catarina',
    'São Paulo',
    'Sergipe',
    'Tocantins',
  ];

  final List<String> tiposResidencia = [
    'Casa',
    'Apartamento',
    'Condomínio',
    'Comércio',
    'Outro',
  ];

  @override
  void initState() {
    super.initState();

    if (AppData.estado != null) {
      estadoSelecionado = AppData.estado!;
    }

    cidadeController.text =
        AppData.cidade ?? '';

    bairroController.text =
        AppData.bairro ?? '';

    ruaController.text =
        AppData.rua ?? '';

    numeroController.text =
        AppData.numero ?? '';

    complementoController.text =
        AppData.complemento ?? '';

    if (AppData.tipoResidencia != null) {
      tipoResidencia =
          AppData.tipoResidencia!;
    }
  }

  @override
  void dispose() {
    cidadeController.dispose();
    bairroController.dispose();
    ruaController.dispose();
    numeroController.dispose();
    complementoController.dispose();

    super.dispose();
  }

  void salvarEndereco() {
    final cidade =
        cidadeController.text.trim();

    final bairro =
        bairroController.text.trim();

    final rua =
        ruaController.text.trim();

    final numero =
        numeroController.text.trim();

    final complemento =
        complementoController.text.trim();

    if (cidade.isEmpty ||
        bairro.isEmpty ||
        rua.isEmpty ||
        numero.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha cidade, bairro, rua e número.',
          ),
        ),
      );

      return;
    }

    AppData.salvarEndereco(
      novoEstado: estadoSelecionado,
      novaCidade: cidade,
      novoBairro: bairro,
      novaRua: rua,
      novoNumero: numero,
      novoComplemento: complemento,
      novoTipoResidencia:
          tipoResidencia,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Endereço da coleta',
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
              'Onde devemos buscar?',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Informe o endereço onde os materiais estarão disponíveis para coleta.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Localização',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: estadoSelecionado,
              decoration: const InputDecoration(
                labelText: 'Estado',
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.map_outlined,
                ),
              ),
              items: estados.map(
                (estado) {
                  return DropdownMenuItem<String>(
                    value: estado,
                    child: Text(estado),
                  );
                },
              ).toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    estadoSelecionado =
                        valor;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: cidadeController,
              textCapitalization:
                  TextCapitalization.words,
              decoration:
                  const InputDecoration(
                labelText: 'Cidade',
                hintText: 'Ex: Barretos',
                border:
                    OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.location_city_outlined,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: bairroController,
              textCapitalization:
                  TextCapitalization.words,
              decoration:
                  const InputDecoration(
                labelText: 'Bairro',
                hintText: 'Ex: Los Angeles',
                border:
                    OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Endereço',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ruaController,
              textCapitalization:
                  TextCapitalization.words,
              decoration:
                  const InputDecoration(
                labelText: 'Rua / Avenida',
                hintText:
                    'Ex: Rua das Flores',
                border:
                    OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.signpost_outlined,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        numeroController,
                    keyboardType:
                        TextInputType.number,
                    decoration:
                        const InputDecoration(
                      labelText: 'Número',
                      hintText: '123',
                      border:
                          OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.pin_outlined,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: TextField(
                    controller:
                        complementoController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Complemento',
                      hintText: 'Apto 12',
                      border:
                          OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Tipo de local',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              initialValue: tipoResidencia,
              decoration:
                  const InputDecoration(
                labelText:
                    'Tipo de residência/local',
                border:
                    OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.home_outlined,
                ),
              ),
              items:
                  tiposResidencia.map(
                (tipo) {
                  return DropdownMenuItem<
                      String>(
                    value: tipo,
                    child: Text(tipo),
                  );
                },
              ).toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    tipoResidencia =
                        valor;
                  });
                }
              },
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: salvarEndereco,
                icon: const Icon(
                  Icons.check,
                ),
                label: const Text(
                  'SALVAR ENDEREÇO',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'O endereço será utilizado pela equipe responsável pela coleta.',
                textAlign:
                    TextAlign.center,
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