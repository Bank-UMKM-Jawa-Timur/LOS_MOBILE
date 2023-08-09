import 'package:flutter/material.dart';

Widget logoSplash = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: 170,
      height: 170,
      decoration: const BoxDecoration(
        // color: Colors.amber
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.contain,
        ),
      ),
    ),
    const SizedBox(height: 8),
    const Text(
      "BANK BPR JATIM\nBANK UMKM JAWA TIMUR",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
  ],
);

Widget logoLogin = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        // color: Colors.amber
        image: DecorationImage(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.contain,
        ),
      ),
    ),
    const SizedBox(height: 8),
    const Text(
      "BANK BPR JATIM\nBANK UMKM JAWA TIMUR",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    ),
  ],
);
