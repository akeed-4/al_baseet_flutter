class CompanyModel {
  CompanyModel({
    this.companyName,
    this.companyTaxId,
    this.companyAddress,
    this.companyPhone,
    this.companyFax,
    this.companysegal,
    this.companycountry,
    this.companycity,
    this.companystate,
    this.companypostcode,
    this.companybuilding,
    this.companystreet,
  });

  String companyName;
  String companyTaxId;
  String companyAddress;
  String companyPhone;
  String companyFax;
  String companysegal;
  String companycountry;
  String companycity;
  String companystate;
  String companypostcode;
  String companybuilding;
  String companystreet;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        companyName: json["company_name"] ?? '',
        companyTaxId: json["company_tax_id"] ?? '',
        companyAddress: json["company_address"] ?? '',
        companyPhone: json["company_phone"] ?? '',
        companyFax: json["company_fax"] ?? '',
        companysegal: json["company_segal"] ?? '',
        companycountry: json["company_country"] ?? '',
        companycity: json["company_city"] ?? '',
        companystate: json["company_state"] ?? '',
        companypostcode: json["company_postcode"] ?? '',
        companybuilding: json["company_building"] ?? '',
        companystreet: json["company_street"] ?? '',
      );
}
