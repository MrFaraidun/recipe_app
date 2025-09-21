import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/shopping_list_item.dart';
import '../widgets/add_item_dialog.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final List<ShoppingItem> _items = [
    ShoppingItem(name: '2 cups all-purpose flour', isCompleted: false),
    ShoppingItem(name: '1 cup sugar', isCompleted: true),
    ShoppingItem(name: '3 large eggs', isCompleted: false),
    ShoppingItem(name: '1/2 cup butter', isCompleted: false),
    ShoppingItem(name: '1 tsp vanilla extract', isCompleted: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Shopping List',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: _addItem,
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Section
          _buildStatsSection(),

          // Items List
          Expanded(
            child: _items.isEmpty ? _buildEmptyState() : _buildItemsList(),
          ),

          // Action Buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final completedCount = _items.where((item) => item.isCompleted).length;
    final totalCount = _items.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Total', totalCount.toString(), Icons.list),
              _buildStatItem(
                'Completed',
                completedCount.toString(),
                Icons.check_circle,
              ),
              _buildStatItem(
                'Remaining',
                (totalCount - completedCount).toString(),
                Icons.pending,
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.h2.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(label, style: AppTextStyles.bodySecondary.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildItemsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return ShoppingListItem(
          item: item.name,
          isCompleted: item.isCompleted,
          onToggle: () => _toggleItem(index),
          onDelete: () => _deleteItem(index),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            'No Items Yet',
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add items to your shopping list',
            style: AppTextStyles.bodySecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Add First Item',
            onPressed: _addItem,
            backgroundColor: AppColors.primary,
            textColor: Colors.white,
            height: 48,
            borderradius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Add from Recipe',
              onPressed: _addFromRecipe,
              backgroundColor: Colors.white,
              textColor: AppColors.primary,
              borderColor: AppColors.primary,
              height: 48,
              borderradius: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: 'Clear Completed',
              onPressed: _hasCompletedItems() ? _clearCompleted : null,
              backgroundColor: _hasCompletedItems() ? Colors.red : Colors.grey,
              textColor: Colors.white,
              height: 48,
              borderradius: 24,
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddItemDialog(),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _items.add(ShoppingItem(name: result, isCompleted: false));
      });
    }
  }

  void _addFromRecipe() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add from Recipe'),
        content: const Text('This feature will be available soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index].isCompleted = !_items[index].isCompleted;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _clearCompleted() {
    setState(() {
      _items.removeWhere((item) => item.isCompleted);
    });
  }

  bool _hasCompletedItems() {
    return _items.any((item) => item.isCompleted);
  }
}

class ShoppingItem {
  final String name;
  bool isCompleted;

  ShoppingItem({required this.name, required this.isCompleted});
}
