*Foxpro code
CLEAR
Application.Visible = .F.

SET SAFETY OFF 
ON KEY LABEL ALT+Q CLEAR EVENTS

LOCAL lni, lcTempFile, frmWEditMain as FrmMain 
lcTempFile = 'c:\temp\chars1.txt'

*   _SCREEN.Visible = .T.

*!*	_SCREEN.FontName = "Arial"
*!*	_SCREEN.FontSize = 12
*!*	_SCREEN.FontCharSet = 0

frmWEditMain = CREATEOBJECT("FrmMain")
frmWEditMain .Show()
*!*	READ EVENTS

*!*	   DEFINE WINDOW wEditMain FROM 1,40 TO 60,170 MDI SYSTEM CLOSE FLOAT ZOOM NOMINIMIZE GROW IN DESKTOP NAME frmWEditMain
*!*	   *frmWEditMain.ShowWindow = 2
*!*	   *frmWEditMain.WindowType = 1
*!*	   ACTIVATE WINDOW wEditMain
*!*	   SHOW WINDOW wEditMain 
*!*	   frmWEditMain.Closable = .T.
*!*	   frmWEditMain.WindowState = 2
*!*	   frmWEditMain.Visible = .T.
*!*	   frmWEditMain.Show()

	
SET TEXTMERGE ON
SET TEXTMERGE TO (lcTempFile)

FOR m.lni = 192 TO 191 + 32
\<<'CODE: #' + TRANSFORM(m.lni) + ' - ' + CHR(m.lni) + ', CODE: #' + TRANSFORM(m.lni+32) + ' - ' + CHR(m.lni+32)>>
ENDFOR

SET TEXTMERGE TO
SET TEXTMERGE OFF

COPY FILE (lcTempFile) TO (CHRTRAN(lcTempFile,"1","2"))
COPY FILE (lcTempFile) TO (CHRTRAN(lcTempFile,"1","3"))

*CLOSE ALL 

IF .T. AND FILE(lcTempFile)

   DEFINE WINDOW wEdit1 FROM 1,1 TO 50,100 FONT "FoxFont", 12 GROW MINIMIZE FLOAT IN FrmMain NAME frmEdit1
   *ACTIVATE WINDOW wEdit1
   *frmEdit.FontCharSet = 0
   frmEdit1.FontSize = 15
   MODIFY FILE (lcTempFile) WINDOW wEdit1 IN WINDOW FrmMain SAVE NOWAIT

   DEFINE WINDOW wEdit2 FROM 6,16 TO 56,116 FONT "Arial", 12 GROW MINIMIZE FLOAT IN WINDOW FrmMain NAME frmEdit2
   *ACTIVATE WINDOW wEdit2
   frmEdit2.FontCharSet = 0
   frmEdit2.FontSize = 15
   MODIFY FILE (CHRTRAN(lcTempFile,"1","2")) WINDOW wEdit2 IN WINDOW FrmMain NOEDIT SAVE NOWAIT
   
   DEFINE WINDOW wEdit3 FROM 11,31 TO 60,131 FONT "Arial", 12 GROW MINIMIZE FLOAT IN WINDOW FrmMain NAME frmEdit3
   *ACTIVATE WINDOW wEdit3
   frmEdit3.FontCharSet = 204
   frmEdit3.FontSize = 15
   MODIFY FILE (CHRTRAN(lcTempFile,"1","3")) WINDOW wEdit3 IN WINDOW FrmMain NOEDIT SAVE NOWAIT
   
ENDIF

READ EVENTS
*_SCREEN.FontCharSet = 204
Application.Visible = .T.


DEFINE CLASS FrmMain as Form 
	Closable = .T.
	ShowWindow = 2
*	WindowState = 2
	WindowType = 1
	Height = 920
	Width = 1000
	
	PROCEDURE Destroy
		CLEAR EVENTS
ENDDEFINE
