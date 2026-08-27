import 'package:circuitpedia/screens/widgets/transformer_widget.dart';
import 'package:flutter/material.dart';

class TransformerScreen extends StatelessWidget {
  const TransformerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransformerWidget transformerWidget = TransformerWidget(context, TextStyle(fontSize: 22));
    return Scaffold(
      appBar: AppBar(title: Text("Transformer"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView(
            children: [
              transformerWidget.upsScreen(),
              transformerWidget.manualyScreen(),
              transformerWidget.transformerInfoScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
