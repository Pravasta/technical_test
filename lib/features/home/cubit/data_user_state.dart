part of 'data_user_cubit.dart';

sealed class DataUserState extends Equatable {
  const DataUserState();

  @override
  List<Object> get props => [];
}

final class DataUserInitial extends DataUserState {}

final class DataUserLoading extends DataUserState {}

final class DataUserSuccess extends DataUserState {
  final List<UserModel> dataUser;

  const DataUserSuccess(this.dataUser);

  @override
  List<Object> get props => [dataUser];
}

final class DataUserFailed extends DataUserState {
  final String message;

  const DataUserFailed(this.message);

  @override
  List<Object> get props => [message];
}
