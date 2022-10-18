// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepeatAdapter extends TypeAdapter<Repeat> {
  @override
  final int typeId = 10;

  @override
  Repeat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Repeat.daily;
      case 1:
        return Repeat.weekly;
      case 2:
        return Repeat.monthly;
      default:
        return Repeat.daily;
    }
  }

  @override
  void write(BinaryWriter writer, Repeat obj) {
    switch (obj) {
      case Repeat.daily:
        writer.writeByte(0);
        break;
      case Repeat.weekly:
        writer.writeByte(1);
        break;
      case Repeat.monthly:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepeatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatAdapter extends TypeAdapter<Stat> {
  @override
  final int typeId = 11;

  @override
  Stat read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Stat.none;
      case 1:
        return Stat.physical;
      case 2:
        return Stat.intelligence;
      case 3:
        return Stat.mental;
      default:
        return Stat.none;
    }
  }

  @override
  void write(BinaryWriter writer, Stat obj) {
    switch (obj) {
      case Stat.none:
        writer.writeByte(0);
        break;
      case Stat.physical:
        writer.writeByte(1);
        break;
      case Stat.intelligence:
        writer.writeByte(2);
        break;
      case Stat.mental:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DifficultyAdapter extends TypeAdapter<Difficulty> {
  @override
  final int typeId = 12;

  @override
  Difficulty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Difficulty.trivial;
      case 1:
        return Difficulty.normal;
      case 2:
        return Difficulty.hard;
      default:
        return Difficulty.trivial;
    }
  }

  @override
  void write(BinaryWriter writer, Difficulty obj) {
    switch (obj) {
      case Difficulty.trivial:
        writer.writeByte(0);
        break;
      case Difficulty.normal:
        writer.writeByte(1);
        break;
      case Difficulty.hard:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BountyAdapter extends TypeAdapter<Bounty> {
  @override
  final int typeId = 13;

  @override
  Bounty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Bounty.none;
      case 1:
        return Bounty.small;
      case 2:
        return Bounty.medium;
      case 3:
        return Bounty.large;
      default:
        return Bounty.none;
    }
  }

  @override
  void write(BinaryWriter writer, Bounty obj) {
    switch (obj) {
      case Bounty.none:
        writer.writeByte(0);
        break;
      case Bounty.small:
        writer.writeByte(1);
        break;
      case Bounty.medium:
        writer.writeByte(2);
        break;
      case Bounty.large:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BountyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
