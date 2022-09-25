// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_point.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProgressPointAdapter extends TypeAdapter<ProgressPoint> {
  @override
  final int typeId = 4;

  @override
  ProgressPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressPoint(
      point: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProgressPoint obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.point)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgressPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
