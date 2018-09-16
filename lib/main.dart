import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokemon_app/pokemon.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poke App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Poke App'),
          backgroundColor: Colors.cyan,
        ),
        body: pokeHub == null
            ? Center(child: CircularProgressIndicator())
            : GridView.count(
                crossAxisCount: 2,
                children: pokeHub.pokemon
                    .map((poke) => Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 3.0,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img)))),
                                  Text(poke.name,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ]),
                          ),
                        ))
                    .toList()),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.cyan,
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
