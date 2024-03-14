program ejercicio3; 
var
  nombre_archivo: String[20];
  archivo: Text;
  input: String[30];
begin
  Write('Ingrese el nombre del archivo: ');
  ReadLn(nombre_archivo);
  if (nombre_archivo <> '') then begin
    Assign(archivo, nombre_archivo);
    Rewrite(archivo);
    input := '';
    while (True) do
    begin
      Write('Dinosaurio: ');
      ReadLn(input);
      if (input <> 'zzz') then
        WriteLn(archivo, input)
      else
        Break
    end;
  end;
  Close(archivo);
end.