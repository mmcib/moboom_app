import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moboom_app/core/dependency_injection/domain/dependencies_container.dart';
import 'package:moboom_app/core/extensions/string_extensions.dart';
import 'package:moboom_app/features/photos/presentation/components/photos_list_view.dart';
import 'package:moboom_app/features/photos/presentation/cubit/photos_cubit.dart';
import 'package:moboom_app/generated/l10n.dart';

class PhotosPage extends StatelessWidget {
  const PhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<PhotosCubit>()..loadPhotos(),
      child: Builder(builder: _buildBody),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      // If we have a lot of different, but repetitive colors we should create a file and store them in the Class like "ColorsBase"
      appBar: AppBar(
        title: Text(S.of(context).photos.capitalize()),
        centerTitle: true,
      ),
      body: PhotosListView(),
    );
  }
}
