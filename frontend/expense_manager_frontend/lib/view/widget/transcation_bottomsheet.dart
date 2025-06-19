import 'package:flutter/material.dart';

class Transcationbottomsheet {
  static showTranscationbottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Corrected to get the bottom inset
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Makes the column as small as possible
              children: [
                // Date input
                _buildTextField("Date", context),

                // Amount input
                _buildTextField("Amount", context),

                // Category input
                _buildTextField("Category", context),

                // Description input
                _buildTextField("Description", context),

                const SizedBox(height: 50),

                // Submit button
                GestureDetector(
                  onTap: () {
                    // Handle the action when the button is tapped
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 55),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(14, 161, 125, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to build text fields
  static Widget _buildTextField(String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter $label',
                border: const OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
