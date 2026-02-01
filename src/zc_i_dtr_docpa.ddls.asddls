@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS I - detracciones doc pago'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_I_DTR_DOCPA as select from zfi_dtr_docpa                                                                                     
  association [1..1] to I_Supplier as _Sup  on $projection.Supplier = _Sup.Supplier
  association [1..1] to I_Supplier as _Supc on $projection.SupplierC = _Supc.Supplier
  association [1..*] to I_ExtendedWhldgTaxCodeText as _CodeText on  $projection.WithholdingTaxType = _CodeText.WithholdingTaxType
                                                                and $projection.WithholdingTaxCode = _CodeText.WithholdingTaxCode
                                                                and 'PE'            = _CodeText.CountryCode
{
  key zfi_dtr_docpa.rbukrs   as CompanyCode,
  key zfi_dtr_docpa.gjahr    as FiscalYear,
  key zfi_dtr_docpa.belnr    as AccountingDocument,
  key zfi_dtr_docpa.rldnr    as SourceLedger,
  key zfi_dtr_docpa.rldnr    as Ledger,
  key zfi_dtr_docpa.docln    as LedgerGLLineItem,
  key zfi_dtr_docpa.clote    as NumLote,
  zfi_dtr_docpa.blart        as AccountingDocumentType,
  zfi_dtr_docpa.bldat        as DocumentDate,
  zfi_dtr_docpa.budat        as PostingDate,
  zfi_dtr_docpa.xblnr        as DocumentReferenceID,
  zfi_dtr_docpa.lifnr        as Supplier,
  _Sup.BPSupplierName,
  zfi_dtr_docpa.stcd1        as TaxNumber1,
  zfi_dtr_docpa.hkont        as GLAccount,
  zfi_dtr_docpa.koart        as GLAccountType,
  zfi_dtr_docpa.lifnr_c      as SupplierC,
  _Supc.BPSupplierName as BPSupplierNameC,
  zfi_dtr_docpa.stcd1_c      as TaxNumber1C,
  zfi_dtr_docpa.waers_tr     as BalanceTransactionCurrency,
  @Semantics.amount.currencyCode : 'BalanceTransactionCurrency'
  zfi_dtr_docpa.dmbtr_tr     as AmountInBalanceTransacCrcy,
  zfi_dtr_docpa.kursf        as AbsoluteExchangeRate,    
  zfi_dtr_docpa.bankl        as Bank,
  zfi_dtr_docpa.bankn        as BankAccount,  
  zfi_dtr_docpa.gjahr_cl     as ClearingJournalEntryFiscalYear,
  zfi_dtr_docpa.belnr_cl     as ClearingJournalEntry,
  zfi_dtr_docpa.augdt        as ClearingDate,
  zfi_dtr_docpa.waers_bukrs  as CompanyCodeCurrency,
  zfi_dtr_docpa.waers_doc    as DocumentCurrency,
  @Semantics.amount.currencyCode : 'CompanyCodeCurrency'
  zfi_dtr_docpa.wt_qsshh     as WhldgTaxBaseAmtInCoCodeCrcy,
  @Semantics.amount.currencyCode : 'DocumentCurrency'
  zfi_dtr_docpa.wt_qsshb     as WhldgTaxBaseAmtInTransacCrcy,
  @Semantics.amount.currencyCode : 'CompanyCodeCurrency'
  zfi_dtr_docpa.wt_qbshh     as WhldgTaxAmtInCoCodeCrcy,
  @Semantics.amount.currencyCode : 'DocumentCurrency'
  zfi_dtr_docpa.wt_qbshb     as WhldgTaxAmtInTransacCrcy,
  zfi_dtr_docpa.wt_withcd    as WithholdingTaxCode,
  zfi_dtr_docpa.witht        as WithholdingTaxType,
  zfi_dtr_docpa.sttlt        as EstadoCod,
  _CodeText.WhldgTaxCodeName    
}
