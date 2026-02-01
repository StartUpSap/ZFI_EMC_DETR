@AbapCatalog.sqlViewName: 'ZC_I_STLOTEVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS I - estado de lote'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
define view ZC_I_STLOTE_VH as select from zfi_stlote
{
    @ObjectModel.text.element: ['Slnam']
  @Search.defaultSearchElement: true 
    key sttlt as Sttlt,
    slnam as Slnam
}
