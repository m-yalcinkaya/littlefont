import '../../Repository/category_repository.dart';
import 'add_category_index.dart';

class AddCategory extends ConsumerStatefulWidget {

  const AddCategory({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kategori Ekle'),
        ),
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
                  for (int i = 0;
                      i < ref.read(categoryProvider).category.length;) {
                    if (ref.read(categoryProvider).category[i].categoryName ==
                        value) {
                      isFounded = true;
                    }
                    return isFounded
                        ? 'Aynı isimde bir kategori zaten var!!'
                        : null;
                  }
                  return null;
                },
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration:
                    const InputDecoration(hintText: 'Bir Kategori Oluşturun'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final isSuitable = formKey.currentState?.validate();
                if (isSuitable == true) {
                  ref.read(categoryProvider).addCategory(controller.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                      ));
                }
              },
              child: const Text('Oluştur'),
            )
          ],
        ),
      ),
    );
  }
}
