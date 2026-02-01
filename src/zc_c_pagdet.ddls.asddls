@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS consumption - pago de detracciones'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define root view entity ZC_C_PAGDET
  provider contract transactional_query
  as projection on ZC_I_PAGDET
{
  key SourceLedger,
  key Ledger,
  key LedgerGLLineItem,
  key CompanyCode,
  key FiscalYear,
  key AccountingDocument,
      AccountingDocumentType,
      DocumentDate,
      PostingDate,
      DocumentReferenceID,
      Supplier,
      BPSupplierName,
      TaxNumber1,
      GLAccount,
      GLAccountType,
      Supplier       as SupplierC, //datos de Supplier
      BPSupplierName as BPSupplierNameC,
      TaxNumber1     as TaxNumber1C,
      BalanceTransactionCurrency,
      @Semantics: { amount : {currencyCode: 'BalanceTransactionCurrency'} }
      AmountInBalanceTransacCrcy,
      ClearingJournalEntryFiscalYear,
      ClearingJournalEntry,
      DetraccionSemaforo,
      _Sup
}
