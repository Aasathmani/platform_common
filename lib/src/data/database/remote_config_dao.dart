import 'package:hive/hive.dart';
import 'package:platform_common/src/data/database/base_hive_dao.dart';
import 'package:platform_common/src/utils/extensions.dart';

/// Created by Jemsheer K D on 25 September, 2023.
/// File Name : remote_config_dao
/// Project : Maridock

class RemoteConfigDao extends BaseHiveDao {
  static const kRemoteConfig = 'remote_config';

  Future<Box> getBox() async {
    return Hive.openBox("remote_config");
  }

  Future<void> saveRemoteConfig(Map<String, dynamic> value) async {
    final box = await getBox();
    box.put(kRemoteConfig, value);
  }

  Future<Map<String, dynamic>> getRemoteConfig() async {
    final box = await getBox();
    final value = await box.get(kRemoteConfig);
    return toGenericMap(value);
  }

  @override
  Future<void> clear() async {
    final box = await getBox();
    await box.clear();
  }
}
