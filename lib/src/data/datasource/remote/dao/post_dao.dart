import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/models/post.dart';
import 'interfaces/i_crud.dart';

class PostDAO implements ICRUD<Post> {
  PostDAO();

  PostgrestFilterBuilder<List<Map<String, dynamic>>> _baseGetQuery() {
    return Supabase.instance.client.from('posts').select<List<Map<String, dynamic>>>('*, profiles(*)');
  }

  @override
  Future<bool> delete(Post data) async {
    try {
      await Supabase.instance.client.from('posts').delete().eq('id', data.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Post>> getAll() async {
    return (await _baseGetQuery().order('created_at')).map((e) => Post.fromMap(e)).toList();
  }

  @override
  Future<bool> insert(Post data) async {
    try {
      await Supabase.instance.client.from('posts').insert({
        'title': data.title,
        'issue': data.issue,
        'user_uuid': Supabase.instance.client.auth.currentUser!.id,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(Post data) async {
    try {
      await Supabase.instance.client.from('posts').update({
        'title': data.title,
        'issue': data.issue,
        'updated_at': DateTime.now().toIso8601String(),
        'user_uuid': Supabase.instance.client.auth.currentUser!.id,
      }).eq('id', data.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Post>> getMyPosts() async {
    return (await _baseGetQuery().eq('user_uuid', Supabase.instance.client.auth.currentUser!.id).order('created_at'))
        .map((e) => Post.fromMap(e))
        .toList();
  }
}
