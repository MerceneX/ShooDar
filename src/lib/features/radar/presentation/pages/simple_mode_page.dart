import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoodar/features/radar/presentation/bloc/bloc.dart';

import '../widgets/message_display.dart';
import '../../../../injection_container.dart';

class SimpleModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<RadarBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RadarBloc>(),
      child: Center(child: Text("Hi2")),
    );
  }
}
