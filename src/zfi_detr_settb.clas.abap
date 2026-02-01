CLASS zfi_detr_settb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZFI_DETR_SETTB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
        data: lt_ZFI_STLOTE TYPE STANDARD TABLE OF ZFI_STLOTE.
         lt_ZFI_STLOTE = value
         #(
          ( client = sy-mandt sttlt = ''  slnam = 'Activo'    )
          ( client = sy-mandt sttlt = 'I'  slnam = 'Inactivo'    )
          ).
         MODIFY ZFI_STLOTE FROM TABLE @lt_ZFI_STLOTE.
   out->write( 'salio estado' ).


           data: lt_ZFI_STLOTE_F TYPE STANDARD TABLE OF zfi_stlote_f.
         lt_ZFI_STLOTE_F = value
         #(
          ( client = sy-mandt sttlt = ''   slnamf  = 'Libre'    )
          ( client = sy-mandt sttlt = '1'  slnamf  = 'GENERADO' )
          ( client = sy-mandt sttlt = '2'  slnamf  = 'GENERADO SUNAT' )
          ( client = sy-mandt sttlt = '3'  slnamf  = 'ANULADO' )
          ( client = sy-mandt sttlt = '4'  slnamf  = 'CONSTANCIA SUNAT' )
          ( client = sy-mandt sttlt = '5'  slnamf  = 'COMP BANCO' )
          ).
         MODIFY zfi_stlote_f FROM TABLE @lt_zfi_stlote_f.
   out->write( 'salio estado final' ).


  ENDMETHOD.
ENDCLASS.
