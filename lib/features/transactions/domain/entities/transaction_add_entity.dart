import 'package:equatable/equatable.dart';

class TransactionAdd extends Equatable {
  final String departmentId;
  final String sourceId; //DDS
  final int sum;
  final String type;
  final String user;
  final String analytics;
  final String mathSymbol;

  const TransactionAdd({
    required this.departmentId,
    required this.sum,
    required this.sourceId,
    required this.type,
    required this.user,
    required this.analytics,
    required this.mathSymbol,
  });

  @override
  List<Object?> get props =>
      [departmentId, sum, sourceId, type, user, analytics, mathSymbol];
}

		// Движение.Период = Дата;
		// Движение.ДДС = ТекСтрока.ДДС;
		// Движение.Аналитика = ТекСтрока.Аналитика;
		// Движение.Аналитика2 = ТекСтрока.Аналитика2;
		// Движение.ДатаДвижения = Дата;
		// Движение.ФормаОплаты = ТипОплаты;
		// Движение.Автор = Автор;
		// Движение.Сумма = ТекСтрока.Сумма;
		// Если ТекСтрока.ДДС.Движение = 1 Тогда
		// 	Приход = Приход + ТекСтрока.Сумма;
		// 	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		// Иначе
		// 	Расход = Расход + ТекСтрока.Сумма;
		// 	Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		// КонецЕсли;
