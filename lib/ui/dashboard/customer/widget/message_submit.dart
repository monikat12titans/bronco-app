import 'package:flutter/material.dart';

class MessageSubmit extends StatelessWidget {
  const MessageSubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Icon(
        Icons.send,
        size: 15,
        color: Colors.white,
      ),
    );
  }
}

class MessageLoading extends StatelessWidget {
  const MessageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const CircularProgressIndicator(),
    );
  }
}
