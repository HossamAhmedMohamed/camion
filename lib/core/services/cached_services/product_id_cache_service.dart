// Product Cache Service
import 'package:camion/features/home/data/models/all_products_model/all_products_model.dart';


class ProductCacheService {
  static final ProductCacheService _instance = ProductCacheService._internal();
  factory ProductCacheService() => _instance;
  ProductCacheService._internal();

  final Map<String, AllProductModel> _cache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  final Duration _cacheExpiry = const Duration(minutes: 30);

  AllProductModel? getCachedProduct(String id) {
    final timestamp = _cacheTimestamps[id];
    if (timestamp != null && 
        DateTime.now().difference(timestamp) > _cacheExpiry) {
     
      _cache.remove(id);
      _cacheTimestamps.remove(id);
      return null;
    }
    return _cache[id];
  }

  void cacheProduct(String id, AllProductModel product) {
    _cache[id] = product;
    _cacheTimestamps[id] = DateTime.now();
  }

  bool isProductCached(String id) {
    return getCachedProduct(id) != null;
  }

  void clearCache() {
    _cache.clear();
    _cacheTimestamps.clear();
  }
}