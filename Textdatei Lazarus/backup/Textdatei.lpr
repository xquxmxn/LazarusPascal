program Textdatei;

Procedure VeranBearb(VAR Imput:String);
VAR huhu:string;
Begin
  //Bearbeitung soll hier stattfinden
  huhu:= ' ;)';
  Imput:=Imput+huhu;

end;

VAR f,h:textfile;
  Ausgang:string;
  i:integer;
begin
  Assignfile(f,'abitur.txt');
  Reset(f);
  //Textdatei „abitur.txt“ den gesamte Text lesen
  WHILE NOT EOF(f) DO
    Begin
    readln(f,Ausgang);
    writeln('Kontrolle: ',Ausgang);
    end;
  closefile(f);
  //Procedure Bearbeitung
  VeranBearb(Ausgang);
  writeln('Neuer Text: ',Ausgang);
  Assignfile(h,'fertig.txt');
  Rewrite(h);
  //neu entstandene Text in der Datei „fertig.txt“ gespeichert
  For i:=0 to Length(Ausgang) DO
    writeln(h,Ausgang);
  closefile(h);

  readln();
end.

