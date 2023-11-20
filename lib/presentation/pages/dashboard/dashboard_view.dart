import 'package:quote_keeper/data/services/share_service.dart';
import 'package:quote_keeper/domain/models/books/book_model.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  final ShareService _shareService = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardViewModel>(
      init: DashboardViewModel(),
      builder: (model) => model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: model.book?.imgPath != null
                          ? Image.network(model.book!.imgPath!).image
                          : Image.network(Globals.libraryBackground).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  // color: colorGrey,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0, 1],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text(
                      model.book?.quote != null
                          ? '"${model.book!.quote}"'
                          : 'You don\'t have any quotes yet, let\'s create one.',
                      textAlign: TextAlign.center,
                      style: context.textTheme.displayMedium!.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (model.book != null) ...[
                            FloatingActionButton.extended(
                              icon: const Icon(Icons.refresh),
                              backgroundColor: Colors.blue,
                              onPressed: () => model.load(),
                              label: const Text('Get Random Quote'),
                            ),
                          ],
                          const Spacer(),
                          SpeedDial(
                            animatedIcon: AnimatedIcons.menu_close,
                            animatedIconTheme: const IconThemeData(size: 28.0),
                            backgroundColor: Colors.green[900],
                            foregroundColor: Colors.white,
                            visible: true,
                            curve: Curves.bounceInOut,
                            children: [
                              SpeedDialChild(
                                child: const Icon(Icons.settings,
                                    color: Colors.white),
                                backgroundColor: Colors.red,
                                onTap: () => Get.toNamed(Globals.routeSettings),
                                label: 'Settings',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Colors.red.shade800,
                              ),
                              if (model.book != null) ...[
                                SpeedDialChild(
                                  child: const Icon(Icons.book,
                                      color: Colors.white),
                                  backgroundColor: Colors.purple,
                                  onTap: () async {
                                    var res =
                                        await Get.toNamed(Globals.routeBooks);

                                    if (res is BookModel) {
                                      model.updateBook(newBook: res);
                                    }
                                  },
                                  label: 'View All Quotes',
                                  labelStyle: labelStyle,
                                  labelBackgroundColor: Colors.purple.shade800,
                                ),
                              ],
                              if (model.book == null) ...[
                                SpeedDialChild(
                                  child: const Icon(Icons.refresh,
                                      color: Colors.white),
                                  backgroundColor: Colors.purple,
                                  onTap: () => model.load(),
                                  label: 'Refresh',
                                  labelStyle: labelStyle,
                                  labelBackgroundColor: Colors.purple.shade800,
                                ),
                              ],
                              SpeedDialChild(
                                child:
                                    const Icon(Icons.add, color: Colors.white),
                                backgroundColor: Colors.cyan,
                                onTap: () =>
                                    Get.toNamed(Globals.routeSearchBooks),
                                label: 'Add New Quote',
                                labelStyle: labelStyle,
                                labelBackgroundColor: Colors.cyan.shade800,
                              ),
                              if (model.book != null) ...[
                                SpeedDialChild(
                                  child: const Icon(Icons.share,
                                      color: Colors.white),
                                  backgroundColor: Colors.teal,
                                  onTap: () =>
                                      _shareService.share(book: model.book!),
                                  label: 'Share This Quote',
                                  labelStyle: labelStyle,
                                  labelBackgroundColor: Colors.teal.shade800,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
