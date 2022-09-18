import 'package:flutter/material.dart';
import 'package:fungimobil/constants/extension.dart';

import '../../constants/style.dart';
import '../shimmer/shimmer_loading.dart';

class CommentItemWidget extends StatelessWidget {
  CommentItemWidget(
      {Key? key, required this.data, required this.backgroundColor})
      : super(key: key);

  Map<String, dynamic>? data;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Style.defaultPadding),
      child: ShimmerLoading(
        isLoading: data == null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
          child: Container(
            color: backgroundColor,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.message_outlined,
                color: Style.secondaryColor,
              ),
              title: Padding(
                padding:
                    const EdgeInsets.only(bottom: Style.defaultPadding / 3),
                child: Text(data == null
                    ? 'Kullanıcı ad soyad'
                    : '${data!['name']} ${data!['surname']}'),
              ),
              subtitle: Text(
                data != null ? data!['comment'] : '*' * 50,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: data == null
                  ? null
                  : () {
                      _showCommentDetails(data!, context);
                    },
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showCommentDetails(
      Map<String, dynamic> data, BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize * 2),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Scrollbar(
                radius: const Radius.circular(10000),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Style.defaultPadding * 1.5),
                    child: Column(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.all(Style.defaultPadding / 2),
                          height: Style.defaultPadding / 3,
                          width: Style.defaultPadding * 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10000),
                          ),
                        ),
                        const SizedBox(
                          height: Style.defaultPadding / 2,
                        ),
                        Text(
                          '${data['name']} ${data['surname']}',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: Style.defaultPadding,
                        ),
                        Text(
                          data['comment'],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if(data['added_date'] != null) const SizedBox(
                          height: Style.defaultPadding / 3,
                        ),
                        if(data['added_date'] != null) Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            data['added_date']
                                .toString()
                                .toDateTime()
                                .toFormattedString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context).disabledColor),
                          ),
                        ),
                        const SizedBox(height: Style.defaultPadding,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
