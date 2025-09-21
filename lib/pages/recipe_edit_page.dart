import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/recipe_image_section.dart';
import '../widgets/ingredients_section.dart';
import '../widgets/steps_section.dart';
import '../models/recipe.dart';

class RecipeEditPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeEditPage({super.key, required this.recipe});

  @override
  State<RecipeEditPage> createState() => _RecipeEditPageState();
}

class _RecipeEditPageState extends State<RecipeEditPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _durationController;
  late TextEditingController _categoryController;

  List<String> _ingredients = [];
  List<String> _steps = [];
  String _selectedCategory = 'Food';
  String _selectedDuration = '30 mins';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _descriptionController = TextEditingController(
      text: widget.recipe.description ?? '',
    );
    _durationController = TextEditingController(text: widget.recipe.duration);
    _categoryController = TextEditingController(text: widget.recipe.category);
    _selectedCategory = widget.recipe.category;
    _selectedDuration = widget.recipe.duration;
    _ingredients = List.from(widget.recipe.ingredients ?? []);
    _steps = List.from(widget.recipe.steps ?? []);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Recipe',
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
          TextButton(
            onPressed: _saveRecipe,
            child: Text(
              'Save',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            RecipeImageSection(
              imageUrl: widget.recipe.imageUrl,
              onChangeImage: _changeImage,
            ),
            const SizedBox(height: 24),

            // Basic Information
            _buildBasicInfoSection(),
            const SizedBox(height: 24),

            // Ingredients Section
            IngredientsSection(
              ingredients: _ingredients,
              onAddIngredient: _addIngredient,
              onEditIngredient: _editIngredient,
              onRemoveIngredient: _removeIngredient,
            ),
            const SizedBox(height: 24),

            // Steps Section
            StepsSection(
              steps: _steps,
              onAddStep: _addStep,
              onEditStep: _editStep,
              onRemoveStep: _removeStep,
            ),
            const SizedBox(height: 32),

            // Action Buttons
            _buildActionButtons(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Basic Information',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),

          CustomTextField(
            label: 'Recipe Title',
            controller: _titleController,
            icon: Icons.restaurant_menu,
            borderColor: AppColors.border,
            focusedBorderColor: AppColors.primary,
            borderradius: 12,
          ),
          const SizedBox(height: 16),

          CustomTextField(
            label: 'Description',
            controller: _descriptionController,
            icon: Icons.description,
            maxLines: 3,
            borderColor: AppColors.border,
            focusedBorderColor: AppColors.primary,
            borderradius: 12,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildDropdownField(
                  label: 'Category',
                  value: _selectedCategory,
                  items: ['Food', 'Drink', 'Dessert', 'Appetizer'],
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value!),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdownField(
                  label: 'Duration',
                  value: _selectedDuration,
                  items: ['<10 mins', '10-30 mins', '30-60 mins', '>60 mins'],
                  onChanged: (value) =>
                      setState(() => _selectedDuration = value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Cancel',
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white,
            textColor: AppColors.textPrimary,
            borderColor: AppColors.border,
            height: 48,
            borderradius: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            text: 'Save Changes',
            onPressed: _saveRecipe,
            backgroundColor: AppColors.primary,
            textColor: Colors.white,
            height: 48,
            borderradius: 24,
          ),
        ),
      ],
    );
  }

  void _changeImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Recipe Image',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionButton(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    // Implement camera functionality
                  },
                ),
                _buildOptionButton(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    // Implement gallery functionality
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(height: 8),
            Text(label, style: AppTextStyles.body),
          ],
        ),
      ),
    );
  }

  void _addIngredient() {
    _showTextInputDialog(
      title: 'Add Ingredient',
      hint: 'Enter ingredient (e.g., 2 cups flour)',
      onSave: (text) {
        setState(() {
          _ingredients.add(text);
        });
      },
    );
  }

  void _editIngredient(int index) {
    _showTextInputDialog(
      title: 'Edit Ingredient',
      hint: 'Enter ingredient',
      initialValue: _ingredients[index],
      onSave: (text) {
        setState(() {
          _ingredients[index] = text;
        });
      },
    );
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _addStep() {
    _showTextInputDialog(
      title: 'Add Cooking Step',
      hint: 'Enter cooking step',
      onSave: (text) {
        setState(() {
          _steps.add(text);
        });
      },
    );
  }

  void _editStep(int index) {
    _showTextInputDialog(
      title: 'Edit Cooking Step',
      hint: 'Enter cooking step',
      initialValue: _steps[index],
      onSave: (text) {
        setState(() {
          _steps[index] = text;
        });
      },
    );
  }

  void _removeStep(int index) {
    setState(() {
      _steps.removeAt(index);
    });
  }

  void _showTextInputDialog({
    required String title,
    required String hint,
    String? initialValue,
    required Function(String) onSave,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSave(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveRecipe() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe updated successfully!')),
    );
    Navigator.pop(context);
  }
}
