@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS I - pago de detracciones'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_I_PAGDET
  as select from    I_JournalEntryItem as Item
    inner join      I_JournalEntry     as Head  on  Head.CompanyCode        = Item.CompanyCode
                                                and Head.FiscalYear         = Item.FiscalYear
                                                and Head.AccountingDocument = Item.AccountingDocument
    left outer join ZC_I_DTR_DOCPA    as Itemd on  Itemd.CompanyCode           = Item.CompanyCode
                                                and Itemd.FiscalYear            = Item.FiscalYear
                                                and Itemd.AccountingDocument    = Item.AccountingDocument
                                                and Itemd.SourceLedger          = Item.SourceLedger 
                                                and Itemd.Ledger                = Item.Ledger 
                                                and Itemd.LedgerGLLineItem      = Item.LedgerGLLineItem                                 
    left outer join I_JournalEntryItem as Itemc on  Head.CompanyCode           = Itemc.CompanyCode
                                                and Head.FiscalYear            = Itemc.FiscalYear
                                                and Head.AccountingDocument    = Itemc.AccountingDocument
                                                and Itemc.FinancialAccountType = 'K'
   left outer join I_SuplrBankDetailsByIntId as spubn  on Itemc.Supplier           = spubn.Supplier
                                                and spubn.BankAccountHolderName    = 'DET'
                                                and spubn.Bank                     = 'BA020'                                                
   left outer join I_Withholdingtaxitem as wtxit on wtxit.CompanyCode           = Itemc.CompanyCode
                                                and wtxit.FiscalYear            = Itemc.FiscalYear
                                                and wtxit.AccountingDocument    = Itemc.AccountingDocument
                                                and wtxit.WithholdingTaxType    = 'DT'                                                                                     
  association [1..1] to I_Supplier as _Sup  on $projection.Supplier = _Sup.Supplier
  association [1..1] to I_Supplier as _Supc on Itemc.Supplier = _Supc.Supplier
  association [1..*] to I_ExtendedWhldgTaxCodeText as _CodeText on  $projection.WithholdingTaxType = _CodeText.WithholdingTaxType
                                                                and $projection.WithholdingTaxCode = _CodeText.WithholdingTaxCode
                                                                and 'PE'            = _CodeText.CountryCode
{
  key Item.SourceLedger,
  key Item.Ledger,
  key Item.LedgerGLLineItem,
   @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_CompanyCodeStdVH',
                     element: 'CompanyCode'  }                      
        }] 
  key Head.CompanyCode, 
  key Head.FiscalYear,
  key Head.AccountingDocument, 
      Itemd.NumLote,
      Item.AccountingDocumentType,
      Head.DocumentDate,
      Head.PostingDate,
      Head.DocumentReferenceID,
      Item.Supplier,
      _Sup.BPSupplierName,
      _Sup.TaxNumber1,
      Item.GLAccount,
            @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_GLAcctInChtOfAcctsStdVH',
                     element: 'GLAccount' }
        }]
        @Consumption.valueHelpDefault.display:true 
      @Search.defaultSearchElement: true   
      Item.GLAccountType,
      Itemc.Supplier       as SupplierC, //datos de Supplier
      _Supc.BPSupplierName as BPSupplierNameC,
      _Supc.TaxNumber1     as TaxNumber1C,
      Item.BalanceTransactionCurrency,
      @Semantics: { amount : {currencyCode: 'BalanceTransactionCurrency'} }
      Item.AmountInBalanceTransacCrcy,
      Head.AbsoluteExchangeRate,                    //kursf
      spubn.Bank,        //BANKL       Clave Banco         Bank
      spubn.BankAccount, //BANKN       Cuenta Bancaria     BankAccount            
      Item.ClearingJournalEntryFiscalYear,
      Item.ClearingJournalEntry,
      Item.ClearingDate,
      wtxit.CompanyCodeCurrency,
      wtxit.DocumentCurrency,
      @DefaultAggregation:#SUM
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency' 
      wtxit.WhldgTaxBaseAmtInCoCodeCrcy,    //Base Detracc. ML - WT_QSSHH
      @DefaultAggregation:#SUM
      @Semantics.amount.currencyCode: 'DocumentCurrency'    
      wtxit.WhldgTaxBaseAmtInTransacCrcy,    //Base Detracc. MD - WT_QSSHB
      @DefaultAggregation:#SUM
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      wtxit.WhldgTaxAmtInCoCodeCrcy,         //Imp. Detracción ML - WT_QBSHH
      @DefaultAggregation:#SUM
      @Semantics.amount.currencyCode: 'DocumentCurrency'   
      wtxit.WhldgTaxAmtInTransacCrcy,         //Imp. Detracción MD - WT_QBSHB  
      wtxit.WithholdingTaxCode,              //Detracción - WT_WITHCD  
      wtxit.WithholdingTaxType,              // CODE    - witht
      _CodeText.WhldgTaxCodeName,
      //I_SuplrBankDetailsByIntId
      //I_PaymentProposalItem
      cast(
            case 
                when Item.AmountInBalanceTransacCrcy < 0 then 'ROJO'
                when Item.AmountInBalanceTransacCrcy <= 600 then 'AMARILLO'
                when Item.AmountInBalanceTransacCrcy > 600 then 'VERDE'
                else 'BLANCO'
            end as abap.char(10)
        ) as DetraccionSemaforo,
      _Sup,
      _CodeText
}
where
      Head.IsReversal                = ''
  and Item.ClearingJournalEntry      = ''      
  //        and Item.GLAccount
  and Item.SourceLedger              = '0L'
  and Item.Ledger                    = '0L'
  and Item.FinancialAccountType      = 'S'
  //and Itemd.NumLote                  is initial   
