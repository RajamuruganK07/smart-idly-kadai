import 'dart:async';
import '../models/dish.dart';

class FirebaseService {
  // Initial Mock Data
  final List<Dish> _dishes = [
    Dish(
      id: '1',
      name: 'Hot Idly (2 Pcs)',
      price: 20.0,
      description: 'Soft, fluffy steamed rice and lentil cakes served piping hot.',
      includes: ['Sambar', 'Coconut Chutney', 'Kara Chutney'],
      isAvailable: true,
      category: 'Breakfast',
    ),
    Dish(
      id: '2',
      name: 'Ghee Podi Roast Dosa',
      price: 70.0,
      description: 'Crispy, golden-brown rice crepe drizzled with pure ghee and sprinkled with spicy gun powder (podi).',
      includes: ['Sambar', 'Coconut Chutney', 'Tomato Chutney'],
      isAvailable: true,
      category: 'Breakfast',
    ),
    Dish(
      id: '3',
      name: 'Medu Vada (1 Pc)',
      price: 15.0,
      description: 'Crispy fried black lentil donut with onion, green chillies, and ginger.',
      includes: ['Sambar', 'Coconut Chutney'],
      isAvailable: true,
      category: 'Breakfast',
    ),
    Dish(
      id: '4',
      name: 'Special Meals (Lunch)',
      price: 100.0,
      description: 'Traditional lunch platter with Rice, Sambar, Rasam, Kara Kuzhambu, Poriyal, Kootu, Appalam, and Curd.',
      includes: ['Appalam', 'Pickle', 'Sweet Payasam'],
      isAvailable: false, // Starts as unavailable if it is morning, or we can make it available
      category: 'Lunch',
    ),
    Dish(
      id: '5',
      name: 'Chola Poori (2 Pcs)',
      price: 80.0,
      description: 'Fluffy, large fried wheat flatbread served with spiced chickpea masala (chole).',
      includes: ['Chole Masala', 'Onion Salad'],
      isAvailable: true,
      category: 'Breakfast',
    ),
    Dish(
      id: '6',
      name: 'Kothu Parotta (Veg)',
      price: 90.0,
      description: 'Flaky shredded parotta stir-fried with rich spices, onion, tomato, and vegetables.',
      includes: ['Onion Raitha', 'Veg Salna'],
      isAvailable: true,
      category: 'Dinner',
    ),
  ];

  bool _isShopOpen = true;

  // StreamControllers to broadcast changes to anyone listening
  final StreamController<List<Dish>> _dishesController = StreamController<List<Dish>>.broadcast();
  final StreamController<bool> _shopStatusController = StreamController<bool>.broadcast();

  // Constructor
  FirebaseService() {
    // Emit initial values after a brief setup delay
    Timer(const Duration(milliseconds: 100), () {
      _emitDishes();
      _emitShopStatus();
    });
  }

  // Get current state synchronously
  List<Dish> get currentDishes => List.unmodifiable(_dishes);
  bool get isShopOpen => _isShopOpen;

  // Streams
  Stream<List<Dish>> get dishesStream => _dishesController.stream;
  Stream<bool> get shopStatusStream => _shopStatusController.stream;

  // Private helpers to publish updates
  void _emitDishes() {
    if (!_dishesController.isClosed) {
      _dishesController.add(List.from(_dishes));
    }
  }

  void _emitShopStatus() {
    if (!_shopStatusController.isClosed) {
      _shopStatusController.add(_isShopOpen);
    }
  }

  // --- Realtime Simulated Firebase Write Operations ---

  // Add Dish
  Future<void> addDish(Dish dish) async {
    await Future.delayed(const Duration(milliseconds: 400)); // Simulate network lag
    _dishes.add(dish);
    _emitDishes();
  }

  // Update Dish
  Future<void> updateDish(Dish updatedDish) async {
    await Future.delayed(const Duration(milliseconds: 400)); // Simulate network lag
    final index = _dishes.indexWhere((d) => d.id == updatedDish.id);
    if (index != -1) {
      _dishes[index] = updatedDish;
      _emitDishes();
    }
  }

  // Delete Dish
  Future<void> deleteDish(String id) async {
    await Future.delayed(const Duration(milliseconds: 400)); // Simulate network lag
    _dishes.removeWhere((d) => d.id == id);
    _emitDishes();
  }

  // Toggle Shop Status
  Future<void> toggleShopStatus() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network lag
    _isShopOpen = !_isShopOpen;
    _emitShopStatus();
  }

  // Clean up streams
  void dispose() {
    _dishesController.close();
    _shopStatusController.close();
  }
}
