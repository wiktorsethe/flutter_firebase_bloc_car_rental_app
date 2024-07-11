import 'package:fluttercarrentalapp/data/models/car.dart';
import 'package:fluttercarrentalapp/domain/repositories/car_repository.dart';

class GetCars {
  final CarRepository repository;

  GetCars(this.repository);

  Future<List<Car>> call() async {
    return await repository.fetchCars();
  }
}