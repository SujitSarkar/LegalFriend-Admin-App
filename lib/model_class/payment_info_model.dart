class PaymentInfoModel{
  String? wmxId;
  String? refId;
  String? token;
  String? userPhone;
  String? merchantReqAmount;
  String? merchantRefId;
  String? merchantCurrency;
  String? merchantAmountBdt;
  String? conversionRate;
  String? serviceRatio;
  String? wmxChargeBdt;
  String? emiRatio;
  String? emiCharge;
  String? bankAmountBdt;
  String? discountBdt;
  String? merchantOrderId;
  String? requestIp;
  String? cardDetails;
  String? isForeign;
  String? paymentCard;
  String? cardCode;
  String? paymentMethod;
  String? initTime;
  String? txnTime;

  PaymentInfoModel({
      this.wmxId,
      this.refId,
      this.token,
      this.userPhone,
      this.merchantReqAmount,
      this.merchantRefId,
      this.merchantCurrency,
      this.merchantAmountBdt,
      this.conversionRate,
      this.serviceRatio,
      this.wmxChargeBdt,
      this.emiRatio,
      this.emiCharge,
      this.bankAmountBdt,
      this.discountBdt,
      this.merchantOrderId,
      this.requestIp,
      this.cardDetails,
      this.isForeign,
      this.paymentCard,
      this.cardCode,
      this.paymentMethod,
      this.initTime,
      this.txnTime});
}