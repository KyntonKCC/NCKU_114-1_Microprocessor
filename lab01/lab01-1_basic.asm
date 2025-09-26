List p=18f4520
    #include<p18f4520.inc>
        CONFIG OSC = INTIO67
        CONFIG WDT = OFF
        org 0x00

setup:
    movlw   0x03    ;x1 = 0x03, x1 = 0x08
    movwf   0x00    ;x1
    movlw   0x02    ;x2 = 0x02, x2 = 0x08
    movwf   0x01    ;x2
    
    addwf   0x00, w ;wreg = wreg + [0x00]
    movwf   0x10    ;A1
    
    movlw   0xb5    ;y1 = 0xb5, y1 = 0x0f
    movwf   0x02    ;y1
    movlw   0x04    ;y2 = 0x04, y2 = 0x02
    movwf   0x03    ;y2
    
    subwf   0x02, w ;wreg = [0x02] - wreg
    movwf   0x11    ;A2
    
    movf    0x10, w
    cpfsgt  0x11    ;[0x11] > wreg -> skip
    goto    part
    movlw   0x01
    goto    finish
    
part:
    movlw   0xff
    
finish:
    movwf   0x20
    end