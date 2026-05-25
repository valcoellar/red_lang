Red [ 
    Title: "Trading Timer"
    Author: "Valentin Coellar S. 19/05/2026 - 20/05/2026"
    Version: 0.0.4
    Needs: View
]


; Changes

; 20/05/2026 V0.0.4
; Boton reset cambia a set
; se crea funcion request-text (que existia en rebol pero no en red) para dialogo/entrada texto
; funciones reset actualizadas, ahora son funciones set para set el timer
; efecto bold al texto de request-text
; se agrega if para evitar resultado negativo, default 00:00:00
; se reduce field de request-text a 100px

; 20/05/2026 V0.0.3
; se crea main para poder agregar mas timers desde ahi
; se crean paneles de cada timer
; se crean 15t y 1h timeframes timers
; se colocan etiquetas  en bold
; se cambia boton start por Reset

; 20/05/2026 V0.0.2
; tamaño del field cambiado
; titulo ahora refleja la version
; asignacion de t1 a t5 para timer 5 mins 
; se retira boton stop
; se agrego etiqueta para describir el timeframe del timer
; renombrada la funcion de reset de 5 mins a reset_T5
; renombrada count por countT5 para poder crear mas timmers


countT5: make time!  05:00
countT15: make time! 15:00
countT1H: make time! 59:00


request-text: func [
    "Pide un texto al usuario mediante una ventana emergente"
    title [string!]
    /local result
][
    result: none
    view/flags [
        title title
        text "Introduce MM:SS" bold
        txt: field 100 [result: txt/text unview]
        button "Aceptar" [result: txt/text unview]
    ] 'modal
if result = none [result: 00:00:00]    
	result
]


reset_T5: does [
	countT5: make time! request-text "ingresa MM:SS"
	]

reset_T15: does [
	countT15: make time! request-text "ingresa MM:SS"
	]

reset_T1H: does [
	countT1H: make time! request-text "ingresa MM:SS"
	]


;********* MAIN *********
Main: layout [ ;size 370x300 
    title "Trading Timer V0.0.4" 
across

panel [
text "5 minutos" bold
        return				   
        t5: field 150 "05:00" bold font-size 20
	rate 00:00:01
	on-time [
        countT5: countT5 - 00:01
        t5/text: rejoin [countT5]
	if countT5 <= 00:00 [countT5: 05:00]
	]
    return
    button "Set" green [reset_T5]
]

panel [
text "15 minutos" bold
        return				   
        t15: field 150 "15:00" bold font-size 20
	rate 00:00:01
	on-time [
        countT15: countT15 - 00:01
        t15/text: rejoin [countT15]
	if countT15 <= 00:00 [countT15: 15:00]
	]
    return
    button "Set" green [reset_T15]
]

panel [
text "1 Hora" bold
        return				   
        h1: field 150 "59:00" bold font-size 20
	rate 00:00:01
	on-time [
        countT1H: countT1H - 00:01
        h1/text: rejoin [countT1H]
	if countT1H <= 00:00 [countT1H: 59:00]
	]
    return
    button "Set" green [reset_T1H]
]



 return	
 button "Cerrar" [quit]

]


view Main

