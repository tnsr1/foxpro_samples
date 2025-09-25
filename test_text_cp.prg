*Foxpro code
CLEAR
Application.Visible = .F.
SET SAFETY OFF 

PRIVATE lcTempFile, aCharsets[1], i
lcTempFile = 'c:\temp\chars.txt'

* Aaia?e?oai oanoiaue oaee
SET TEXTMERGE ON
SET TEXTMERGE TO (lcTempFile)
FOR i = 192 TO 191 + 32
\<<'CODE: #' + TRANSFORM(i) + ' - ' + CHR(i) + ', CODE: #' + TRANSFORM(i+32) + ' - ' + CHR(i+32)>>
ENDFOR
SET TEXTMERGE TO
SET TEXTMERGE OFF

* iannea charsets
DIMENSION aCharsets[9,2]
aCharsets[1,1]=0     && ANSI
aCharsets[1,2]="Western"
aCharsets[2,1]=177
aCharsets[2,2]="Hebrew"
aCharsets[3,1]=178
aCharsets[3,2]="Arabic"
aCharsets[4,1]=161
aCharsets[4,2]="Greek"
aCharsets[5,1]=162
aCharsets[5,2]="Turkish"
aCharsets[6,1]=186
aCharsets[6,2]="Baltic"
aCharsets[7,1]=238
aCharsets[7,2]="Central European"
aCharsets[8,1]=204
aCharsets[8,2]="Cyrillic"
aCharsets[9,1]=163
aCharsets[9,2]="Vietnamese"

* nicaa?i aeaaiia ieii
frm = CREATEOBJECT("FrmMain")
frm.Show()

* nicaa?i ai?a?iea ieia aey ea?aiai charset
FOR i=1 TO ALEN(aCharsets,1)
	*IF !INLIST(aCharsets[i,1],2,77,128,129,134)
		COPY FILE (lcTempFile) TO (STRTRAN(lcTempFile,".",TRANSFORM(i)+"."))
	    DO CreateChild WITH STRTRAN(lcTempFile,".",TRANSFORM(i)+"."), aCharsets[i,1], aCharsets[i,2], i
	*ENDIF
ENDFOR

DEFINE WINDOW wEdit0 FROM 1,1 TO 50,100 FONT "FoxFont", 12 GROW MINIMIZE FLOAT IN FrmMain NAME frmEdit0
*ACTIVATE WINDOW wEdit1
*frmEdit.FontCharSet = 0
frmEdit0.FontSize = 15
frmEdit0.Caption = "FoxFont " + lcTempFile
MODIFY FILE (lcTempFile) WINDOW wEdit0 IN WINDOW FrmMain SAVE NOWAIT


READ EVENTS
*_SCREEN.FontCharSet = 204
Application.Visible = .T.


PROCEDURE CreateChild(tcFile, tnCharset, tcName, tnIndex)
    LOCAL lcWin, lcFrm 
    lcWin = "wEdit" + TRANSFORM(tnIndex)
    lcFrm = "frmEdit" + TRANSFORM(tnIndex)

    DEFINE WINDOW (lcWin) ;
        FROM 3*tnIndex, 10*tnIndex TO 35+3*tnIndex, 60+10*tnIndex ;
        FONT "Arial", 12 ;
        GROW MINIMIZE FLOAT IN WINDOW FrmMain ;
        NAME (lcFrm)

    &lcFrm..FontCharSet = tnCharset
    *&lcWin..FontSize = 12
    &lcFrm..Caption = tcName + " ("+TRANSFORM(tnCharset)+")"

    MODIFY FILE (tcFile) WINDOW (lcWin) IN WINDOW FrmMain NOEDIT SAVE NOWAIT
ENDPROC


DEFINE CLASS FrmMain as Form 
    Closable = .T.
    ShowWindow = 2
    WindowType = 1
    Height = 900
    Width = 1200
    PROCEDURE Destroy
        CLEAR EVENTS
    ENDPROC
ENDDEFINE
