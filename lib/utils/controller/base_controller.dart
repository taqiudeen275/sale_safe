import 'package:get/get.dart';
import 'package:sale_safe/model/model.dart';
import 'package:sale_safe/utils/utils.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class BaseSqfEntityController<T extends TableBase> extends GetxController {
  RxList<T> models = <T>[].obs;
  RxString searchQuery = "".obs;
  RxList<T> selectedItems = <T>[].obs;

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

// Implementation od
class CategoryController extends BaseSqfEntityController<Category> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    var dataList = await Category().select().toList();
    models.value = dataList.toList();
    resetSelected();
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Category().select().id.equals(id).delete();
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

  @override
  Future<void> fetchModels() async {
    models.value = await Product().select().toList();
    resetSelected();
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
    models.value = await PaymentMethod().select().toList();
    resetSelected();
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

// LeadController
class LeadController extends BaseSqfEntityController<Lead> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    models.value = await Lead().select().toList();
    resetSelected();
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Lead().select().id.equals(id).delete();
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
    models.value = await Supplier().select().toList();
    resetSelected();
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
    models.value = await PaymentDetail().select().toList();
    resetSelected();
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
    models.value = await Order().select().toList(preload: true);
    resetSelected();
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
    for (final model in selectedItems) {
      model.salesId = sale;
      await model.save();
    }
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

// InvoiceController
class InvoiceController extends BaseSqfEntityController<Invoice> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    models.value = await Invoice().select().toList(preload: true);
    resetSelected();
    return super.fetchModels();
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
    models.value = await Payment().select().toList();
    resetSelected();
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

  @override
  Future<void> fetchModels() async {
    models.value = await Expense().select().toList();
    resetSelected();
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
  RxList<Sale> selectedSale = <Sale>[].obs;

  Future<void> fetchByDate(DateTime date) async {
    selectedSale.value =
        await Sale().select().
  }

  @override
  Future<void> fetchModels() async {
    models.value = await Sale().select().toList(preload: true);
    resetSelected();
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

// PeriodController
class PeriodController extends BaseSqfEntityController<Period> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    models.value = await Period().select().toList();
    resetSelected();
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Period().select().id.equals(id).delete();
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

class UserController extends BaseSqfEntityController<User> {
  RxBool isSelected = false.obs;
  RxList selectedID = [].obs;

  @override
  Future<void> fetchModels() async {
    models.value = await User().select().toList();
    resetSelected();
    return super.fetchModels();
  }

  Future<void> deleteById(int id) async {
    await Period().select().id.equals(id).delete();
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
