Map<String, dynamic> loanNameMapper() {
  try {
    return {
      'C': 'สินเชื่อรถยนต์',
      'M': 'สินเชื่อมอเตอร์ไซค์',
      'T': 'สินเชื่อรถบรรทุก',
      'H': 'สินเชื่อบ้านและที่ดิน',
      'V': 'สินเชื่อรถเพื่อการเกษตร',
      'L': 'สินเชื่อที่ดินว่างเปล่า',
      'CI': 'ประกันรถยนต์',
      'TI': 'ประกันรถบรรทุก',
      'MI': 'ประกันมอเตอร์ไซค์',
      'ACT': 'พรบ',
    };
  } catch (e) {
    return {'': ''};
  }
}

Map<String, dynamic> loanIconMapper() {
  return {
    'C': 'CarLoan',
    'M': 'MotorLoanIcon',
    'T': 'TruckLoanIcon',
    'H': 'HouseLoanIcon',
    'V': 'TracterLoanIcon',
    'L': 'AgriculturalLianIcon',
    'CI': 'CarInsuranceLoanIcon',
    'TI': 'TruckInsuranceLoanIcon',
    'MI': 'MotorInsuranceLoanIcon',
    'ACT': 'ActInsuranceLoanIcon',
  };
}

const configKey = [
  {'label': 'สินเชื่อมอเตอร์ไซค์', 'valueField': 'Mloan'},
];
