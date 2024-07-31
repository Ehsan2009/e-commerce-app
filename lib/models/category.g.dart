// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesAdapter extends TypeAdapter<Categories> {
  @override
  final int typeId = 2;

  @override
  Categories read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Categories.watch;
      case 1:
        return Categories.laptop;
      case 2:
        return Categories.tv;
      case 3:
        return Categories.headphone;
      default:
        return Categories.watch;
    }
  }

  @override
  void write(BinaryWriter writer, Categories obj) {
    switch (obj) {
      case Categories.watch:
        writer.writeByte(0);
        break;
      case Categories.laptop:
        writer.writeByte(1);
        break;
      case Categories.tv:
        writer.writeByte(2);
        break;
      case Categories.headphone:
        writer.writeByte(3);
        break;
      case Categories.macBook:
        writer.writeByte(3);
        break;
    }
  }
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 3;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = Map<int, dynamic>.fromEntries(
      List.generate(numOfFields, (index) {
        final field = reader.readByte();
        final value = reader.read();
        return MapEntry(field, value);
      }),
    );
    return Category(
      fields[0] as String,
      fields[1] as Categories,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.categoryUrl);
  }
}
