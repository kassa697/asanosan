import 'package:car_go_bridge/screens/commission_list_dk.dart';
import 'package:flutter/material.dart';

Future<Object?> myDialog(BuildContext context, String message, VoidCallback onPressed) 
  async{
    return await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: '',
      transitionDuration:
          const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) =>
          const SizedBox(),
      transitionBuilder: (ctx, anim1, anim2, child) =>
          Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Dialog(
              backgroundColor: Colors.white,
              child: Container(
                width: 80,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  