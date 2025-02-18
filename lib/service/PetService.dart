import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/pet.dart';

class PetService {
  static const String baseUrl = 'http://10.121.138.198:8080/veterinario/';

  Future<List<Pet>> buscarPet() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Pet.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar veterinário');
    }
  }

  Future<void> criarPet(Pet pet  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(pet.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar pets');
    }
  }

  Future<void> atualizarPet(Pet pet) async {
    final response = await http.put(
      Uri.parse('$baseUrl${pet.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(pet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar pet');
    }
  }

  Future<void> deletarPet(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204) {
      print('Pet deletado com sucesso');
    } else {
      print('Erro ao deletar veterinario: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar pet');
    }
  }
}
