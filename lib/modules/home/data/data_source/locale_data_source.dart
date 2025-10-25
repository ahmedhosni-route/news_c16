import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocaleDataSource {
  Future<BoxCollection> initHive() async {
    try{
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      print(appDocumentsDir.path);
      final collection = await BoxCollection.open(
        'News', // Name of your database
        {'sources', 'articles'}, // Names of your boxes
        path: appDocumentsDir
            .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
      );
      return collection;
    }catch(e){
      print(e);
      rethrow;
    }

  }

  Future<void> setNews(Map<String, dynamic> data) async {
    var ref = await initHive();
    var collection = await ref.openBox("articles");
    await collection.put("articles", data);
    ref.close();
  }

  Future<Map<dynamic, dynamic>?> getNews()async{
     var ref = await initHive();
     var collection = await ref.openBox<Map<dynamic , dynamic>>("articles");
     var data = await collection.get("articles");
     ref.close();
     return data;
   }

   Future<void> setSources(Map<String, dynamic> data) async{
     var ref = await initHive();
     var collection = await ref.openBox<Map<String , dynamic>>("sources");
     await collection.put("sources", data);
     ref.close();
   }
  Future<Map<dynamic, dynamic>?> getSources()async{
    var ref = await initHive();
    var collection = await ref.openBox<Map<dynamic , dynamic>>("sources");
    var data = await collection.get("sources");
    ref.close();
    return data;
  }

}
