import 'package:flutter/material.dart';
import '../app_data.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  bool esconderSenha = true;
  bool esconderConfirmacao = true;

  String estadoSelecionado = 'São Paulo';

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

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    cpfController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();

    super.dispose();
  }

  String formatarNome(String nome) {
    final palavras = nome
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+'));

    const palavrasMinusculas = {
      'da',
      'de',
      'do',
      'das',
      'dos',
      'e',
    };

    return palavras.map((palavra) {
      if (palavra.isEmpty) {
        return '';
      }

      if (palavrasMinusculas.contains(palavra)) {
        return palavra;
      }

      return palavra[0].toUpperCase() + palavra.substring(1);
    }).join(' ');
  }

  bool emailValido(String email) {
    return RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email);
  }

  void cadastrar() {
    final nome = formatarNome(nomeController.text);
    final email = emailController.text.trim().toLowerCase();
    final telefone = telefoneController.text.trim();
    final cpf = cpfController.text.trim();
    final senha = senhaController.text;
    final confirmarSenha = confirmarSenhaController.text;

    if (nome.isEmpty ||
        email.isEmpty ||
        telefone.isEmpty ||
        cpf.isEmpty ||
        senha.isEmpty ||
        confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha todos os campos obrigatórios.',
          ),
        ),
      );

      return;
    }

    if (nome.split(' ').length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite seu nome completo.',
          ),
        ),
      );

      return;
    }

    if (!emailValido(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Digite um e-mail válido.',
          ),
        ),
      );

      return;
    }

    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'A senha precisa ter pelo menos 6 caracteres.',
          ),
        ),
      );

      return;
    }

    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'As senhas não são iguais.',
          ),
        ),
      );

      return;
    }

    if (AppData.possuiConta) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Já existe uma conta neste protótipo.',
          ),
        ),
      );

      return;
    }

    AppData.criarConta(
      novoNome: nome,
      novoEmail: email,
      novoTelefone: telefone,
      novoCpf: cpf,
      novaSenha: senha,
    );

    Navigator.pop(
      context,
      email,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Crie sua conta ♻️',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Cadastre seus dados para utilizar o ReciclaApp.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Dados pessoais',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nomeController,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nome completo *',
                hintText: 'Ex: João da Silva',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'E-mail *',
                hintText: 'Ex: joao@email.com',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Telefone *',
                hintText: '(00) 00000-0000',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: cpfController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'CPF *',
                hintText: '000.000.000-00',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge_outlined),
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
                labelText: 'Estado *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.map_outlined),
              ),
              items: estados.map((estado) {
                return DropdownMenuItem(
                  value: estado,
                  child: Text(estado),
                );
              }).toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() {
                    estadoSelecionado = valor;
                  });
                }
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Senha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: senhaController,
              obscureText: esconderSenha,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Senha *',
                hintText: 'Mínimo de 6 caracteres',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderSenha = !esconderSenha;
                    });
                  },
                  icon: Icon(
                    esconderSenha
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmarSenhaController,
              obscureText: esconderConfirmacao,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Confirmar senha *',
                hintText: 'Digite a senha novamente',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      esconderConfirmacao =
                          !esconderConfirmacao;
                    });
                  },
                  icon: Icon(
                    esconderConfirmacao
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              '* Campos obrigatórios',
              style: TextStyle(
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: cadastrar,

                icon: const Icon(
                  Icons.person_add,
                ),

                label: const Text(
                  'CRIAR CONTA',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Seus dados pessoais não serão exibidos publicamente no aplicativo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}