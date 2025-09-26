List p=18f4520
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00

setup:
    movlw   0x08	    ;0x08, 0x68
    movwf   0x00
    movwf   0x01
    clrf    0x10

    ; ---- check 4 bits ----
    movf    0x01, w
    andlw   0xF0	    ;b'11110000'
    btfss   STATUS, Z	;Z == 1 -> skip
    goto    skip_add4
    movlw   0x04
    addwf   0x10
    rlncf   0x01
    rlncf   0x01
    rlncf   0x01
    rlncf   0x01	    ;left shift 4 times

skip_add4:
    ; ---- check 2 bits ----
    movf    0x01, w
    andlw   0xC0	    ;b'11000000'
    btfss   STATUS, Z	;Z == 1 -> skip
    goto    skip_add2
    movlw   0x02
    addwf   0x10
    rlncf   0x01
    rlncf   0x01	    ;left shift 2 times

skip_add2:
    ; ---- check highest bit ----
    movf    0x01, w
    andlw   0x80	    ;b'10000000'
    btfss   STATUS, Z	;Z == 1 -> skip
    goto    skip_add1
    movlw   0x01
    addwf   0x10
    rlncf   0x01	    ;left shift 1 time

skip_add1:
    ; ---- check 00000000 ---- output 0x08
    movf    0x00, w
    btfss   STATUS, Z	;Z == 1 -> skip
    goto    finish
    movlw   0x08
    movwf   0x10

finish:
    end