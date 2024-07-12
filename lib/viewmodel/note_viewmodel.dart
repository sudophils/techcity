import 'package:scoped_model/scoped_model.dart';

class NoteViewModel extends Model{

  int _cart = 0;

  int get cart => _cart;

  void updateCart(){
    _cart ++;
    notifyListeners();
  }

}