program SuchenMalAnders;
Type
  feld = ARRAY[1..50] of string;
  felt = ARRAY[1..50] of feld;

Procedure deffeld(VAR f:feld;nf:felt);
Begin
  f[1]:= 'Banane';
  f[2]:= 'Orange';
  f[3]:= 'Pflaume';
  f[4]:= 'Tomate';
  f[5]:= 'Apfel';
  f[6]:= 'Birne';
  f[7]:= 'Zitrone';
  f[8]:='';

  nf[1][2] :='Hallo' //Beispiel zweidimensional

End;
Procedure suchen(f:feld;anz:integer;imput:string;VAR output:integer);
VAR offset,idx:integer;
  gefunden,vorne:boolean;
Begin
  gefunden:=false;
  offset:=0;
  Repeat
   vorne:=True;
   IF vorne=true THEN
   Begin
     idx:=offset+1;
     IF (f[idx]=imput) THEN
        Begin
        //Suche Vorne
        gefunden:=true;
        output:=idx;
        writeln('Gefunden von vorne an: ',idx);
        end
     else vorne:=False;
   end;
  IF vorne=false THEN
    Begin
      idx:=anz-offset;
      IF (f[idx]=imput) THEN
       Begin
       //Suche Hinten
       gefunden:=true;
       output:=idx;
       writeln('Gefunden von hinten an: ',idx);
       end
        else
          offset:=offset+1;
          vorne:=true;
    end;
  until(gefunden=true) or (offset=anz div 2);

end;

VAR nfeld:feld;nfelt:felt;n,x:integer;
  swort,ausgabe:string;
begin
deffeld(nfeld,nfelt);
write('Geben Sie ihr Suchwort ein: ');
readln(swort);
n:=7;
suchen(nfeld,n,swort,x);
readln();
end.

