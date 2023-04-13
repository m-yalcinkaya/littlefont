import 'package:flutter/material.dart';
import 'package:littlefont/Repository/notes_repository.dart';
import 'package:littlefont/Screens/category_page.dart';

class AddCategory extends StatelessWidget {
  final NotesRepository notesRepository;
  AddCategory({Key? key, required this.notesRepository,}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Kategori Ekle'),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: TextFormField(
                maxLength: 50,
                controller: controller,
                validator: (value) {
                  bool isFounded = false;
                  for(int i=0; i<notesRepository.category.length;){
                    if(notesRepository.category[i].categoryName == value){
                      isFounded = true;
                    }
                    return isFounded ? 'Aynı isimde bir kategori zaten var!!' : null;
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(hintText: 'Kategori ismi girin'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  final isSuitable = formKey.currentState?.validate();
                  if(isSuitable == true){
                    notesRepository.addCategory(controller.text);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryPage(notesRepository: notesRepository,),));
                  }
                },
                child: const Text('Kaydet'),
            )
          ],
        ),
      ),
    );
  }
}
