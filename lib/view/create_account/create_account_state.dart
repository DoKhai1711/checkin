part of 'create_account_cubit.dart';

class CreateAccountState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final Map<String, dynamic>? listAccount;
  final Map<String, dynamic>? listPhoneNumber;
  final bool changeData;
  final String? username;
  final String? password;
  final String? address;
  final String? phone;
  final String? type;
  final String? name;

  const CreateAccountState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.changeData = false,
    this.listAccount,
    this.listPhoneNumber,
    this.username,
    this.password,
    this.address,
    this.phone,
    this.type,
    this.name,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        saveStatus,
        listAccount,
        changeData,
        listPhoneNumber,
        username,
        password,
        address,
        phone,
        type,
        name,
      ];

  CreateAccountState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    Map<String, dynamic>? listAccount,
    bool? changeData,
    Map<String, dynamic>? listPhoneNumber,
    String? username,
    String? password,
    String? address,
    String? phone,
    String? type,
    String? name,
  }) {
    return CreateAccountState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      changeData: changeData ?? this.changeData,
      listAccount: listAccount ?? this.listAccount,
      listPhoneNumber: listPhoneNumber ?? this.listPhoneNumber,
      username: username ?? this.username,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      name: name ?? this.name,
    );
  }
}
