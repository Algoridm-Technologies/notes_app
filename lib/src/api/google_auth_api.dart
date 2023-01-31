import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';

class GoogleAuthApi {
  Future<String> googleAuthApi() async {
    try {
      dynamic url = Uri.parse("$baseUrl/auth/google/");
      var response = await http.post(url, body: {
        'auth_token':
            '''eyJhbGciOiJSUzI1NiIsImtpZCI6IjI3NDA1MmEyYjY0NDg3NDU3NjRlNzJjMzU5MDk3MWQ5MGNmYjU4NWEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJuYmYiOjE2NzUxMTEwNjMsImF1ZCI6IjE4ODU4NzY4NzcwMC1qMGpsZDEzMzY3aDJzYnJ2ZmxxdjNobmQ2aWFtYXVqcy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsInN1YiI6IjEwNjcyODY0NDc4NTczNDYzOTQ4NyIsImVtYWlsIjoia2F5cHJvZ3JhbW1lcjFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF6cCI6IjE4ODU4NzY4NzcwMC1qMGpsZDEzMzY3aDJzYnJ2ZmxxdjNobmQ2aWFtYXVqcy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsIm5hbWUiOiJLYXkgUHJvZ3JhbW1lciIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BRWRGVHA0ZlU0TG15NkFrbGpIMktEcnpjTnI4a0l1QV9ibjEyTjlQYVlhSz1zOTYtYyIsImdpdmVuX25hbWUiOiJLYXkiLCJmYW1pbHlfbmFtZSI6IlByb2dyYW1tZXIiLCJpYXQiOjE2NzUxMTEzNjMsImV4cCI6MTY3NTExNDk2MywianRpIjoiMjRjZjA5MjVhYjljMzcxNWE1OGJlMzdlNDBmYTJhZGI4ZmE0NDZjYiJ9.Ny7UAibrfckViKVjNThSMj3mN2e5FYBXjPW5XZ6d1MEPuPCcB-2k2NikdpNh64-Vd5mu5qGO-8inpcV6GHjG1TDLWpX_deYGqdVY1LFHjSatVD6j1erum-n0PiIvWTnSBaNv1ocakTUGxAYdJqiwYR-l__V9fIIPBQL4MEULmUq8fw1TfYhyf-Izpvpcf22eODap7EgQGnyXu-uEMiyA9q5qqF84XITuNwFnVDdRWlYbDuipeK8t0f-wPlb1fJCXW6ZTb-RyqJGvVcu_YPLEEi1FpujqwCfGXZnbBjMSPnuNqKb2pWSGDd0O1R9w3XPS4Gum0h-y71apPtmh9ksZAA''',
      });

      if (response.statusCode == 200) {
        return 'Success';
      } else {
        return 'Failed';
      }
    } catch (e) {
      return 'Error';
    }
  }
}
