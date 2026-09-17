import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class InvertextoApiService {
	final String _token = "27975|XwCu2jJxYh58bJhaNNU1m2lQruqqMUBP";

	Future<Map<String, dynamic>> convertePorExtenso(String? valor) async {
		try {
			final uri = Uri.parse(
				"https://api.invertexto.com/v1/number-to-words"
				"?token=$_token&number=$valor"
				"&language=pt"
			);
			final response = await http.get(uri);
			if (response.statusCode == 200) {
				return json.decode(response.body);
			} else {
				throw Exception('Erro ${response.statusCode}: ${response.body}');
			}
		} on SocketException {
			throw Exception('Erro de conexão com a internet');
		} catch (e) { rethrow; }
	}

	Future<Map<String, dynamic>> buscaCEP(String? valor) async {
		try {
			final uri = Uri.parse(
				"https://api.invertexto.com/v1/cep/$valor"
				"?token=$_token"
			);
			final response = await http.get(uri);
			if (response.statusCode == 200) {
				return json.decode(response.body);
			} else {
				throw Exception('Erro ${response.statusCode}: ${response.body}');
			}
		} on SocketException {
			throw Exception('Erro de conexão com a internet');
		} catch (e) { rethrow; }
	}

    Future<Map<String, dynamic>> buscaCNPJ(String? valor) async {
		try {
			final uri = Uri.parse(
				"https://api.invertexto.com/v1/cnpj/$valor"
				"?token=$_token"
			);
			final response = await http.get(uri);
			if (response.statusCode == 200) {
				return json.decode(response.body);
			} else {
				throw Exception('Erro ${response.statusCode}: ${response.body}');
			}
		} on SocketException {
			throw Exception('Erro de conexão com a internet');
		} catch (e) { rethrow; }
	}

    Future<Map<String, dynamic>> buscaFIPE(String? valor) async {
		try {
			final uri = Uri.parse(
				"https://api.invertexto.com/v1/fipe/years/$valor"
				"?token=$_token"
			);
			final response = await http.get(uri);
			if (response.statusCode == 200) {
				return json.decode(response.body);
			} else {
				throw Exception('Erro ${response.statusCode}: ${response.body}');
			}
		} on SocketException {
			throw Exception('Erro de conexão com a internet');
		} catch (e) { rethrow; }
	}

    Future<List<dynamic>> buscaFeriado(String? valor) async {
		try {
			final uri = Uri.parse(
				"https://api.invertexto.com/v1/holidays/$valor"
				"?token=$_token"
			);
			final response = await http.get(uri);
			if (response.statusCode == 200) {
				return json.decode(response.body) as List<dynamic>;
			} else {
				throw Exception('Erro ${response.statusCode}: ${response.body}');
			}
		} on SocketException {
			throw Exception('Erro de conexão com a internet');
		} catch (e) { rethrow; }
	}
}
