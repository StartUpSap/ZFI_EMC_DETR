@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Configuración detr lote'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #B,
    sizeCategory: #M,
    dataClass: #MIXED    
}
define root view entity ZC_I_DTR_LOTE
  as select from zfi_dtr_lote
  //association to ZC_I_STLOTE as _STLOTE on $projection.Sttlt = _STLOTE.Sttlt
{
  key zfi_dtr_lote.bukrs as Bukrs,
  key zfi_dtr_lote.gjahr as Gjahr,
  key zfi_dtr_lote.corre as Corre,
      zfi_dtr_lote.zltdt as Zltdt,
      zfi_dtr_lote.sttlt as Sttlt  //,
     // _STLOTE
}
