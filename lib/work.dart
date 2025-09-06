import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  const projectRef = 'xgrmklchcfcyntkqxrua';
  const apiKey    = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhncm1rbGNoY2ZjeW50a3F4cnVhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQyMTIwMDAsImV4cCI6MjA2OTc4ODAwMH0.YiqednjmJa92U0YHFeRngTYsF1Ka5lZvbprXfn-wtY8';

  final url = Uri.parse('https://$projectRef.supabase.co/rest/v1/users?limit=1');
  final resp = await http.get(
    url,
    headers: {
      'apikey'      : apiKey,
      'Authorization': 'Bearer $apiKey',
      'Content-Type' : 'application/json',
    },
  );

  print('Status: ${resp.statusCode}');
  print('Body: ${resp.body}');
}