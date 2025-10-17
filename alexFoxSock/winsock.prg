ON KEY LABEL ALT+D SET STEP ON
ON KEY LABEL ALT+Q AppQuit()

SET DEFAULT TO c:\dev\vfp\WinSock\alexFoxSock\

PRIVATE client
client = NULL
PRIVATE client2
client2 = NULL

DO FORM server

*DO FORM client

server.Top = 0
*client.Top = 200

READ EVENTS

PROCEDURE AppQuit()

	CLEAR EVENTS 
	RELEASE ALL 
	CLEAR ALL 
ENDPROC