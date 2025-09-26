List p=18f4520
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00
    
setup:
    movlw   0x08    ;0x08, 0x68
    movwf   0x00
    movlw   0x08    ;counter = 8
    movwf   0x01
    clrf    0x10

loop:
    btfsc   0x00, 7 ;bit_7 == 0 -> skip
    goto    finish
    incf    0x10
    rlncf   0x00
    decfsz  0x01    ;0x01 == 0 -> skip
    goto    loop
     
finish:
    end