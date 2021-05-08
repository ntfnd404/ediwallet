import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:ediwallet/screens/transaction_home_page/bloc/scroll_event.dart';
import 'package:ediwallet/screens/dds/bloc/dds_bloc.dart';
import 'package:ediwallet/screens/dds/widgets/dds_list.dart';

class DDSListPage extends StatelessWidget {
  const DDSListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
              create: (_) =>
                  DDSBloc(httpClient: http.Client())..add(ScrollEvent()),
              child: const DDSList()),
        ),
      ),
    );
  }
}
