import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moboom_app/features/comments/data/models/comment_model.dart';

class CommentCardBody extends StatelessWidget {
  const CommentCardBody({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1.r),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12).r,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2.5.r,
              color: Color(0xFFE0E3E7),
              offset: Offset(0, 1.r),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.r, 8.r, 16.r, 8.r),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(4.r, 0, 12.r, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'name: ${comment.name}',
                        style: TextStyle(
                          color: Color(0xFF14181B),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4.r, 0, 0),
                        child: Text(
                          'email: ${comment.email}',
                          style: TextStyle(
                            color: Color(0xFF57636C),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4.r, 0, 0),
                        child: Text(
                          'body:  ${comment.body}',
                          style: TextStyle(
                            color: Color(0xFF57636C),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
