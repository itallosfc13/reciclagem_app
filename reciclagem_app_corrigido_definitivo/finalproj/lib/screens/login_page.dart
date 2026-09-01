import 'package:flutter/material.dart';
import '../app_data.dart';
import 'cadastro_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController senhaController =
      TextEditingController();

  bool esconderSenha = true;

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  void entrar() {
    final email = emailController.text.trim().toLowerCase();
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha o e-mail e a senha.',
          ),
        ),
      );

      return;
    }

    if (!AppData.possuiConta) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nenhuma conta foi cadastrada. Crie sua conta primeiro.',
          ),
        ),
      );

      return;
    }

    if (email != AppData.email ||
        senha != AppData.senha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'E-mail ou senha incorretos.',
          ),
        ),
      );

      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  Future<void> criarConta() async {
  final emailCadastrado =
      await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (context) =>
          const CadastroPage(),
    ),
  );

  if (!mounted) {
    return;
  }

  if (emailCadastrado != null) {
    setState(() {
      emailController.text =
          emailCadastrado;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Conta criada! Agora entre com sua senha.',
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              Center(
                child: Container(
                  width: 90,
                  height: 90,

                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.recycling,
                    size: 55,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'ReciclaApp',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'Recicle, contribua e ganhe.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 45),

              const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Entre na sua conta para acompanhar suas coletas.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,

                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: senhaController,
                obscureText: esconderSenha,
                textInputAction: TextInputAction.done,

                onSubmitted: (_) {
                  entrar();
                },

                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  border: const OutlineInputBorder(),

                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),

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

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,

                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'A recuperação de senha será adicionada posteriormente.',
                        ),
                      ),
                    );
                  },

                  child: const Text(
                    'Esqueci minha senha',
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: entrar,

                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),

                    child: Text(
                      'ou',
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 52,

                child: OutlinedButton(
                  onPressed: criarConta,

                  child: const Text(
                    'CRIAR UMA CONTA',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  '♻️ Juntos por um mundo mais sustentável.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}