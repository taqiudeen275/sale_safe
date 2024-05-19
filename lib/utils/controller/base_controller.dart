import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/utils.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class BaseSqfEntityController<T extends TableBase> extends GetxController {
  RxList<T> models = <T>[].obs;
  RxString searchQuery = "".obs;
  RxList<T> selectedItems = <T>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchModels();
  }

  // Fetch models
  Future<void> fetchModels() async {
    // print('================================================================');
    // print(models.toList());
    // print(models.toList().length);
    // print('================================================================');
  }

  // Add model
  Future<void> addModel(T model) async {
    await model.save();
    fetchModels();
  }

  Future<int> addGetModel(T model) async {
    int saved = await model.save();
    fetchModels();
    return saved;
  }

  // Update model
  Future<void> updateModel(T model) async {
    await model.save();
    await fetchModels();
  }

  // Delete model
  Future<void> deleteModel(T model) async {
    await model.delete();
    await fetchModels();
  }

  // Delete bulk models
  Future<void> deleteBulkModels(List<T> modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteModel(model);
    }
    await fetchModels();
  }
}

// ProductController
class ProductController extends BaseSqfEntityController<Product> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  List<Product> onSearched() {
    if (searchQuery.value.isNotEmpty) {
      return findProductContainingValue(searchQuery.value, models);
    }
    return [];
  }

  List<Product> getLowProductQuantity() {
    RxList<Product> lowProducts = <Product>[].obs;
    for (Product item in models) {
      if (item.quantity! < 20) {
        lowProducts.add(item);
      }
    }
    return lowProducts;
  }

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;
    models.value = await Product().select().toList(preload: true);
    resetSelected();
    isLoading.value = false;

    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Product().select().id.equals(id).delete();
    await fetchModels();
  }

  void onProuctSale(List<Product> products, List<int> quantities) {
    products.asMap().forEach((index, product) async {
      product.quantity = product.quantity! - quantities[index];
      await product.save();
    });
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// PaymentMethodController
class PaymentMethodController extends BaseSqfEntityController<PaymentMethod> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;
    models.value = await PaymentMethod().select().toList();
    resetSelected();
    isLoading.value = false;
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await PaymentMethod().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// SupplierController
class SupplierController extends BaseSqfEntityController<Supplier> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;
    models.value = await Supplier().select().toList();
    resetSelected();
    isLoading.value = false;
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Supplier().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// PaymentDetailController
class PaymentDetailController extends BaseSqfEntityController<PaymentDetail> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;
    models.value = await PaymentDetail().select().toList();
    resetSelected();
    isLoading.value = false;
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await PaymentDetail().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// OrderController
class OrderController extends BaseSqfEntityController<Order> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;
    models.value = await Order().select().toList(preload: true);
    resetSelected();
    isLoading.value = false;
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Order().select().id.equals(id).delete();
    await fetchModels();
  }

  void incrementQuantity(int index) {
    selectedItems[index].quantity = (selectedItems[index].quantity ?? 0) + 1;
  }

  void decrementQuantity(int index) {
    if (selectedItems[index].quantity != null &&
        selectedItems[index].quantity! > 1) {
      selectedItems[index].quantity = selectedItems[index].quantity! - 1;
    }
  }

  Future<void> onItemSelectedSave(int sale) async {
    isLoading.value = true;
    for (final model in selectedItems) {
      model.salesId = sale;
      await model.save();
    }
    await fetchModels();
    isLoading.value = false;
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// InvoiceController
class InvoiceController extends BaseSqfEntityController<Invoice> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;

    models.value = await Invoice().select().toList(preload: true);
    resetSelected();
    isLoading.value = false;
    return super.fetchModels();
  }

  Future<Invoice?> getById(int id) async {
    return await Invoice().getById(id, preload: true);
  }

  Future<Invoice?> getBySaleId(int id) async {
    isLoading.value = true;
    Invoice? invoice =
        await Invoice().select().salesId.equals(id).toSingle(preload: true);
    isLoading.value = false;
    return invoice;
  }

  Future<void> deleteById(int id) async {
    await Invoice().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// PaymentController
class PaymentController extends BaseSqfEntityController<Payment> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;

    models.value = await Payment().select().toList();
    resetSelected();
    isLoading.value = false;

    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Payment().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// ExpenseController
class ExpenseController extends BaseSqfEntityController<Expense> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;
  RxList<Expense> expenseByDate = <Expense>[].obs;

  Future<void> fetchByDate(DateTime date) async {
    isLoading.value = true;

    var res = await Expense().select().toList(preload: true);
    List<Expense> filtered = [];
    for (Expense expense in res) {
      if (isSameDate(expense.date!, date)) {
        filtered.add(expense);
      }
      expenseByDate.value = filtered;
    }
    isLoading.value = false;
  }

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;

    models.value = await Expense().select().toList();
    resetSelected();
    isLoading.value = true;

    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Expense().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// SaleController
class SaleController extends BaseSqfEntityController<Sale> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;
  RxList<Sale> salesByDate = <Sale>[].obs;

  Future<void> fetchByDate(DateTime date) async {
    isLoading.value = true;
    var res = await Sale().select().toList(preload: true);
    List<Sale> filtered = [];
    for (Sale sale in res) {
      if (isSameDate(sale.date!, date)) {
        filtered.add(sale);
      }
      salesByDate.value = filtered;
    }
    isLoading.value = false;
  }

  @override
  Future<void> fetchModels() async {
    isLoading.value = true;
    models.value = await Sale().select().toList(preload: true);
    resetSelected();
    isLoading.value = false;
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Sale().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}

// ProfitAndLossController
class ProfitAndLossController extends BaseSqfEntityController<ProfitAndLoss> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    models.value = await ProfitAndLoss().select().toList();
    resetSelected();
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await ProfitAndLoss().select().id.equals(id).delete();
    await fetchModels();
  }

  void resetSelected() {
    isSelected.value = false;
    selectedID.value = [];
  }

  Future<void> deleteBulkByID(List modelsToDelete) async {
    for (final model in modelsToDelete) {
      await deleteById(model);
    }
    await fetchModels();
  }
}
// Users contriller

class UtilityController extends GetxController {
  final box = GetStorage();
  RxBool isAuthenticated = false.obs;
  String get getAdminPass => box.read('adminpass') ?? "1234";
  void setAdminPass(String val) => box.write('adminpass', val);
  bool authenticate(String pass) {
    if (getAdminPass == pass) {
      isAuthenticated.value = true;
      return isAuthenticated.value;
    } else {
      return false;
    }
  }

}
