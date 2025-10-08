enum PotStatus {
  beforeConfirmed,
  confirmed,
  waitAccounting,
  accountingDone,
  archived,
}

extension PotStatusExtension on PotStatus {
  String get value {
    switch (this) {
      case PotStatus.beforeConfirmed:
        return 'BEFORE_CONFIRMED';
      case PotStatus.confirmed:
        return 'CONFIRMED';
      case PotStatus.waitAccounting:
        return 'WAIT_ACCOUNTING';
      case PotStatus.accountingDone:
        return 'ACCOUNTING_DONE';
      case PotStatus.archived:
        return 'ARCHIVED';
    }
  }

  static PotStatus fromString(String str) {
    switch (str) {
      case 'BEFORE_CONFIRMED':
        return PotStatus.beforeConfirmed;
      case 'CONFIRMED':
        return PotStatus.confirmed;
      case 'WAIT_ACCOUNTING':
        return PotStatus.waitAccounting;
      case 'ACCOUNTING_DONE':
        return PotStatus.accountingDone;
      case 'ARCHIVED':
        return PotStatus.archived;
      default:
        throw Exception('Unknown PotStatus: $str');
    }
  }
}
