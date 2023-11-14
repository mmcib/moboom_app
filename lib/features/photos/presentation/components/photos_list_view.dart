import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/presentation/bloc/get_data_state.dart';
import 'package:moboom_app/features/common/presentation/components/failure_view.dart';
import 'package:moboom_app/features/common/presentation/components/progress_view.dart';
import 'package:moboom_app/features/photos/data/models/photo_model.dart';
import 'package:moboom_app/features/photos/presentation/components/full_photo_view.dart';
import 'package:moboom_app/features/photos/presentation/cubit/photos_cubit.dart';

// TODO: Update the UI
// TODO: Add responsiveness
// TODO: Add i10n
class PhotosListView extends StatelessWidget {
  const PhotosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosCubit, GetDataState<List<PhotoModel>>>(
      builder: (context, GetDataState<List<PhotoModel>> state) {
        return state.maybeWhen(
          success: (List<PhotoModel> photos) {
            if (photos.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullPhotoView(photo: photos[index]),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: photos[index].thumbnailUrl,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  },
                ),
              );
            }

            return Center(
              child: Text('Photos Not Found'),
            );

          },
          inProgress: () => const ProgressView(color: Colors.deepPurpleAccent),
          failure: (failure) => FailureView(failure: failure),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}