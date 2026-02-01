@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS consumption - detracción lote'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_C_DTR_LOTE
  provider contract transactional_query
  as projection on ZC_I_DTR_LOTE
{   
     @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_CompanyCodeStdVH',
                     element: 'CompanyCode' } }]
     @Search.defaultSearchElement: true                    
    key Bukrs as CompanyCode,
    key Gjahr,
    key Corre,
    Zltdt,
    @Consumption.valueHelpDefinition: [{
    entity: { name: 'ZC_I_STLOTE_VH',
    element: 'Sttlt' } } ]
    @Search.defaultSearchElement: true
    Sttlt
}
