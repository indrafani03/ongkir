
import 'package:http/http.dart' as http;

void main() async {
    var url = Uri.parse("https://api.rajaongkir.com/starter/cost");
     var response = await http.post(url, headers: {
       "key" : "4ad06fd00bc022c31a25f3fdebcb037c",
       "content-type" : "application/x-www-form-urlencoded",
     }, body:  {
       "origin" : "501",
       "destination" : "114",
       "weight" : "2323",
       "courier" : "jne",
     });
     print(response.body);
} 