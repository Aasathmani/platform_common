import 'package:hive/hive.dart';
import 'package:platform_common/src/data/database/base_hive_dao.dart';
import 'package:platform_common/src/utils/extensions.dart';

class SettingsDao extends BaseHiveDao {
  static const kUserSecurity = 'user_security';
  static const kInitialFetch = 'initial_fetch';

  Future<Box> getBox() async {
    return Hive.openBox("settings");
  }

  Future<void> setSecurityEnabled(bool value) async {
    final box = await getBox();
    box.put(kUserSecurity, value);
  }

  Future<bool> isSecurityEnabled() async {
    final box = await getBox();
    final value = await box.get(kUserSecurity);
    return toDefaultBool(value, defaultValue: true);
  }

  Future<void> setInitialFetchCompleted(bool value) async {
    final box = await getBox();
    box.put(kInitialFetch, value);
  }

  Future<bool> isInitialFetchCompleted() async {
    final box = await getBox();
    final value = await box.get(kInitialFetch);
    return toDefaultBool(value);
  }

  @override
  Future<void> clear() async {
    final box = await getBox();
    await box.clear();
  }
}
