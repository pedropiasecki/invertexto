import 'package:flutter/material.dart';
import 'package:invertexto/view/busca_cep_page.dart';
import 'package:invertexto/view/busca_cpnj_page.dart';
import 'package:invertexto/view/busca_feriado_page.dart';
import 'package:invertexto/view/busca_fipe_page.dart';
import 'package:invertexto/view/por_extenso_page.dart';

class HomePage extends StatelessWidget {
	const HomePage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.black,
				centerTitle: true,
				title: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						Image.asset(
							'assets/imgs/logo.png',
							fit: BoxFit.contain,
							height: 40,
						),
					],
				),
			),
			backgroundColor: Colors.black,
			body: Padding(
				padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
				child: Column(children: [
					GestureDetector(
						child: Row(
							children: [
								Icon(Icons.edit, color: Colors.white, size: 50.0),
								Text("Por extenso", style: TextStyle(color: Colors.white, fontSize: 20.0)),
							],
						),
						onTap: () {
							Navigator.push(context, MaterialPageRoute(builder: (context) => PorExtenso()));
						},
					),

					GestureDetector(
						child: Row(
							children: [
								Icon(Icons.house, color: Colors.white, size: 50.0),
								Text("Busca CEP", style: TextStyle(color: Colors.white, fontSize: 20.0)),
							],
						),
						onTap: () {
							Navigator.push(context, MaterialPageRoute(builder: (context) => BuscaCep()));
						},
					),

                    // fazer mais 3 botoes junto de paginas (funcionando) durante aulas chefe!
                    GestureDetector(
						child: Row(
							children: [
								Icon(Icons.manage_search, color: Colors.white, size: 50.0),
								Text("Busca CNPJ", style: TextStyle(color: Colors.white, fontSize: 20.0)),
							],
						),
						onTap: () {
							Navigator.push(context, MaterialPageRoute(builder: (context) => BuscaCNPJ()));
						},
					),

                    GestureDetector(
						child: Row(
							children: [
								Icon(Icons.car_crash, color: Colors.white, size: 50.0),
								Text("Busca FIPE", style: TextStyle(color: Colors.white, fontSize: 20.0)),
							],
						),
						onTap: () {
							Navigator.push(context, MaterialPageRoute(builder: (context) => BuscaFIPE()));
						},
					),

                    GestureDetector(
						child: Row(
							children: [
								Icon(Icons.holiday_village, color: Colors.white, size: 50.0),
								Text("Busca Feriado", style: TextStyle(color: Colors.white, fontSize: 20.0)),
							],
						),
						onTap: () {
							Navigator.push(context, MaterialPageRoute(builder: (context) => BuscaFeriado()));
						},
					),
				]),
			),
		);
	}
}