*Foxpro code
*https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wmf/0d0b32ac-a836-4bd2-a112-b6000a1b4fc9
#DEFINE C_FONTNAME "Arial Unicode MS"
*"Arial Unicode MS"

_SCREEN.FontName = C_FONTNAME

Application.Visible = .F.
Clear
Set Safety Off

Local lcTempFile, i, lcChars, lcOldFontName, lcOldFontCharSet
lcOldFontName = _SCREEN.FontName 
lcOldFontCharSet = _SCREEN.FontCharSet 

lcTempFile = 'c:\temp\chars.txt'
lcChars = ''

* Генерируем тестовые данные
For i = 128 To 127 + 64
  lcChars = lcChars + Textmerge("<<'CODE: #' + TRANSFORM(i) + ' - ' + CHR(i) + ', CODE: #' + TRANSFORM(i+64) + ' - ' + CHR(i+64) + CHR(13) + CHR(10)>>")
Endfor


* массив charsets
LOCAL lni, llErr, lnj, lcText, lcTmp
LOCAL ARRAY aCharsets[19,2], laTmp[19]

TEXT TO lcTmp NOSHOW
ANSI_CHARSET=0x00000000
DEFAULT_CHARSET=0x00000001
SYMBOL_CHARSET=0x00000002
MAC_CHARSET=0x0000004D
JAPAN_CHARSET=0x00000080
HANGUL_CHARSET=0x00000081
JOHAB_CHARSET=0x00000082
GB2312_CHARSET=0x00000086
CHINESEBIG5_CHARSET=0x00000088
GREEK_CHARSET=0x000000A1
TURKISH_CHARSET=0x000000A2
VIETNAMESE_CHARSET=0x000000A3
HEBREW_CHARSET=0x000000B1
ARABIC_CHARSET=0x000000B2
BALTIC_CHARSET=0x000000BA
RUSSIAN_CHARSET=0x000000CC
THAI_CHARSET=0x000000DE
EASTEUROPE_CHARSET=0x000000EE
OEM_CHARSET=0x000000FF
ENDTEXT
ALINES(laTmp, lcTmp)
DIMENSION aCharsets[ALEN(laTmp),2]
FOR lni=1 TO ALEN(laTmp)
	aCharsets[lni,1] = EVALUATE(SUBSTR(laTmp[lni], AT("=",laTmp[lni])+1))
	aCharsets[lni,2] = LEFT(laTmp[lni], AT("=",laTmp[lni])-1)
ENDFOR 


* создаём главное окно
frm = Createobject("FrmMain")
frm.Caption = "FrmMain " + C_FONTNAME
frm.Show()

* создаём дочерние окна для каждого charset
lnj = 0
For i=1 To Alen(aCharsets,1)
  llErr = .F.
  *Проверяем доступность чарсета для шрифта
  TRY
     _SCREEN.FontCharSet = aCharsets[i,1]
  CATCH
  	 llErr = .T.
  ENDTRY
  IF !llErr
     lnj = lnj + 1
     lcTmp = Strtran(lcTempFile,".",Transform(i)+".")
     Strtofile( lcChars, lcTmp, .F.)
     CreateChild(lcTmp, aCharsets[i,1], aCharsets[i,2], lnj)
  ENDIF
Endfor

* Генерируем тестовые данные
lcChars = ""
For i = 0 To 127
  lcChars = lcChars + Textmerge("<<'CODE: #' + TRANSFORM(i) + ' - ' + CHR(i) + ', CODE: #' + TRANSFORM(i+128) + ' - ' + CHR(i+128) + CHR(13) + CHR(10)>>")
Endfor

Strtofile( lcChars, lcTempFile, .F.)
Define Window wEdit0 From 5,130 To 45,230 Font "FoxFont", 12 Grow Minimize Float In FrmMain Name frmEdit0
frmEdit0.FontSize = 15
frmEdit0.Caption = "FoxFont " + lcTempFile
Modify COMMAND (lcTempFile) Window wEdit0 In Window FrmMain Save Nowait

Read Events
Application.Visible = .T.
_SCREEN.FontName = lcOldFontName
_SCREEN.FontCharSet = lcOldFontCharSet

Procedure CreateChild(tcFile, tnCharset, tcName, tnIndex)
  Local lcWin, lcFrm
  lcWin = "wEdit" + Transform(tnIndex)
  lcFrm = "frmEdit" + Transform(tnIndex)

  Define Window (lcWin) ;
    FROM 2*tnIndex, 2*tnIndex To 35+2*tnIndex, 70+2*tnIndex ;
    FONT C_FONTNAME, 12 ;
    GROW Minimize Float In Window FrmMain ;
    NAME (lcFrm)

  With Evaluate(lcFrm)
    .FontCharSet = tnCharset
    .Caption = tcName + " ("+Transform(tnCharset)+")"
  Endwith

  Modify Command(tcFile) Window (lcWin) In Window FrmMain Save Nowait

Endproc


Define Class FrmMain As Form
  Closable = .T.
  ShowWindow = 2
  WindowType = 1
  Height = 900
  Width = 1200
  Procedure Destroy
    Clear Events
  Endproc
Enddefine