import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class BuscaCep extends StatefulWidget {
	const BuscaCep({super.key});

	@override
	State<BuscaCep> createState() => _BuscaCepState();
}

class _BuscaCepState extends State<BuscaCep> {
	String? campo;
	String? resultado;
	final apiService = InvertextoApiService();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.black,
				title: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Image.asset('assets/imgs/logo.png', fit: BoxFit.contain, height: 40),
					],
				),
				centerTitle: true,
				leading: IconButton(
					icon: Icon(Icons.arrow_back,
					color: Colors.white),
					onPressed: () {
						Navigator.pop(context);
					},
				),

			),
			backgroundColor: Colors.black,
			body: Padding(
				padding: EdgeInsets.all(10.0),
				child: Column(children: [
					TextField(
						decoration: InputDecoration(
							labelText: "Digite o CEP",
							labelStyle: TextStyle(color: Colors.white),
							border: OutlineInputBorder(),
						),
						keyboardType: TextInputType.number,
						style: TextStyle(color: Colors.white, fontSize: 18),
						onSubmitted: (value) {
							setState(() {
								campo = value;
							});
						},
					),
                    if (campo != null)
                        FutureBuilder(
                            future: apiService.buscaCEP(campo),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                    return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 5.0,
                                    );
                                    default:
                                        if (campo!.length != 8) {
                                            return Center(
                                                child: Text(
                                                    'Digite um CEP válido com 8 dígitos.',
                                                    style: TextStyle(color: Colors.white),
                                                ),
                                            );
                                        }

                                        if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Erro ao buscar os dados.',
                                                    style: TextStyle(color: Colors.white),
                                                ),
                                            );
                                        }

                                        return exibeResultado(context, snapshot);
                                }
                            },
                        ),
				]),
			)
		);
	}

	Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot) {
		String enderecoCompleto = '';
		if (snapshot.data != null) {
			enderecoCompleto += snapshot.data["street"] ?? "Rua não disponível";
			enderecoCompleto += "\n";
			enderecoCompleto += snapshot.data["neighborhood"] ?? "Bairro não disponível";
			enderecoCompleto += "\n";
			enderecoCompleto += snapshot.data["city"] ?? "Cidade não disponível";
			enderecoCompleto += "\n";
			enderecoCompleto += snapshot.data["state"] ?? "Estado não disponível";
		}
		return Padding(
			padding: EdgeInsets.only(top: 10.0),
			child: Text(
				enderecoCompleto, 
				style: TextStyle(color: Colors.white, fontSize: 18),
			)
		);
	}
}