*Foxpro code
*Sorting array by swap Min and Max
LOCAL lnMin, lnMax, lnMinIndex, lnMaxIndex, lnStart, lnEnd, lnTmp
LOCAL lnSize, lni
	m.lnSize = 100
LOCAL ARRAY laData(m.lnSize)
*Get random data
	FOR m.lni = 1 TO m.lnSize
		m.laData(m.lni) = FLOOR(RAND()*m.lnSize)
	ENDFOR
*Interval
	m.lnStart = 1
	m.lnEnd = m.lnSize
*Start
SET ESCAPE ON
ON ESCAPE SET STEP ON
	DO WHILE m.lnStart < m.lnEnd - 1
		m.lnMinIndex = m.lnStart
		m.lnMin = m.laData(m.lnStart)
		m.lnMaxIndex = m.lnEnd
		m.lnMax = m.laData(m.lnEnd)

		FOR m.lni = m.lnStart + 1 TO m.lnEnd
			IF m.laData(m.lni) < m.lnMin
				m.lnMin = m.laData(m.lni)
				m.lnMinIndex = m.lni
			ENDIF
			IF m.laData(m.lni) > m.lnMax
				m.lnMax = m.laData(m.lni)
				m.lnMaxIndex = m.lni
			ENDIF
		ENDFOR
		IF m.lnMinIndex != m.lnStart
			m.lnTmp = m.laData(m.lnStart)
			m.laData(m.lnStart) = m.lnMin
			m.laData(m.lnMinIndex) = m.lnTmp
		ENDIF
		IF m.lnMaxIndex != m.lnEnd
			m.lnTmp = m.laData(m.lnEnd)
			m.laData(m.lnEnd) = m.lnMax
			m.laData(m.lnMaxIndex) = m.lnTmp
		ENDIF
		IF m.lnStart < m.lnEnd - 1
			m.lnStart = m.lnStart + 1
		ENDIF
		IF m.lnEnd > m.lnStart + 1
			m.lnEnd = m.lnEnd - 1
		ENDIF
	ENDDO
	SET STEP ON
RETURN
