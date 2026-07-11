import 'package:compass_app/features/shared/shared.dart';
import 'package:flutter_riverpod/legacy.dart';

const keyFountValue = 'key-fount-app';

// ! PROVIDER
final fountValueProvider = StateNotifierProvider.autoDispose<FountValueNotifier, FountValueState>((ref) {
  final FountValueStorageServiceImpl fountValueStorageServiceImpl = FountValueStorageServiceImpl();
  return FountValueNotifier(fountValueStorageService: fountValueStorageServiceImpl);
});

// ! NOTIFIER
class FountValueNotifier extends StateNotifier<FountValueState> {
  final FountValueStorageService fountValueStorageService;
  FountValueNotifier({
    required this.fountValueStorageService
  }): super(FountValueState()){
    getFountValue();
  }

  // ? metodo para obtener el value del fount guardado localmente
  void getFountValue() async{
    final valueStorage = await fountValueStorageService.getValueFount(keyFountValue);

    state = state.copyWith(
      fountValue: valueStorage,
    );
  }
  
  // ? METODO PARA GUARDAR LOCALMENTE EL FOUNT VALUE
  void setValueFountStorage( bool value ) async{
    await fountValueStorageService.setValueFount(value, keyFountValue);
  }

  // ? METODO PARA CAMBIAR EL ESTADO DE LA PROPERTY FOUNTVALUE
  void changeFount( bool value ) {
    setValueFountStorage(value);

    state = state.copyWith(
      fountValue: value
    );

  }

}

// ! STATE
class FountValueState {
  final bool fountValue;

  FountValueState({
    this.fountValue = true
  });  

  FountValueState copyWith({
    bool? fountValue,
  }) => FountValueState(
      fountValue: fountValue ?? this.fountValue,
  );
  
}
