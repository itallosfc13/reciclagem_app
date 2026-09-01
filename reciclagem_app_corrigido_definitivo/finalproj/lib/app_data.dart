class AppData {
  // ==============================
  // DADOS DA CONTA
  // ==============================

  static String? nome;
  static String? email;
  static String? telefone;
  static String? cpf;
  static String? senha;

  // ==============================
  // DADOS FINANCEIROS
  // ==============================

  static int pontos = 0;
  static double dinheiroRecebido = 0.0;

  // ==============================
  // ENDEREÇO
  // ==============================

  static String? estado;
  static String? cidade;
  static String? bairro;
  static String? rua;
  static String? numero;
  static String? complemento;
  static String? tipoResidencia;

  // ==============================
  // DADOS DA COLETA
  // ==============================

  static String? materialSelecionado;
  static double pesoEstimado = 0.0;
  static String? observacaoColeta;

  static bool coletaSolicitada = false;

  static String statusColeta =
      'Nenhuma coleta solicitada';

  // ==============================
  // VERIFICAÇÃO DA CONTA
  // ==============================

  static bool get possuiConta {
    return email != null &&
        email!.isNotEmpty &&
        senha != null &&
        senha!.isNotEmpty;
  }

  // ==============================
  // CRIAR CONTA
  // ==============================

  static void criarConta({
    required String novoNome,
    required String novoEmail,
    required String novoTelefone,
    required String novoCpf,
    required String novaSenha,
  }) {
    nome = novoNome;
    email = novoEmail;
    telefone = novoTelefone;
    cpf = novoCpf;
    senha = novaSenha;

    pontos = 0;
    dinheiroRecebido = 0.0;
  }

  // ==============================
  // ADICIONAR PONTOS
  // ==============================

  static void adicionarPontos(int quantidade) {
    pontos += quantidade;
  }

  // ==============================
  // ADICIONAR DINHEIRO
  // ==============================

  static void adicionarDinheiro(double valor) {
    dinheiroRecebido += valor;
  }

  // ==============================
  // SALVAR ENDEREÇO
  // ==============================

  static void salvarEndereco({
    required String novoEstado,
    required String novaCidade,
    required String novoBairro,
    required String novaRua,
    required String novoNumero,
    required String novoComplemento,
    required String novoTipoResidencia,
  }) {
    estado = novoEstado;
    cidade = novaCidade;
    bairro = novoBairro;
    rua = novaRua;
    numero = novoNumero;
    complemento = novoComplemento;
    tipoResidencia = novoTipoResidencia;
  }

  // ==============================
  // SOLICITAR COLETA
  // ==============================

  static void solicitarColeta({
    required String material,
    required double peso,
    required String observacao,
  }) {
    materialSelecionado = material;
    pesoEstimado = peso;
    observacaoColeta = observacao;

    coletaSolicitada = true;
    statusColeta = 'Coleta solicitada';
  }

  // ==============================
  // CANCELAR COLETA
  // ==============================

  static void cancelarColeta() {
    coletaSolicitada = false;
    statusColeta = 'Coleta cancelada';

    materialSelecionado = null;
    pesoEstimado = 0.0;
    observacaoColeta = null;
  }

  // ==============================
  // LIMPAR CONTA
  // ==============================

  static void limparConta() {
    nome = null;
    email = null;
    telefone = null;
    cpf = null;
    senha = null;

    pontos = 0;
    dinheiroRecebido = 0.0;

    estado = null;
    cidade = null;
    bairro = null;
    rua = null;
    numero = null;
    complemento = null;
    tipoResidencia = null;

    materialSelecionado = null;
    pesoEstimado = 0.0;
    observacaoColeta = null;

    coletaSolicitada = false;
    statusColeta =
        'Nenhuma coleta solicitada';
  }
}