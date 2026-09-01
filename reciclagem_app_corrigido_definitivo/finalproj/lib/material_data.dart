import 'package:flutter/material.dart';

class MaterialReciclavel {
  final String nome;
  final String descricao;
  final double valorPorKg;
  final IconData icone;

  const MaterialReciclavel({
    required this.nome,
    required this.descricao,
    required this.valorPorKg,
    required this.icone,
  });
}

class MaterialData {
  static const List<MaterialReciclavel> materiais = [
    MaterialReciclavel(
      nome: 'Alumínio',
      descricao: 'Latas de bebidas e outros materiais de alumínio.',
      valorPorKg: 6.50,
      icone: Icons.local_drink_outlined,
    ),
    MaterialReciclavel(
      nome: 'Cobre',
      descricao: 'Fios, cabos e outros materiais de cobre.',
      valorPorKg: 25.00,
      icone: Icons.bolt_outlined,
    ),
    MaterialReciclavel(
      nome: 'Papelão',
      descricao: 'Caixas e embalagens de papelão limpas e secas.',
      valorPorKg: 0.80,
      icone: Icons.inventory_2_outlined,
    ),
    MaterialReciclavel(
      nome: 'Papel',
      descricao: 'Folhas, jornais, revistas e outros papéis.',
      valorPorKg: 0.60,
      icone: Icons.description_outlined,
    ),
    MaterialReciclavel(
      nome: 'Plástico',
      descricao: 'Garrafas, embalagens e outros plásticos recicláveis.',
      valorPorKg: 1.20,
      icone: Icons.local_drink_outlined,
    ),
    MaterialReciclavel(
      nome: 'Ferro',
      descricao: 'Peças e objetos de ferro destinados à reciclagem.',
      valorPorKg: 0.70,
      icone: Icons.hardware_outlined,
    ),
    MaterialReciclavel(
      nome: 'Aço',
      descricao: 'Latas e outros materiais de aço recicláveis.',
      valorPorKg: 0.90,
      icone: Icons.settings_outlined,
    ),
    MaterialReciclavel(
      nome: 'PET',
      descricao: 'Garrafas e embalagens feitas de plástico PET.',
      valorPorKg: 2.00,
      icone: Icons.local_drink_outlined,
    ),
  ];
}
