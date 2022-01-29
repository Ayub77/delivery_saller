// ignore_for_file: prefer_collection_literals, unnecessary_new

class Params{
   static Map<String, String> empty(){
    Map<String, String> params = new Map();
    
    return params;
  } 
  static Map<String, String> loginparams(String login,String parol){
    Map<String, String> params = new Map();
    params.addAll({
      "username":login,
      "password":parol
    });

    
    return params;
  }

  static Map<String, String> productparams(String page,String search,String categoryId){
    Map<String, String> params = new Map();
    params.addAll({
      "page":page,
      "search":search,
      "category_id":categoryId
    });

    
    return params;
  }

  static Map<String, String> sendProductParams(String title,String categoryId,String unitId,String price,String quantity){
    Map<String, String> params = new Map();
    params.addAll({
      "title":title,
      "category_id":unitId,
      "unit_id":categoryId,
      "price":price,
      "quantity":quantity,
    });

    
    return params;
  }
   
}