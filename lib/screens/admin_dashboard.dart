import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu_provider.dart';
import '../models/dish.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final allDishes = menuProvider.allDishes;
    final isShopOpen = menuProvider.isShopOpen;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Control Panel ⚙️'),
        actions: [
          if (menuProvider.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD35400)),
                  ),
                ),
              ),
            )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop Control Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isShopOpen
                        ? [const Color(0xFF1E8449), const Color(0xFF27AE60)]
                        : [const Color(0xFF7B241C), const Color(0xFFC0392B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SwitchListTile(
                  title: const Text(
                    'Live Shop Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    isShopOpen
                        ? 'Customers see you as OPEN. Receiving orders!'
                        : 'Customers see you as CLOSED. Shop offline.',
                    style: const TextStyle(color: Colors.white
                    , fontSize: 12),
                  ),
                  value: isShopOpen,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF2ECC71).withOpacity(0.5),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.black26,
                  onChanged: (value) {
                    menuProvider.toggleShopStatus();
                  },
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                'Manage Menu Items',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ),

            // Dishes list
            if (allDishes.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Icon(Icons.restaurant_menu, size: 60, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No dishes in the menu yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allDishes.length,
                padding: const EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) {
                  final dish = allDishes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              dish.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            '₹${dish.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Color(0xFFD35400),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F4F4),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  dish.category,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7F8C8D),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                dish.isAvailable ? 'Live on menu' : 'Hidden / Sold out',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: dish.isAvailable
                                      ? const Color(0xFF27AE60)
                                      : const Color(0xFFC0392B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            dish.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFFDF2E9),
                        foregroundColor: const Color(0xFFD35400),
                        child: Text('${index + 1}'),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Live Switch for Availability
                          Switch(
                            value: dish.isAvailable,
                            activeColor: const Color(0xFF27AE60),
                            onChanged: (val) {
                              menuProvider.updateDish(
                                dish.copyWith(isAvailable: val),
                              );
                            },
                          ),
                          // Edit Button
                          IconButton(
                            icon: const Icon(Icons.edit, color: Color(0xFF3498DB)),
                            onPressed: () {
                              _showAddEditDishDialog(context, menuProvider, dish: dish);
                            },
                          ),
                          // Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Color(0xFFE74C3C)),
                            onPressed: () {
                              _showDeleteConfirmation(context, menuProvider, dish);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddEditDishDialog(context, menuProvider);
        },
        backgroundColor: const Color(0xFFD35400),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add New Dish'),
      ),
    );
  }

  // Add/Edit Dialog
  void _showAddEditDishDialog(BuildContext context, MenuProvider provider, {Dish? dish}) {
    final isEditing = dish != null;
    final formKey = GlobalKey<FormState>();

    // Controllers
    final nameController = TextEditingController(text: dish?.name ?? '');
    final priceController = TextEditingController(text: dish?.price.toStringAsFixed(0) ?? '');
    final descController = TextEditingController(text: dish?.description ?? '');
    final includesController = TextEditingController(text: dish?.includes.join(', ') ?? '');
    String selectedCategory = dish?.category ?? 'Breakfast';
    bool isAvailable = dish?.isAvailable ?? true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(
                isEditing ? 'Edit Dish details' : 'Add New Dish',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: 340,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Name
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Dish Name',
                            hintText: 'e.g. Rava Idly (2 Pcs)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.restaurant),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Price
                        TextFormField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            labelText: 'Price (₹)',
                            hintText: 'e.g. 45',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.currency_rupee),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a price';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Description
                        TextFormField(
                          controller: descController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'e.g. Delicious rava steamed cakes made with curd and spices.',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a description';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),

                        // Includes / Accompaniments
                        TextFormField(
                          controller: includesController,
                          decoration: const InputDecoration(
                            labelText: 'Side Dishes (comma separated)',
                            hintText: 'e.g. Sambar, Pudina Chutney',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.eco),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Category Dropdown
                        DropdownButtonFormField<String>(
                          value: selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: const [
                            DropdownMenuItem(value: 'Breakfast', child: Text('Breakfast')),
                            DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                            DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setStateDialog(() {
                                selectedCategory = val;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 12),

                        // Available Toggle
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Available Instantly', style: TextStyle(fontWeight: FontWeight.w600)),
                          value: isAvailable,
                          onChanged: (val) {
                            setStateDialog(() {
                              isAvailable = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // Parse side dishes
                      final List<String> includes = includesController.text
                          .split(',')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList();

                      final newDish = Dish(
                        id: isEditing ? dish.id : DateTime.now().millisecondsSinceEpoch.toString(),
                        name: nameController.text.trim(),
                        price: double.parse(priceController.text.trim()),
                        description: descController.text.trim(),
                        includes: includes,
                        isAvailable: isAvailable,
                        category: selectedCategory,
                      );

                      if (isEditing) {
                        await provider.updateDish(newDish);
                      } else {
                        await provider.addDish(newDish);
                      }

                      if (context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isEditing
                                  ? '${newDish.name} updated successfully!'
                                  : '${newDish.name} added to live menu!',
                            ),
                            backgroundColor: const Color(0xFF27AE60),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD35400),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(isEditing ? 'Save Changes' : 'Add Dish'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Delete Confirmation Dialog
  void _showDeleteConfirmation(BuildContext context, MenuProvider provider, Dish dish) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Menu Item?'),
          content: Text('Are you sure you want to delete ${dish.name} from the database? This action is permanent.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                await provider.deleteDish(dish.id);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${dish.name} removed from database.'),
                      backgroundColor: const Color(0xFFC0392B),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC0392B),
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// Helper styling extension to avoid syntax issues in colors
extension TextStyleExtension on TextStyle {
  static const Color whiteBF = Color(0xFFE5E7E9);
}
