program ejercicio1;
var
  material: String[30];
  nombre_archivo: String[15];
  archivo: Text;
begin
  WriteLn('Ingrese el nombre del archivo:');
  ReadLn(nombre_archivo);
  if (nombre_archivo <> '') then
  begin
    Assign(archivo, nombre_archivo);
    Rewrite(archivo);
    WriteLn('Ingrese materiales:');
    repeat
      ReadLn(material);
      WriteLn(archivo, material);
    until ((material = 'cemento') or (material = 'Cemento'));
    Close(archivo);
  end; 
end.