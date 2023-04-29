import 'package:book_quotes/constants/globals.dart';
import 'package:book_quotes/services/model_service.dart';
import 'package:book_quotes/ui/create_quote/create_quote_view_model.dart';
import 'package:book_quotes/ui/drawer/drawer_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_page_widget/ui/simple_page_widget.dart';

class CreateQuoteView extends StatelessWidget {
  CreateQuoteView({Key? key}) : super(key: key);

  /// Key that holds the current state of the scaffold.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _bookTitleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  final ModalService _modalService = ModalService();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateQuoteViewModel>(
      init: CreateQuoteViewModel(),
      builder: (model) => SimplePageWidget(
        drawer: DrawerView(),
        scaffoldKey: _scaffoldKey,
        leftIconButton: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.back(result: false);
          },
        ),
        rightIconButton: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () async {
            bool? confirm = await _modalService.showConfirmation(
              context: context,
              title: 'Submit Quote',
              message: 'Are you sure?',
            );

            if (confirm == null || confirm == false) {
              return;
            }

            try {
              await model.createQuote(
                bookTitle: _bookTitleController.text,
                author: _authorController.text,
                quote: _quoteController.text,
              );
              Get.back(result: true);
            } catch (error) {
              Get.showSnackbar(
                GetSnackBar(
                  title: 'Error',
                  message: error.toString(),
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error),
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
        ),
        title: 'Create Quote',
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (value) => {model.update()},
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).textTheme.headline4!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _bookTitleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    counterStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    hintText: 'Enter book title.',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  onChanged: (value) => {model.update()},
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).textTheme.headline4!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _authorController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    counterStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    hintText: 'Enter book author.',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Theme.of(context).textTheme.headline4!.color,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _quoteController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headline3!.color,
                  ),
                  maxLines: 5,
                  maxLength: 200,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    counterStyle: TextStyle(
                        color: Theme.of(context).textTheme.headline6!.color),
                    hintText:
                        'Enter your favorite quote from ${_bookTitleController.text}',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => _bookTitleController.text.isNotEmpty
                    ? model.updateImage(
                        bookTitle: _bookTitleController.text,
                        imageSource: ImageSource.gallery,
                      )
                    : null,
                child: CachedNetworkImage(
                  imageUrl: model.imgPath ?? Globals.dummyProfilePhotoUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 30,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
