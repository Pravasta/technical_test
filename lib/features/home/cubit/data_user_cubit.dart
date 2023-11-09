import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test/features/login_register/model/user.dart';
import 'package:technical_test/service/data_service.dart';

part 'data_user_state.dart';

class DataUserCubit extends Cubit<DataUserState> {
  DataUserCubit() : super(DataUserInitial());

  void fetchDataUser() async {
    try {
      emit(DataUserLoading());
      List<UserModel> dataUser = await DataService().fecthData();
      emit(DataUserSuccess(dataUser));
    } catch (e) {
      emit(DataUserFailed(e.toString()));
    }
  }
}
