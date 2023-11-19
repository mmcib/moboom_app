import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moboom_app/core/error/failures.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/core/usecases/usecases.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/domain/usecases/get_photos_use_case.dart';
import 'package:moboom_app/features/photos/presentation/cubit/photos_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPhotosUseCase extends Mock implements GetPhotosUseCase {}

void main() {
  late MockGetPhotosUseCase mockGetPhotosUseCase;

  final serverFailure = ServerFailure(
    statusCode: 404,
    errorMessage: 'Sample error message',
    reason: 'Sample reason',
  );

  final clientFailure = ClientFailure(
    Exception('Custom exception'),
    reason: 'Test reason',
  );

  final noInternetConnectionFailure = NoInternetConnectionFailure();

  final mockedPhotos = [
    PhotoModel(
      albumId: 1,
      id: 1,
      title: 'title1',
      url: 'https://photos.com/1/full',
      thumbnailUrl: 'https://photos.com/1/thumbnail',
    ),
    PhotoModel(
      albumId: 2,
      id: 2,
      title: 'title2',
      url: 'https://photos.com/2/full',
      thumbnailUrl: 'https://photos.com/2/thumbnail',
    ),
  ];

  setUp(() {
    mockGetPhotosUseCase = MockGetPhotosUseCase();
    registerFallbackValue(NoParams());
  });

  group('PhotosCubit', () {
    test('initial state is GetDataState.initial', () {
      expect(
        PhotosCubit(mockGetPhotosUseCase).state,
        equals(const GetDataState<List<PhotoModel>>.initial()),
      );
    });

    blocTest<PhotosCubit, GetDataState<List<PhotoModel>>>(
      'emits [GetDataState.inProgress, GetDataState.success] when loadPhotos is successful',
      setUp: () => when(() => mockGetPhotosUseCase.execute(any()))
          .thenAnswer((_) async => Right(mockedPhotos)),
      build: () => PhotosCubit(mockGetPhotosUseCase),
      act: (cubit) => cubit.loadPhotos(),
      expect: () => [
        const GetDataState<List<PhotoModel>>.inProgress(),
        GetDataState<List<PhotoModel>>.success(mockedPhotos),
      ],
    );

    blocTest<PhotosCubit, GetDataState<List<PhotoModel>>>(
      'emits [GetDataState.inProgress, GetDataState.failure] when use case returns a ServerFailure',
      setUp: () => when(() => mockGetPhotosUseCase.execute(any()))
          .thenAnswer((_) async => Left(serverFailure)),
      build: () => PhotosCubit(mockGetPhotosUseCase),
      act: (cubit) => cubit.loadPhotos(),
      expect: () => [
        const GetDataState<List<PhotoModel>>.inProgress(),
        GetDataState<List<PhotoModel>>.failure(serverFailure),
      ],
    );

    blocTest<PhotosCubit, GetDataState<List<PhotoModel>>>(
      'emits [GetDataState.inProgress, GetDataState.failure] when use case returns a ClientFailure',
      setUp: () => when(() => mockGetPhotosUseCase.execute(any()))
          .thenAnswer((_) async => Left(clientFailure)),
      build: () => PhotosCubit(mockGetPhotosUseCase),
      act: (cubit) => cubit.loadPhotos(),
      expect: () => [
        const GetDataState<List<PhotoModel>>.inProgress(),
        GetDataState<List<PhotoModel>>.failure(clientFailure),
      ],
    );

    blocTest<PhotosCubit, GetDataState<List<PhotoModel>>>(
      'emits [GetDataState.inProgress, GetDataState.failure] when use case returns a NoInternetConnectionFailure',
      setUp: () => when(() => mockGetPhotosUseCase.execute(any()))
          .thenAnswer((_) async => Left(noInternetConnectionFailure)),
      build: () => PhotosCubit(mockGetPhotosUseCase),
      act: (cubit) => cubit.loadPhotos(),
      expect: () => [
        const GetDataState<List<PhotoModel>>.inProgress(),
        GetDataState<List<PhotoModel>>.failure(noInternetConnectionFailure),
      ],
    );
  });
}
