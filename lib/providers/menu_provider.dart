import 'dart:async';
import 'package:flutter/material.dart';
import '../models/dish.dart';
import '../services/firebase_service.dart';

class MenuProvider with ChangeNotifier {
  final FirebaseService _firebaseService;
  
  List<Dish> _dishes = [];
  bool _isShopOpen = true;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  bool _isLoading = false;

  StreamSubscription<List<Dish>>? _dishesSubscription;
  StreamSubscription<bool>? _shopStatusSubscription;

  MenuProvider(this._firebaseService) {
    // Set initial values
    _dishes = _firebaseService.currentDishes;
    _isShopOpen = _firebaseService.isShopOpen;

    // Listen to Firebase Streams for instant real-time synchronization
    _dishesSubscription = _firebaseService.dishesStream.listen((updatedDishes) {
      _dishes = updatedDishes;
      notifyListeners();
    });

    _shopStatusSubscription = _firebaseService.shopStatusStream.listen((status) {
      _isShopOpen = status;
      notifyListeners();
    });
  }

  // Getters
  bool get isShopOpen => _isShopOpen;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  // Get raw list of all dishes (used by Admin Dashboard and specials)
  List<Dish> get allDishes => _dishes;

  // Get filtered menu list based on search query and category (used by Customer Menu)
  List<Dish> get dishes {
    return _dishes.where((dish) {
      // 1. Filter by category
      final matchesCategory = _selectedCategory == 'All' || 
          dish.category.toLowerCase() == _selectedCategory.toLowerCase();

      // 2. Filter by search query (name or description)
      final matchesSearch = dish.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          dish.description.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // --- UI Filter Actions ---

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // --- Firebase Actions Wrapper ---

  Future<void> toggleShopStatus() async {
    _setLoading(true);
    try {
      await _firebaseService.toggleShopStatus();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addDish(Dish dish) async {
    _setLoading(true);
    try {
      await _firebaseService.addDish(dish);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateDish(Dish dish) async {
    _setLoading(true);
    try {
      await _firebaseService.updateDish(dish);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteDish(String id) async {
    _setLoading(true);
    try {
      await _firebaseService.deleteDish(id);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _dishesSubscription?.cancel();
    _shopStatusSubscription?.cancel();
    super.dispose();
  }
}
