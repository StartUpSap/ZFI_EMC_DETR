@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS C - detracciones doc pago'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_C_DTR_DOCPA
provider contract transactional_query
 as projection on ZC_I_DTR_DOCPA
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    key SourceLedger,
    key Ledger,
    key LedgerGLLineItem,
    key NumLote,
    AccountingDocumentType,
    DocumentDate,
    PostingDate,
    DocumentReferenceID,
    Supplier,
    BPSupplierName,
    TaxNumber1,
    GLAccount,
    GLAccountType,
    SupplierC,
    BPSupplierNameC,
    TaxNumber1C,
    BalanceTransactionCurrency,    
    @Semantics.amount.currencyCode : 'BalanceTransactionCurrency'
    AmountInBalanceTransacCrcy,
    AbsoluteExchangeRate,
    Bank,
    BankAccount,  
    ClearingJournalEntryFiscalYear,
    ClearingJournalEntry,
    ClearingDate,
    CompanyCodeCurrency,
    DocumentCurrency,
    @Semantics.amount.currencyCode : 'CompanyCodeCurrency'
    WhldgTaxBaseAmtInCoCodeCrcy,
    @Semantics.amount.currencyCode : 'DocumentCurrency'
    WhldgTaxBaseAmtInTransacCrcy,
    @Semantics.amount.currencyCode : 'CompanyCodeCurrency'
    WhldgTaxAmtInCoCodeCrcy,
    @Semantics.amount.currencyCode : 'DocumentCurrency'
    WhldgTaxAmtInTransacCrcy,
    WithholdingTaxCode,
    WithholdingTaxType,
    @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_I_STLOTE_F_VH',
    element: 'EstadoCod' } } ]
    @Search.defaultSearchElement: true
    EstadoCod, 
    WhldgTaxCodeName
}
