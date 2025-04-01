program Sudoku;
Type
sudogrid = array of array of integer;


//Aufbau des Arrays:
//[0][1][2][3][4][5][6][7][8]
//[0] 1  2
//[1]
//[2]
//[3]
//[4]
//[5]
//[6]
//[7]
//[8]

function GenerateGrid:sudogrid;
VAR i,j:integer; s:sudogrid;
  //Funktion Erstellung Sudoku
Begin
  Randomize;
  SetLength(s,9,9);  //setzt Größe auf 9x9
  For i:=0 to 8 do
   For j:=0 to 8 do
    s[i][j] :=Random(9)+1;
  GenerateGrid:=s;
  writeln('Ein ~random~ Sudoku wurde erstellt!: ');
End;

function EingabeGrid:sudogrid;
VAR i,j:integer; s:sudogrid;
  //Funktion zur Eingabe eines Sudoku
Begin
  writeln('Geben Sie nun ihr eigenes Sudoku ein!: ');
  SetLength(s,9,9);
  For i:=0 to 8 do
   For j:=0 to 8 do
    s[i][j] :=Random(9)+1;
  EingabeGrid:=s;

End;

function LoadGrid:sudogrid;
VAR i,j,k:integer; s,g:sudogrid;
    f:textfile;
    dsuffix:string;
  //Laden eines SudokuGrids aus Textdatei
Begin
  write('Geben den Namen der Textdatei ein (inklusive Dateisuffix Bsp.: .txt) an!: ');
  readln(dsuffix);
  Assignfile(f,dsuffix);
  reset(f);
  SetLength(s,9,9);
  WHILE NOT eof(f) do
  Begin
  For i:=0 to 8 do
   For j:=0 to 8 do
   readln(f,s[i][j]);
  end;
  writeln('Die Datei wurde zusammen mit den Sudoku erfolgreich eingelesen!');
  Closefile(f);
  LoadGrid:=s;
End;

Procedure GridAusgabe(s:sudogrid);
VAR i,j:integer;
  //Procedure zur Ausgabe des Sudoku
Begin
  For i:=0 to 8 do
   Begin
     writeln('');
     For j:=0 to 8 do
      Begin
      write(s[i][j],' ');
      End;
   end;
  writeln('');
  writeln('');
end;
function SudoValid(s: sudogrid): boolean;
var
  i,j,k,l,m,n: integer;
  checkarray: array[0..8, 1..9] of boolean;

procedure ResetCheckArray;
var
  a, b: integer;
begin
  for a := 0 to 8 do
    for b := 1 to 9 do
      checkarray[a, b] := False;
end;

begin
  result := true; // Standardmäßig richtig
  // Überprüfen der Zeilen
  for i := 0 to 8 do
  begin
    ResetCheckArray; // Zurücksetzen des Prüfarrays
    for j := 0 to 8 do
    begin
      if checkarray[i, s[i][j]] then
      begin
        result := false;
        writeln('Zahl ', s[i][j], ' kam schon in Zeile ', i + 1, ' vor.');
      end
      else
        checkarray[i, s[i][j]] := true;
    end;
  end;

  // Überprüfen der Spalten
  for j := 0 to 8 do
  begin
    ResetCheckArray;
    for i := 0 to 8 do
    begin
      if checkarray[j, s[i][j]] then
      begin
        result := false;
        writeln('Zahl ', s[i][j], ' kam schon in Spalte ', j + 1, ' vor.');
      end
      else
        checkarray[j, s[i][j]] := true;
    end;
  end;

  // Überprüfen der 3x3 Quadrate
  for m := 0 to 6 do
  begin
    for n := 0 to 6 do
    begin
      ResetCheckArray;
      for i := m to m + 2 do
      begin
        for j := n to n + 2 do
        begin
          if checkarray[(i - m) * 3 + (j - n), s[i][j]] then
          begin
            result := false;
            writeln('Zahl ', s[i][j], ' kam schon im Quadrat (', m div 3 + 1, ',', n div 3 + 1, ') vor.');
          end
          else
            checkarray[(i - m) * 3 + (j - n), s[i][j]] := true;
        end;
      end;
    end;
  end;
end;

Procedure menue(VAR n:integer);
Begin
  writeln('Dies Ist ein Sudoku Programm:');
  writeln('[1] Es wird ein ~Random~ Sudoku generiert');
  writeln('[2] Sudoku Game: ');
  writeln('[3] Laden eines Sudokus durch eine Textdatei');
  writeln('');
  write('Eingabe: ');
  readln(n)
end;

Procedure engine(auswahl:integer);
VAR  sgrid:sudogrid;
  checkup:boolean;usereingabe:string;
Begin
  writeln('');
  case auswahl of
  1: Begin
     //Random Sudoku
     sgrid:= GenerateGrid;
     GridAusgabe(sgrid);
     checkup:= SudoValid(sgrid);
     writeln();
     writeln('Ist das ~random~ Sudoku richtig?: ',checkup);
     writeln();
     write('Soll solange ein neues Sudoku erstellt werden, bis es einmal richtig ist? (Ja/Nein): ');
     readln(usereingabe);
     IF usereingabe = 'Ja' then
     Repeat
      sgrid:= GenerateGrid;
      checkup:= SudoValid(sgrid);
     until (checkup=true);
     GridAusgabe(sgrid);
     end;
  2:Begin
     //Console Sudoku
     //sgrid:= EingabeGrid;
     readln();
    end;
  3:Begin
     //Laden Textdatei
     sgrid:=LoadGrid;
     GridAusgabe(sgrid);
     checkup:= SudoValid(sgrid);
     writeln('Ist das geladene Sudoku richtig?: ',checkup);
    end;
end;
end;

VAR eingabe:integer;
  //Hauptprogramm
begin
  menue(eingabe);
  engine(eingabe);
  readln();
end.

