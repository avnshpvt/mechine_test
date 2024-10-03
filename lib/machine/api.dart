import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';  

Future<List<Post>> fetchPost() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((post) => Post.fromJson(post)).toList();  
  } else {
    throw Exception('Failed to load posts');
  }
}
