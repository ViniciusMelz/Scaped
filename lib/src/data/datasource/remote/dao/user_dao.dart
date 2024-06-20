import 'package:scaped/src/domain/models/user.dart' as model;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'interfaces/i_crud.dart';

class UserDAO implements ICRUD<model.User> {
  UserDAO();

  final String table = 'profiles';

  PostgrestFilterBuilder<List<Map<String, dynamic>>> _baseGetQuery() {
    return Supabase.instance.client.from(table).select<List<Map<String, dynamic>>>('*');
  }

  @override
  Future<bool> delete(model.User data) async {
    //Não será feito nesta versão
    throw Exception('Não implementado');
  }

  @override
  Future<List<model.User>> getAll() async {
    return (await _baseGetQuery().eq('id', Supabase.instance.client.auth.currentUser!.id).order('created_at'))
        .map((e) => model.User.fromMap(e))
        .toList();
  }

  @override
  Future<bool> insert(model.User data) async {
    try {
      await Supabase.instance.client.from(table).insert({
        'id': Supabase.instance.client.auth.currentUser!.id,
        'name': data.name,
        'last_name': data.lastName,
        'avatar': data.avatar,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(model.User data) async {
    try {
      await Supabase.instance.client.from(table).update({
        'name': data.name,
        'last_name': data.lastName,
        'avatar': data.avatar,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', data.uuid);
      return true;
    } catch (e) {
      return false;
    }
  }
}
