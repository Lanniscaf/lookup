import 'package:flutter/material.dart';

const Orange = TextStyle(
  color: Colors.amber,
  fontWeight: FontWeight.bold,
  fontSize: 19,
  letterSpacing: 9.0
);

const _counter = TextStyle(
  color: Colors.amber,
  fontWeight: FontWeight.bold,
);


const InputDecoration INPUTSEARCH = InputDecoration(
  fillColor: Colors.white54,
  filled: false,
  hintText: '506...',
  hintStyle: Orange,
  counterStyle: _counter,
  border: InputBorder.none,
);