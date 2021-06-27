import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../bloc/departments_cubit.dart';
import '../widgets/departments_list.dart';

class DepartmentsListPage extends StatelessWidget {
  const DepartmentsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Departments')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider<DepartmentsCubit>(
              lazy: true,
              create: (context) => sl<DepartmentsCubit>()..getDepartments(),
              child: const DepartmentsList()),
        ),
      ),
    );
  }
}
