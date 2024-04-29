program ejercicio4;

type
  disco = record
    codigo: Integer;
    nombre: String;
    genero: String;
    artista: String;
    descripcion: String;
    ano: Integer;
    stock: Integer;
  end;

  binario = file of disco; 

procedure marcar_obsoletos(var archivo: binario)
var
  aux: disco;
  codigo_marcar: Integer;
begin
  Reset(archivo);
  aux.codigo := 0;
  codigo_marcar := -1;
  WriteLn('-111 para cortar!!!');
  while (codigo_marcar <> -111) do
  begin
    Write('Codigo a eliminar: ');
    ReadLn(codigo_marcar);
    if (codigo_marcar <> -111) then 
    begin
      while ((not(Eof(archivo))) and (aux.codigo <> codigo_marcar)) do
        Read(archivo, aux);
      if (Eof(archivo)) then WriteLn('El disco no existe')
      else
      begin
        aux.stock := 0;
        Seek(archivo, FilePos(archivo) - 1);
        Write(archivo, aux);
        WriteLn('El disco ', aux.nombre, ' tiene stock vacio.');
      end;
    end;
  end;
  Close(archivo);
end;

procedure compactacion(var archivo: binario; var compactado: binario)
var
  aux: disco;
begin
  Reset(archivo);
  // asumo que el archivo ya existe
  Reset(compactado);
  while (not(Eof(archivo))) do
  begin
    Read(archivo, aux);
    if (aux.stock > 0) then
      Write(compactado, aux);
  end;
  Close(archivo);
  Close(compactado);
end;

Begin
End.