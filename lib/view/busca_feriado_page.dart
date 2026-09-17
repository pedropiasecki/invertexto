import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class BuscaFeriado extends StatefulWidget {
	const BuscaFeriado({super.key});

	@override
	State<BuscaFeriado> createState() => _BuscaFeriadoState();
}

class _BuscaFeriadoState extends State<BuscaFeriado> {
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
							labelText: "Digite o ano",
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
                            future: apiService.buscaFeriado(campo!),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                        return CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            strokeWidth: 5.0,
                                        );

                                    default:
                                        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                                            return Center(
                                                child: Text(
                                                    'Nenhum feriado encontrado para este ano.',
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
            for (var feriado in snapshot.data) {
                dados += feriado["date"] ?? "Data não disponível";
                dados += "\n";
                dados += feriado["name"] ?? "Nome não disponível";
                dados += "\n";
                dados += feriado["type"] ?? "Tipo não disponível";
                dados += "\n";
                dados += feriado["level"] ?? "Nível não disponível";
                dados += "\n";
                dados += "\n";
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