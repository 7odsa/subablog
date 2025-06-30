import 'dart:io';

import 'package:subablog/core/error/exeptions.dart';
import 'package:subablog/features/blog/data/models/blog_dm.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDs {
  Future<BlogDm> uploadBlog(BlogDm blog);
  Future<String> _uploadImage(File image, BlogDm blog);
}

class BlogRemoteDsImpl implements BlogRemoteDs {
  final SupabaseClient supabaseClient;

  BlogRemoteDsImpl({required this.supabaseClient});
  @override
  Future<BlogDm> uploadBlog(BlogDm blog) async {
    try {
      // final blogImgId;
      final response = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();

      return BlogDm.fromJson(response.first);
    } catch (e) {
      throw ServerExeption(e.toString());
    }
  }

  @override
  Future<String> _uploadImage(File image, BlogDm blog) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerExeption(e.toString());
    }
  }
}
