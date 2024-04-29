program ejercicio2;

const
  VALOR_ALTO = 9999;

type
  vehiculo = record
    codigo: Integer;
    patente: String;
    numero_motor: String;
    puertas: Integer;
    precio: Real;
    descripcion: String;
  end;

  archivo_vehiculo = file of vehiculo;

procedure agregar(var archivo: archivo_vehiculo; nuevo_vehiculo: vehiculo);
var 
  dato, cabecera: vehiculo;
  cod, numero_libre: Integer;
begin
  reset(archivo);
  Read(archivo, cabecera);
  Val(cabecera.descripcion, numero_libre, cod);

  if (numero_libre = -1) then
    Seek(archivo, FileSize(archivo))
  else
    begin
      // voy a la posicion libre
      Seek(arhcivo, numero_libre);
      Read(archivo, dato);
      Seek(archivo, 0);
      write(archivo, cabecera);
      Seek(archivo, numero_libre);
    end;
  Write(archivo, nuevo_vehiculo);

  Close(archivo);
end;

procedure eliminar(var archivo: archivo_vehiculo; codigo_eliminar: Integer);
var
  cabecera, dato: vehiculo;
  numero_libre: Integer;
  string_libre: String;
begin
  Reset(archivo);
  Read(archivo, cabecera);

  // busco el registro a eliminar
  Read(archivo, dato);
  while ((dato.codigo <> VALOR_ALTO) and (dato.codigo <> codigo_eliminar)) do
    Read(archivo, dato);
  if (dato.codigo = VALOR_ALTO) then
    WriteLn('No se encontro el vehiculo')
  else
    begin
      numero_libre := FilePos(archivo) - 1;
      Seek(archivo, numero_libre);
      // piso el registro con la cabecera
      Write(archivo, cabecera);
      Str(numero_libre, string_libre);
      // actualizo la cabecera con el nuevo registro libre
      dato.descripcion := string_libre;
      Seek(archivo, 0);
      Write(archivo, dato);
    end;
  Close(archivo);
end;

begin
  
end.