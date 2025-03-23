import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  final String apiKey = 'AIzaSyDb-AuPTu5k1v1Rdyl_oDsJZiytjFCxQFk';
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': message},
              ],
            },
          ],
        }),
      );

      print(
        'API Response: ${response.statusCode} - ${response.body}',
      ); // Log the response

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        throw Exception('Failed to load response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e'); // Log any exceptions
      throw Exception('Failed to send message: $e');
    }
  }
}
