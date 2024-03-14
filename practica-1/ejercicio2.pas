program ejercicio2;
var
  nombre_archivo: string[20];
  archivo: Text;
  maximo, minimo, actual: integer;
begin
  maximo := -1;
  minimo := 9999;
  Write('Ingrese el nombre del archivo: ');
  ReadLn(nombre_archivo);
  if (nombre_archivo <> '') then begin
    Assign(archivo, nombre_archivo);
    Reset(archivo);
    while (not Eof(archivo)) do
    begin
      ReadLn(archivo, actual);
      if (actual > maximo) then
        maximo := actual;
      if (actual < minimo) then
        minimo := actual;
      WriteLn(actual);
    end;
    WriteLn('Numero maximo: ', maximo, '    Numero minimo: ', minimo);
  end;
  Close(archivo);
end.