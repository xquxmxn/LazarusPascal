program Automaten;
TYPE
  Charsettype = set of char;
  Stringsettype = ARRAY of string;
  Deltatype = Record
    Zeichen:Char;
    Zustand:String;
    Folgezustand:String;
    Folgezeichen:Char;
  end;
  Deltatypetwo = Record
    Zustand:String;
    Folgezustand:String;
    Band:Char;
    nBand:Char;
    move:Char;
  end;

  Deltasettype = ARRAY of Deltatype;
  Deltasettypetwo = ARRAY of Deltatypetwo;

  EEAtype  = Record
    X: Charsettype;   // Eingabealphabet
    Z: Stringsettype; // Zustandsmenge
    Delta: Deltasettype;   // Überführungsfunktion
    Z0: String;       // Anfangszustand
    ZE: String;       // Endzustandsmenge
  end;
  Turingtype = Record
    X: Charsettype;   // Eingabealphabet
    Z: Stringsettype; // Zustandsmenge
    B: Charsettype;   // Bandalphabet
    Delta: Deltasettypetwo;  // Überführungsfunktion
    blank: Char;          // Bandleerzeichen
    Z0: String;       // Anfangszustand
    ZE: String;       // Endzustandsmenge
  end;

Function createauto:EEAtype;
VAR a1:EEAtype;
begin
   a1.X:=['a','b'];
   a1.Z:=['z0','z1','z2'];
   a1.Z0:='z0';
   a1.ZE:='z2';
   SetLength(a1.Delta,2);
   a1.Delta[0].Zeichen:='a';
   a1.Delta[0].Zustand:='z0';
   a1.Delta[0].Folgezustand:='z1';
   a1.Delta[0].Folgezeichen:='b';
   a1.Delta[1].Zeichen:='b';
   a1.Delta[1].Zustand:='z1';
   a1.Delta[1].Folgezustand:='z2';
   a1.Delta[1].Folgezeichen:=' ';
   createauto:=a1;
end;
Function createturing:Turingtype;
VAR t1:Turingtype;
Begin
   t1.X:=['a','b'];
   t1.B:=['a','b','*'];
   t1.Z:=['z0','z1','z2'];
   t1.Z0:='z0';
   t1.ZE:='z2';
   t1.blank:='*';
   SetLength(t1.Delta,2);
   t1.Delta[0].Band:='a';
   t1.Delta[0].nBand:='a';
   t1.Delta[0].Zustand:='z0';
   t1.Delta[0].Folgezustand:='z1';
   t1.Delta[0].move:='r';
   t1.Delta[1].Band:='a';
   t1.Delta[1].nBand:='b';
   t1.Delta[1].Zustand:='z1';
   t1.Delta[1].Folgezustand:='z2';
   t1.Delta[1].move:='r';

   createturing:=t1;
end;

Procedure kontrollausgabe(a1:EEAtype);
VAR i:integer;
Begin
   writeln('Anfangszustand: ',a1.Z0);
   writeln('Endzustand: ',a1.ZE);
   writeln(a1.Delta[0].Zeichen, ' x ',a1.Delta[0].Zustand, ' -> ',a1.Delta[0].Folgezeichen, ' x ',a1.Delta[0].Folgezustand);
  readln();
end;
Function checkauto(a1:EEAtype;imput:string):Boolean;
VAR returne:boolean; i:integer;
 nzustand:string;
Begin
  //Alle Elemente des Imputstrings müssen X Elemente sein
   returne:= true;
   nzustand:= a1.Z0;
   For i:=1 to Length(Imput) do
   //Erster Index im String in Pascal gibt die Länge an?
   Begin
     write(Imput[i],' ~ ');
     IF NOT (Imput[i] IN a1.X) then returne:=false;
     writeln(returne);
     IF (a1.Delta[i-1].Zeichen = imput[i])
        then
            Begin
            nzustand:= a1.Delta[i-1].Folgezustand;
            writeln('Kontrolle: ',Imput[i]);
            writeln('Neuer Zustand: ',nzustand);
            end
        else
            Begin
            writeln('Fehler!');
            returne:=false;
            end;
   end;
   IF NOT (nzustand = a1.ZE)
        then
            Begin
            returne:= false;
            writeln('Endzustand nicht erreicht!: ',nzustand);
            end
        else
              writeln('Endzustand erreicht!: ',nzustand);
checkauto:= returne;
end;
Function checkturing(t1:Turingtype;imput:string):Boolean;
VAR returne:boolean; i,k,n:integer;
 nzustand,nmove:string;
Begin

returne:= true;
nzustand:= t1.Z0;
i:=1;
WHILE Imput[i] = t1.blank DO i:=i+1;
//Ermitllung Blanks vorne, Pos Startzeichen[i]
n:=i;
WHILE Imput[n] = t1.blank DO n:=n+1;
//Ermitllung Blanks hinten, Pos Endzeichen[n+1]
writeln('Anzahl Blanks hinten: ',n);
For k:=i to Length(Imput)-(n+1) DO
// Skip bis erstes Zeichen nach *
Begin
writeln(Imput[k]);
End;

//F NOT (Imput[i] IN t1.X) then returne:=false;
// Move

checkturing:= returne;
end;

VAR  automat1:EEAtype;turing1:Turingtype;
check,tcheck:boolean;build,tbuild:string;
begin
  //EEA
  automat1:=createauto;
  readln();
  kontrollausgabe(automat1);
  writeln('Geben sie ein Wort dieses Automaten an!: ');
  readln(build);
  check:=checkauto(automat1,build);
  writeln('');
  writeln('Check erfolgreich?: ',check);
  readln();
  //Turing
  turing1:=createturing;
  writeln('Geben Sie ein Wort dieser Turingmaschine an!: ');
  readln(tbuild);
  tcheck:=checkturing(turing1,tbuild);
  writeln('');
  writeln('Check erfolgreich?: ',check);
  readln();
end.

