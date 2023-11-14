import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/domain/usecases/get_photos_use_case.dart';

class PhotosCubit extends Cubit<GetDataState<List<PhotoModel>>> {
  PhotosCubit(this._getPhotosUseCase) : super(const GetDataState.initial());

  final GetPhotosUseCase _getPhotosUseCase;

  Future<void> loadPhotos() async {
    emit(const GetDataState.inProgress());

    final Either<Failure, List<PhotoModel>> results = await _getPhotosUseCase.execute(NoParams());
    results.fold(
      (Failure failure) => emit(GetDataState.failure(failure)),
      (photos) => emit(GetDataState.success(photos)),
    );
  }
}
