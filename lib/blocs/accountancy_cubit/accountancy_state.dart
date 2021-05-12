part of 'accountancy_cubit.dart';

abstract class AccountancyState extends Equatable {
  const AccountancyState();

  @override
  List<Object> get props => [];
}

class AccountancyInitial extends AccountancyState {}

@immutable
class AccountancySucces extends AccountancyState {
  final String income; // Поступления
  final String outcome; // Расходы
  final String cash; // Касса
  final String debt; // Задолженность
  final String balance; // Баланс

  const AccountancySucces(
      {this.income = '0',
      this.outcome = '0',
      this.cash = '0',
      this.debt = '0',
      this.balance = '0'});

  @override
  List<Object> get props => [income, outcome, cash, debt, balance];

  // TODO: удалить потом
  // AccountancySucces copyWith(
  //     {String? income,
  //     String? outcome,
  //     String? cash,
  //     String? debt,
  //     String? balance}) {
  //   return AccountancySucces(
  //       income: income ?? this.income,
  //       outcome: outcome ?? this.outcome,
  //       cash: cash ?? this.cash,
  //       debt: debt ?? this.debt,
  //       balance: balance ?? this.balance);
  // }
}
