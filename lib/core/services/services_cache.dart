import 'package:hive_flutter/hive_flutter.dart';

import '../constants/keys.dart';

/// Abstract interface for cache service implementations.
/// This service provides a standardized way to handle caching operations
/// across the application, allowing for different cache implementations
/// to be swapped in and out without affecting the rest of the codebase.
abstract class CacheServiceInterface {
  /// Initializes the cache service.
  /// This method should be called before any other cache operations.
  /// It sets up any necessary resources or connections required by
  /// the specific cache implementation.
  Future<void> init();

  /// Stores data in the cache.
  ///
  /// Parameters:
  /// - [box]: The name of the cache container/box where the data will be stored
  /// - [key]: The unique identifier for the data within the box
  /// - [value]: The actual data to be cached
  ///
  /// The implementation should handle serialization of the data if necessary.
  Future<void> put(String box, String key, dynamic value);

  /// Retrieves data from the cache.
  ///
  /// Parameters:
  /// - [box]: The name of the cache container/box where the data is stored
  /// - [key]: The unique identifier for the data within the box
  ///
  /// Returns:
  /// - The cached data if found, or null if not found
  /// The implementation should handle deserialization of the data if necessary.
  dynamic get(String box, String key);

  /// Checks if a specific cache box is currently open and available.
  ///
  /// Parameters:
  /// - [box]: The name of the cache container/box to check
  ///
  /// Returns:
  /// - true if the box is open and available
  /// - false otherwise
  bool isBoxOpen(String box);

  /// Opens a specific cache box for use.
  /// This method should be called before attempting to read from
  /// or write to a specific box.
  ///
  /// Parameters:
  /// - [box]: The name of the cache container/box to open
  Future<void> openBox(String box);

  /// Clears all cached data.
  /// This operation should remove all cached data from all boxes,
  /// effectively resetting the cache to its initial state.
  Future<void> clear();
}

/// Hive implementation of the CacheServiceAbstract interface.
/// This implementation uses Hive as the underlying storage mechanism
/// for caching data. Hive is a lightweight and fast key-value database
/// written in pure Dart.
class CacheService implements CacheServiceInterface {
  /// Factory constructor that returns the singleton instance
  factory CacheService() => _instance;

  /// Private constructor for singleton pattern
  CacheService._();

  /// Singleton instance
  static final CacheService _instance = CacheService._();

  static List<String> boxes = [
    Keys.tasks,
    Keys.countries,
  ];

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    // Initialize each box if not already open
    for (final box in boxes) {
      if (!isBoxOpen(box)) {
        await openBox(box);
      }
    }
  }

  @override
  Future<void> put(String box, String key, dynamic value) async {
    final hiveBox = Hive.box(box);
    await hiveBox.put(key, value);
  }

  @override
  dynamic get(String box, String key) {
    final hiveBox = Hive.box(box);
    return hiveBox.get(key);
  }

  @override
  bool isBoxOpen(String box) {
    return Hive.isBoxOpen(box);
  }

  @override
  Future<void> openBox(String box) async {
    await Hive.openBox(box);
  }

  @override
  Future<void> clear() async {
    // Clear each open box
    for (final box in boxes) {
      if (isBoxOpen(box)) {
        final hiveBox = Hive.box(box);
        await hiveBox.clear();
      }
    }
  }
}
