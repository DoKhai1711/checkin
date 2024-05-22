part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus saveStatus;
  final Map<String, dynamic>? profile;
  final Map<String, dynamic>? listPhoneNumber;
  final String? username;
  final String? password;
  final String? address;
  final String? phone;
  final String? money;

  const EditProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.saveStatus = LoadStatus.initial,
    this.profile,
    this.listPhoneNumber,
    this.username,
    this.password,
    this.address,
    this.phone,
    this.money,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        saveStatus,
        profile,
        listPhoneNumber,
        username,
        password,
        address,
        phone,
        money,
      ];

  EditProfileState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? saveStatus,
    Map<String, dynamic>? profile,
    Map<String, dynamic>? listPhoneNumber,
    String? username,
    String? password,
    String? address,
    String? phone,
    String? money,
  }) {
    return EditProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      saveStatus: saveStatus ?? this.saveStatus,
      profile: profile ?? this.profile,
      listPhoneNumber: listPhoneNumber ?? this.listPhoneNumber,
      username: username ?? this.username,
      password: password ?? this.password,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      money: money ?? this.money,
    );
  }
}
