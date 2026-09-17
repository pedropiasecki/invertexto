import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class BuscaCNPJ extends StatefulWidget {
	const BuscaCNPJ({super.key});

	@override
	State<BuscaCNPJ> createState() => _BuscaCNPJState();
}

class _BuscaCNPJState extends State<BuscaCNPJ> {
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
							labelText: "Digite o CNPJ",
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
                            future: apiService.buscaCNPJ(campo),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                    return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 5.0,
                                    );
                                    default:
                                        if (campo!.length != 14) {
                                            return Center(
                                                child: Text(
                                                    'Digite um CNPJ válido com 14 dígitos.',
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
		String dados = '';
		if (snapshot.data != null) {
			dados += snapshot.data["razao_social"] ?? "Razão social não disponível";
			dados += "\n";
			dados += snapshot.data["nome_fantasia"] ?? "Nome não fantasia não disponível";
			dados += "\n";
			dados += snapshot.data["natureza_juridica"] ?? "Natureza juridica não disponível";
			dados += "\n";
			dados += snapshot.data["natureza_juridica_codigo"] ?? "Código Natureza juridica não disponível";
            dados += "\n";
            dados += snapshot.data["capital_social"] ?? "Capital social não disponível";
			dados += "\n";
			dados += snapshot.data["data_inicio"] ?? "Data inicio não disponível";
			dados += "\n";
            dados += snapshot.data["porte"] ?? "Porte não disponível";
			dados += "\n";
			dados += snapshot.data["tipo"] ?? "Tipo não disponível";
			dados += "\n";
            dados += snapshot.data["telefone1"] ?? "Telefone 1 não disponível";
			dados += "\n";
			dados += snapshot.data["telefone2"] ?? "Telefone 2 não disponível";
            dados += "\n";
            dados += snapshot.data["email"] ?? "Email não disponível";
		}
		return Padding(
			padding: EdgeInsets.only(top: 10.0),
			child: Text(
				dados, 
				style: TextStyle(color: Colors.white, fontSize: 18),
			)
		);
	}
}