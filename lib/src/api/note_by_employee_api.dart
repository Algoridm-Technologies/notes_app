import 'package:http/http.dart' as http;
import 'package:note/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteByEmployeeApi {
  static Future<String> noteByEmployee({
    required String employeeId,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var session = prefs.getString("session");
      dynamic url = Uri.parse("$baseUrl/notes/employee-notes/$employeeId/");
      var response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "cookie": "$session",
      });
      return response.body;
    } catch (e) {
      return 'Error';
    }
  }
}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye5@gmail.com","password":"1U7ThJyyQsic","facility":"fac"}}
// 5
// flutter: {"email":["Email already registered"]}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye51@gmail.com","password":"BOJr1USYoBtr","facility":"fac"}}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye52@gmail.com","password":"X8ssCz5bgHbR","facility":"fac_1"}}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye53@gmail.com","password":"AUjLLCnKukQT","facility":"fac_14"}}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye54@gmail.com","password":"HK8KrVdQSvLU","facility":"Facility_92"}}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye55@gmail.com","password":"9rA1chEIMj3l","facility":"hello"}}
// flutter: {"success":"Staff Created Successfully","data":{"full_name":"ab cd","email":"ofiicialrrye56@gmail.com","password":"l4r65S2QyBEI","facility":"hello 3"}}