import 'dart:developer';
import 'dart:io';

import 'package:expense_manager_frontend/controller/category_controller.dart';
import 'package:expense_manager_frontend/user_session.dart';
import 'package:expense_manager_frontend/utils/image_picker.dart';
import 'package:flutter/material.dart';

class CategoryBottomSheet {
  static showCategoryBottomSheet(BuildContext context) {
    File? _image;

    TextEditingController categoryNameController = new TextEditingController();

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 24,
              right: 24,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'Add New Category',
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create a custom category for your expenses',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),

                // Category Icon Picker
                GestureDetector(
                  onTap: () async {
                    _image = await MyImagePicker().pickImageFromGallery();
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(14, 161, 125, 1)
                                .withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor:
                            const Color(0xFF6366F1).withOpacity(0.1),
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? const Icon(
                                Icons.category_outlined,
                                size: 40,
                                color: Color.fromRGBO(14, 161, 125, 1),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Tap to choose icon',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Category Name Field
                const Text(
                  'Category Name',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E293B).withOpacity(0.08),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: categoryNameController,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter category name',
                      hintStyle: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(
                        Icons.label_outline,
                        color: Color.fromRGBO(14, 161, 125, 1),
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Add Button
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final token = UserSession.user?.getAccessToken();
                      log("access token at bottom sheet : ${token}");

                      if (categoryNameController.text.trim().isNotEmpty &&
                          _image != null) {
                        await CategoryController().addCategory(
                          _image?.path,
                          categoryNameController.text.trim(),
                        );

                        Navigator.of(context).pop(); // 👈 Close bottom sheet

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Category added successfully"),
                            backgroundColor: Color(0xFF10B981),
                            behavior: SnackBarBehavior.fixed,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill fields"),
                            backgroundColor: Color(0xFF10B981),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(14, 161, 125, 1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Add Category",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
