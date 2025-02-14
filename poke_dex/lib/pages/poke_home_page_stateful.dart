import 'package:flutter/material.dart';

class PokeHomeStatefull extends StatefulWidget {
  const PokeHomeStatefull({super.key});

  @override
  State<PokeHomeStatefull> createState() => _PokeHomeStatefullState();
}

class _PokeHomeStatefullState extends State<PokeHomeStatefull> {
  bool isLoading = true;
  List<String> listaPokemon = [];

  @override
  void initState() {
    super.initState();
    _carregandoDados();
  }

  Future<void> _carregandoDados() async {
    await Future.delayed(Duration(seconds: 4));
    listaPokemon = ["Haunter", "GuzzLord", "Decidueye"];
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("poke home Stateful")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return isLoading
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: listaPokemon.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listaPokemon[index]),
              );
            });
  }
}
