*Foxpro code
*Implementations of Hex function

?Hex1(255)
?Hex3(255)
?Hex3(255)
?TRANSFORM(255,"@0")

FUNCTION Hex3(tnNum)
  IF tnNum = 0
    RETURN "0"
  ENDIF 
  LOCAL lnDigit, lnIntDev16
  lnDigit = MOD(tnNum, 16)
  lnIntDev16 = INT(tnNum / 16)
  RETURN IIF(lnIntDev16 = 0, "", Hex3(lnIntDev16)) + IIF(lnDigit < 10, STR(lnDigit, 1), CHR(lnDigit + 55))
ENDFUNC

FUNCTION Hex2(tnNum)
  IF tnNum = 0
      RETURN "0"
  ENDIF
  LOCAL lcHex, lnDigit
  lcHex = ""
  DO WHILE ABS(tnNum) > 0
    lnDigit = BITAND(tnNum, 0x0F)
    lcHex = SUBSTR("0123456789ABCDEF", lnDigit + 1, 1) + lcHex
    tnNum = BITRShift(tnNum, 4)
  ENDDO
  RETURN lcHex
ENDFUNC

FUNCTION Hex1(tnNum)
    IF tnNum = 0
        RETURN "0"
    ENDIF 
    LOCAL lnDigit, lnIntDev256
    lnDigit = MOD(tnNum, 256)
    lnIntDev256 = INT(tnNum / 256)
    RETURN IIF(lnIntDev256 = 0, "", Hex1(lnIntDev256)) + STRCONV(CHR(lnDigit), 15)
ENDFUNC
