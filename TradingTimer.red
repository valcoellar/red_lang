Red [ needs 'view
    Title: "Trading Timer"
    Author: "Valentin Coellar S. 19/05/2026"
    Version: 0.0.1
]



; 1 solo timer y prubea de concepto

count: make time! 05:00:00


cinco: does [
	count: 05:00:00
	]


view [ size 250x200 
    title "Trading Timmer" 				   
        t1: field "05:00:00" bold
	rate 00:00:01
	on-time [
        count: count - 0:00:01
        t1/text: rejoin [count]
    
	if count <= 00:00:00 [count: 05:00:00]
	]

    
    return
    button "Start" green [cinco]
    button "Stop"  red

    return	
    button "Cerrar" [quit]			    
]
