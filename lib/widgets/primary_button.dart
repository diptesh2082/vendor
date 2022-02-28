import 'package:flutter/material.dart';

buildPrimaryButton(callBack, String title,
        {Color? color, bool? isWatchNow = false}) =>
    TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? Colors.green,
        ),
      ),
      onPressed: callBack,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3,
        ),
        child: isWatchNow!
            ? Row(
                children: [
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
      ),
    );
