program sprachen;
TYPE
  Charsettype = set of char;
  Regeltype = Record
    Muster:String;
    Body:String;
  end;

  Regelsettype = ARRAY of Regeltype;

  Grammatiktype  = Record
    Vn: Charsettype;
    Vt: Charsettype;
    P: Regelsettype;
    S: Char;
  end;

VAR  grammatik:Grammatiktype;
check:boolean;build:string;

Function creategram:Grammatiktype;
VAR g:Grammatiktype;
begin
   g.Vn:=['S','A','E'];
   g.Vt:=['m','e','s'];
   g.S:='S';
   SetLength(g.P,6);
   g.P[0].Muster:='S';
   g.P[0].Body:='AE';
   g.P[1].Muster:='A';
   g.P[1].Body:='m';
   g.P[2].Muster:='A';
   g.P[2].Body:='me';
   g.P[3].Muster:='E';
   g.P[3].Body:='e';
   g.P[4].Muster:='E';
   g.P[4].Body:='s';
   g.P[5].Muster:='E';
   g.P[5].Body:='es';
   creategram:=g;
end;
Function checkgram(g:Grammatiktype;Imput:string):boolean;
VAR returne:boolean;i:integer;
Begin
   //Alle Elemente des Imputsrings müssen Vt Elemente sein
   returne:= true;
   writeln(returne);
   For i:=1 to Length(Imput) do
   Begin
     writeln(Imput[i]);
     IF NOT (Imput[i] IN g.Vt) then returne:=false;
     writeln(returne);
   end;


checkgram:= returne;
End;

begin
  //Hauptprogramm
  grammatik :=creategram;
  write('Geben Sie ein Wort an: ');
  readln(build);
  check :=checkgram(grammatik,build);
  writeln('Das Wort ist Teil der Grammatik: ',Check);
  readln;
end.
