* I prefer controls in the bottom-right and top-left corners of the grid,
* responsible for move and resize.

USE IN SELECT("customers")
USE  (HOME()+"\samples\data\customer.dbf") ALIAS customers

PUBLIC oMyForm as Form 
oMyForm = CREATEOBJECT("frmTest")
oMyForm.Show()
oMyForm.Refresh 
READ EVENTS

CLEAR ALL

DEFINE CLASS frmTest AS FORM
   *DoCreate = .T.
   ADD OBJECT oContainerWithGrid as ContainerWithGrid WITH ;
      Left = 10, Top = 10, Width = 300, Height = 200
       
   PROCEDURE Destroy
   	DODEFAULT() 
   	CLEAR EVENTS 
ENDDEFINE

DEFINE CLASS ContainerWithGrid AS CONTAINER
	Width = 300
	Height = 200
   *DOCREATE = .T.
   Name = 'ContainerWithGrid'
   Capture = .F.
   Resizable = .T.
   Movable = .T.
       
	lIsResizing = .F.
	lIsMoving   = .F.
	
   * Property to store the old mouse position
   ADD OBJECT OldPosition as Point

   ADD OBJECT oGrid as GRID

   ADD OBJECT oChkMove   AS MoveHandle WITH Left=0, Top=0
   ADD OBJECT oChkResize AS ResizeHandle

   PROCEDURE Init()
      WITH this.oGrid
         *.Parent = THISFORM.ContainerWithGrid
         *.Dock = 0
         .Visible = .T.
         .Height = .parent.Height - 20
         .Width = .parent.Width - 20
         .Left = 10
         .Top = 10
         .RecordSourceType = 1
         .RecordSource = 'customers' && Table 'customers' must exist
         .AllowAddNew = .F.
         *.AllowDelete = .F.
         .ColumnCount = 2
         .refresh
      ENDWITH
       
      * Place resize handle immediately in the corner
      THIS.oChkResize.Left = THIS.Width - THIS.oChkResize.Width
      THIS.oChkResize.Top  = THIS.Height - THIS.oChkResize.Height
   ENDPROC
ENDDEFINE

* === Base class for handles ===
DEFINE CLASS Handle AS checkbox
   Caption = ""
   Style   = 1
   Height  = 20
   Width   = 20
   PicturePosition = 14

   PROCEDURE MouseDown(nButton, nShift, nXCoord, nYCoord)
      THIS.Parent.Capture = .T.
      THIS.Parent.OldPosition.X = nXCoord
      THIS.Parent.OldPosition.Y = nYCoord
   ENDPROC

   PROCEDURE MouseUp(nButton, nShift, nXCoord, nYCoord)
      THIS.Parent.Capture = .F.
      THIS.Parent.OldPosition.X = 0
      THIS.Parent.OldPosition.Y = 0
      THIS.Value = 0
      THIS.Refresh
      NODEFA
   ENDPROC

   PROCEDURE Click
      NODEFA   && fully disable the default checkbox toggle
   ENDPROC
ENDDEFINE


* === Handle for moving ===
DEFINE CLASS MoveHandle AS Handle
   Picture = HOME()+"\graphics\icons\dragdrop\drag1pg.ico"

   PROCEDURE MouseMove(nButton, nShift, nXCoord, nYCoord)
      IF THIS.Parent.Capture
         LOCAL nDX, nDY
         nDX = nXCoord - THIS.Parent.OldPosition.X
         nDY = nYCoord - THIS.Parent.OldPosition.Y
         THIS.Parent.Left = THIS.Parent.Left + nDX
         THIS.Parent.Top  = THIS.Parent.Top  + nDY
         THIS.Parent.OldPosition.X = nXCoord
         THIS.Parent.OldPosition.Y = nYCoord
      ENDIF
   ENDPROC
ENDDEFINE


* === Handle for resizing ===
DEFINE CLASS ResizeHandle AS Handle
   Picture = HOME()+"\graphics\Cursors\NW_05.CUR"

   PROCEDURE MouseMove(nButton, nShift, nXCoord, nYCoord)
      IF THIS.Parent.Capture
         LOCAL nDX, nDY
         nDX = nXCoord - THIS.Parent.OldPosition.X
         nDY = nYCoord - THIS.Parent.OldPosition.Y

         THIS.Parent.Width  = MAX(50, THIS.Parent.Width  + nDX)
         THIS.Parent.Height = MAX(40, THIS.Parent.Height + nDY)

         * Adjust the grid size
         THIS.Parent.oGrid.Width  = THIS.Parent.Width - 20
         THIS.Parent.oGrid.Height = THIS.Parent.Height - 20

         * Update the resize handle position itself
         THIS.Left = THIS.Parent.Width - THIS.Width
         THIS.Top  = THIS.Parent.Height - THIS.Height

         THIS.Parent.OldPosition.X = nXCoord
         THIS.Parent.OldPosition.Y = nYCoord
         
         *this.refresh
      ENDIF
   ENDPROC
ENDDEFINE

DEFINE CLASS Point AS Custom
    X = 0
    Y = 0
ENDDEFINE
