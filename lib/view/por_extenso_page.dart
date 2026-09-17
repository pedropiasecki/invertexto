import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class PorExtenso extends StatefulWidget {
	const PorExtenso({super.key});

	@override
	State<PorExtenso> createState() => _PorExtensoState();
}

class _PorExtensoState extends State<PorExtenso> {
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
							labelText: "Digite um número",
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
                            future: apiService.convertePorExtenso(campo),
                            builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                    return CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        strokeWidth: 5.0,
                                    );
                                    default:
                                        if (campo!.isEmpty || double.tryParse(campo!) == null) {
                                            return Center(
                                                child: Text(
                                                    'Digite um número válido.',
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
		return Padding(
			padding: EdgeInsets.only(top: 10.0),
			child: 
				Text(
					snapshot.data["text"] ?? '',
					style: TextStyle(color: Colors.white, fontSize: 18),
					softWrap: true,
				),
		);
	}
}