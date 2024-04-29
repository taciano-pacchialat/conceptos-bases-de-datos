program ejercicio5;
type
  articulo = record
    numero: Integer;
    descripcion: String;
    color: String;
    talle: Integer;
    stock: Integer;
    precio: Real;
  end;

  binario = file of articulo;
  texto = Text;

// para marcar, pongo el numero de producto en -111
procedure baja_logica(var archivo_binario: binario; var archivo_texto: texto)
var 
  aux: articulo;
  numero_eliminar: Integer;
begin
  Reset(archivo_binario);
  Reset(archivo_texto);
  Write('Ingrese el numero del articulo a eliminar: ');
  ReadLn(numero_eliminar);
  while (numero_eliminar <> -1) do
  begin
    Read(archivo_binario, aux);
    while ((not(Eof(archivo_binario))) and (archivo_binario.numero <> numero_eliminar)) do
      Read(archivo_binario, aux);
    if (Eof(archivo_binario)) then WriteLn('El producto no existe')
    else
    begin
      WriteLn(archivo_texto, aux.numero, aux.talle, aux.stock, aux.precio, aux.descripcion);
      WriteLn(archivo_texto, aux.color);
      aux.numero := -1;
      Seek(archivo_binario, FilePos(archivo_binario) - 1);
      Write(archivo_binario, aux);
    end;
    Write('Ingrese el numero del articulo a eliminar: ');
    ReadLn(numero_eliminar);
  end;
end;

procedure compactacion(var archivo: binario; var compactado: binario)
var
  aux: articulo;
begin
  Reset(archivo);
  // asumo que el archivo ya existe
  Reset(compactado);
  while (not(Eof(archivo))) do
  begin
    Read(archivo, aux);
    if (aux.numero <> -1) then
      Write(compactado, aux);
  end;
  Close(archivo);
  Close(compactado);
end;

Begin
End.