*Foxpro code
*Двухсторонняя сортировка выбором :: Double selection sort
*Sorting array by swap Min and Max
LOCAL lnMin, lnMax, lnMinIndex, lnMaxIndex, lnStart, lnEnd, lnTmp
LOCAL lnSize, lni, llSorted
	m.lnSize = 100
LOCAL ARRAY laData(m.lnSize)
	*Get random data
	FOR m.lni = 1 TO m.lnSize
		m.laData(m.lni) = FLOOR(RAND()*m.lnSize)
	ENDFOR

	*Interval
	m.lnStart = 1
	m.lnEnd = m.lnSize
	*test
	laData(1) = 9999999999999
	laData(100) = -1

LOCAL lnSwapCount
	m.lnSwapCount = 0
*!*   m.laData(50) = 51
*!*   m.laData(51) = 50
SET ESCAPE ON
ON ESCAPE SET STEP ON
	*Start
	DO WHILE m.lnStart < m.lnEnd
		m.lnMinIndex = m.lnStart
		m.lnMin = m.laData(m.lnStart)
		m.lnMaxIndex = m.lnEnd
		m.lnMax = m.laData(m.lnEnd)

		m.llSorted = .T.
		FOR m.lni = m.lnStart TO m.lnEnd
			IF m.lni > m.lnStart AND m.laData(m.lni) < m.laData(m.lni - 1)
				m.llSorted = .F.
			ENDIF
	*IF m.lni > m.lnStart AND m.laData(m.lni) < m.lnMin
			IF m.laData(m.lni) < m.lnMin
				m.lnMin = m.laData(m.lni)
				m.lnMinIndex = m.lni
			ENDIF
	*IF m.lni < m.lnEnd AND m.laData(m.lni) > m.lnMax
			IF m.laData(m.lni) > m.lnMax
				m.lnMax = m.laData(m.lni)
				m.lnMaxIndex = m.lni
			ENDIF
		ENDFOR

		IF m.llSorted
			EXIT
		ENDIF

	*Перестановка
	*trying to optimize
		IF m.lnMaxIndex = m.lnStart AND m.lnMinIndex = m.lnEnd
			?"m.lnMaxIndex = m.lnStart AND m.lnMinIndex = m.lnEnd"
			m.lnTmp = m.laData(m.lnEnd)
			m.laData(m.lnEnd) = m.lnMax
			m.laData(m.lnStart) = m.lnMin
		ELSE
		        IF m.lnMinIndex != m.lnStart
		            m.lnTmp = m.laData(m.lnStart)
		            m.laData(m.lnStart) = m.lnMin
		            m.laData(m.lnMinIndex) = m.lnTmp
		            m.lnSwapCount = m.lnSwapCount + 1
		        ENDIF
	
		*Поправка от Deepseek и Mistral
		        *Если первый элемент был максимум, то перестановку 
		        *надо делать так
		        * Проверяем, не совпадает ли индекс максимального значения с новым индексом минимального значения
		        IF m.lnMaxIndex == m.lnStart
		            m.lnMaxIndex = m.lnMinIndex
		        ENDIF
		 ********
	
		        IF m.lnMaxIndex != m.lnEnd
		            m.lnTmp = m.laData(m.lnEnd)
		            m.laData(m.lnEnd) = m.lnMax
		            m.laData(m.lnMaxIndex) = m.lnTmp
		            m.lnSwapCount = m.lnSwapCount + 1
		        ENDIF

		ENDIF
		DO WHILE m.lnStart < m.lnEnd AND m.laData(m.lnStart) = m.laData(m.lnStart + 1)
			m.lnStart = m.lnStart + 1
		ENDDO
		DO WHILE m.lnStart < m.lnEnd AND m.laData(m.lnEnd) = m.laData(m.lnEnd - 1)
			m.lnEnd = m.lnEnd - 1
		ENDDO

		m.lnStart = m.lnStart + 1
		IF m.lnEnd > m.lnStart + 1
			m.lnEnd = m.lnEnd - 1
		ENDIF
	ENDDO

	m.llSorted = .T.
	FOR m.lni = m.lnStart + 1 TO m.lnEnd
		IF m.laData(m.lni) < m.laData(m.lni - 1)
			m.llSorted = .F.
			EXIT
		ENDIF
	ENDFOR
	?m.llSorted
	?m.lnSwapCount
	SET STEP ON
RETURN
