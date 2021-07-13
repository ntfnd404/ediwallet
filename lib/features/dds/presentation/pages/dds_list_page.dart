import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../bloc/dds_cubit.dart';
import '../widgets/dds_list.dart';

class DDSListPage extends StatelessWidget {
  const DDSListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ДДС')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider<DDSCubit>(
              lazy: true,
              create: (context) => sl<DDSCubit>()..getDDSItems(),
              child: const DDSList()),
        ),
      ),
    );
  }
}
