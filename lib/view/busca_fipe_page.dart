import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class BuscaFIPE extends StatefulWidget {
	const BuscaFIPE({super.key});

	@override
	State<BuscaFIPE> createState() => _BuscaFIPEState();
}

class _BuscaFIPEState extends State<BuscaFIPE> {
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
							labelText: "Digite o FIPE",
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
                            future: apiService.buscaFIPE(campo),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                    return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 5.0,
                                    );
                                    default:
                                        final regexFipe = RegExp(r'^\d{6}-\d{1}$');

                                        if (!regexFipe.hasMatch(campo!)) {
                                            return Center(
                                                child: Text(
                                                    'Digite um código FIPE válido no formato 000000-0.',
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
			dados += "Marca: ${snapshot.data["brand"] ?? "Marca não disponível"}\n";
            dados += "Modelo: ${snapshot.data["model"] ?? "Modelo não disponível"}\n";
            dados += "Referência: ${snapshot.data["reference"] ?? "Referência não disponível"}\n";

            if (snapshot.data["years"] != null && snapshot.data["years"] is List) {
                for (var year in snapshot.data["years"]) {
                    dados += "Ano Modelo: ${year["model_year"] ?? "Ano não disponível"}\n";
                    dados += "Combustível: ${year["fuel"] ?? "Combustível não disponível"}\n";
                    dados += "Preço: ${year["price"] != null ? "R\$ ${year["price"]}" : "Preço não disponível"}\n";
            }
            } else {
                dados += "Anos/Preços não disponíveis\n";
            }
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