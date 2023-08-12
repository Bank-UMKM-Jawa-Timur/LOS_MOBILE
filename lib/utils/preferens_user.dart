import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferensUser extends GetxController {
  var isLoading = false.obs;
  var kodeCabang, name, email, role, bagian, jabatan;

  @override
  Future<void> onInit() async {
    super.onInit();
    pref();
  }

  pref() async {
    isLoading(true);
    SharedPreferences sprefs = await SharedPreferences.getInstance();
    kodeCabang = sprefs.getString("kode_cabang");
    name = sprefs.getString("name");
    email = sprefs.getString("email");
    role = sprefs.getString("role");
    bagian = sprefs.getString("bagian");
    jabatan = sprefs.getString("jabatan");
    isLoading(false);
  }
}
