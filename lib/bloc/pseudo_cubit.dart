import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/pseudo.dart';

class PseudoCubit extends Cubit<List<Pseudo>> {
  PseudoCubit() : super([]);

  Future<void> loadPseudos() async {
    emit([
      Pseudo(0, 'pseudo1'),
      Pseudo(1, 'pseudo2'),
      Pseudo(2, 'pseudo3'),
    ]);
  }

  void addPseudo(Pseudo pseudo) {
    emit([...state, pseudo]);
  }
}