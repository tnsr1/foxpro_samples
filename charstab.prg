*Foxpro code
*Based on the FoxPro code snippet, its primary purpose is to generate and display a character set table for a specified code page (N_CP), including conversions to Unicode and UTF-8 representations.
*Essentially, this script is a code page analyzer/viewer. It iterates through characters with decimal codes from 1 to 255, converts them according to the defined code pages, and populates a database table (chars) with the results, which is then shown in a browse window.

#DEFINE N_CP 1251
#DEFINE C_CP ALLTRIM(TRANS(N_CP))
#DEFINE N_CS 204

#DEFINE C_WINDOW_SCREEN .F.
#DEFINE C_FONTNAME "Arial Unicode MS"

ON KEY LABEL ALT+Q CLEAR EVENTS

CLOSE DATABASES ALL

*SET COLLATE TO "HUNGARY" 
LOCAL Frm_Name 
#IF C_WINDOW_SCREEN

	#DEFINE C_WINDOW SCREEN

	ACTIVATE SCREEN
	
	Frm_Name = "_SCREEN"
#ELSE
	#DEFINE C_WINDOW "wBrowse" + ALLTRIM(TRANS(N_CP)) + "_" + ALLTRIM(TRANS(N_CS))
	Frm_Name = "_" + C_WINDOW
	cmd = "PRIVATE " + Frm_Name

    SET COLOR OF SCHEME 20 TO RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125), RGB(200,200,200, 31, 73, 125)
	DEFINE WINDOW (C_WINDOW) FROM 10,10 TO 55,200 FONT C_FONTNAME, 10 STYLE "B" SYSTEM CLOSE GROW MINIMIZE FLOAT ZOOM IN DESKTOP NAME (Frm_Name) COLOR SCHEME 20 ;
		TITLE C_WINDOW + " CODEPAGE "+ TRANSFORM(N_CP) + " FontCharSet "+ TRANSFORM(N_CP)

	ACTIVATE WINDOW (C_WINDOW)
#ENDIF

CLEAR

*?C_WINDOW
?Frm_Name

CREATE TABLE chars CODEPAGE = N_CP (dec N(3), hex C(2), Glyph C(1), c_unicode C(4), ;
                    c_n_uni C(6), uni_ascw N(10), c_utf8 C(4), ;
                    len_utf8 N(1), c_hex_utf8 C(10), dec_utf8 N(10))

&Frm_Name..FontName = C_FONTNAME

LOCAL lni, lc_uni, lc_n_uni, lc_utf8, lc_hex_utf8
FOR m.lni = 1 TO 255
	lc_uni = STRCONV(CHR(m.lni), 5, N_CP, 1)
	lc_n_uni = STRCONV(lc_uni,15)
	
	lc_utf8 = STRCONV(CHR(m.lni), 9, N_CP, 1)
	lc_hex_utf8 = STRCONV(lc_utf8, 15)         && UTF-8 в hex

#IF .F.
&Frm_Name..FontCharSet = 204
? ;
		m.lni, ;
		STRCONV(CHR(m.lni),15), ;
		CHR(m.lni), ;
		lc_uni, ;
		"U+" + RIGHT(lc_n_uni,2) + LEFT(lc_n_uni,2), ;
		EVAL("0x" + RIGHT(lc_n_uni,2) + LEFT(lc_n_uni,2)), ;
		lc_utf8, ;
		LEN(lc_utf8) 

&Frm_Name..FontCharSet = N_CS
?CHR(m.lni)

	IF (m.lni+1)%16 = 0
		WAIT
	ENDIF
#ENDIF

    INSERT INTO chars VALUES( ;
        m.lni, ;                              && Decimal код
        STRCONV(CHR(m.lni),15), ;             && Hex код
        CHR(m.lni), ;                         && Символ
        lc_uni, ;                            && Unicode представление
        "U+" + RIGHT(lc_n_uni,2) + LEFT(lc_n_uni,2), ;  && Unicode hex код
        EVAL("0x" + RIGHT(lc_n_uni,2) + LEFT(lc_n_uni,2)), ;                       && Decimal Unicode
        lc_utf8, ;                           && UTF-8 представление
        LEN(lc_utf8), ;                      && Длина UTF-8
        lc_hex_utf8, ;                        && Hex UTF-8
        EVALUATE("0x"+ RIGHT(lc_hex_utf8,2) + LEFT(lc_hex_utf8,2)) ;
    )

ENDFOR

*&Frm_Name..FontCharSet = 204
	
?STRCONV(CHR(192), 5, N_CP, 1)
?STRCONV(CHR(192), 5, 1049)

WAIT

CLEAR
lcTmp = IIF(C_WINDOW_SCREEN,"IN SCREEN", "IN WINDOW " + C_WINDOW)
? "Таюлица символов:"

SELECT chars

DO CASE 
CASE N_CP = 1250
	INDEX ON Glyph TAG s_alpha COLLATE "HUNGARY"
CASE N_CP = 1251
	INDEX ON Glyph TAG s_alpha COLLATE "RUSSIAN"
OTHERWISE
	INDEX ON Glyph TAG s_alpha 
ENDCASE

BROWSE TITLE "Символы кодовой страницы " + TRANSFORM(N_CP) + " (160-255)" &lcTmp FONT C_FONTNAME, 10 STYLE "B" NOWAIT NAME qwe
qwe.FontCharSet = N_CS

*_SCREEN.FontCharSet = 204

READ EVENTS