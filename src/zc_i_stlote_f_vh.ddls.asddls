@AbapCatalog.sqlViewName: 'ZC_I_STLOTEFVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS I - estado lote final'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
define view ZC_I_STLOTE_F_VH as select from zfi_stlote_f
{
    @ObjectModel.text.element: ['EstadoF']
  @Search.defaultSearchElement: true 
    key sttlt as EstadoCod,
    slnamf as EstadoF
}
