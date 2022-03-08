import 'package:erp/app/models/produto.dart';
import 'package:erp/app/services/produto_service.dart';
import 'package:flutter/material.dart';

class ProdutoStore extends ValueNotifier<ProdutoState> {
  final ProdutoService produtoService;
  ProdutoStore(this.produtoService) : super(InitialProdutoState());

  fetchProdutos() async {
    value = LoadingProdutoState();
    List<Produto>? contatos = await produtoService.getProdutos();
    if (contatos != null) {
      value = SuccessProdutoState(contatos);
    } else {
      value = ErrorProdutoState();
    }
  }
}

abstract class ProdutoState {}

class InitialProdutoState extends ProdutoState {}

class LoadingProdutoState extends ProdutoState {}

class SuccessProdutoState extends ProdutoState {
  final List<Produto> produtos;
  SuccessProdutoState(this.produtos);
}

class ErrorProdutoState extends ProdutoState {}
