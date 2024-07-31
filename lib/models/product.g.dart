// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = Map<int, dynamic>.fromEntries(
      List.generate(numOfFields, (index) {
        final field = reader.readByte();
        final value = reader.read();
        return MapEntry(field, value);
      }),
    );
    return Product(
      productId: fields[0] as String?,
      productUrl: fields[1] as String,
      productName: fields[2] as String,
      productPrice: fields[3] as int,
      details: fields[4] as String,
      category: fields[5] as Categories,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productUrl)
      ..writeByte(2)
      ..write(obj.productName)
      ..writeByte(3)
      ..write(obj.productPrice)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.category);
  }
}
