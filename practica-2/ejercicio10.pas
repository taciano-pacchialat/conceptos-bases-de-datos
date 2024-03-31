program ejercicio10;
const 
  valor_alto = '9999';

type
  cadena = String[30];
  producto = record
    codigo: cadena;
    nombre: cadena;
    descripcion: cadena;
    precio: Integer;
    cantidad_vendida: Integer;
    mayor_cantidad_vendida: Integer;
  end;

  producto_maestro = record
    codigo: Integer;
    cantidad_vendida: Integer;
  end;

  archivo_productos = file of producto;
  archivo_maestro = file of producto_maestro;
  arreglo_detalles = array[1..8] of archivo_productos;
  arreglo_productos = array[1..8] of producto;

procedure leer(var archivo: archivo_productos; var registro: producto);
begin
  if (not(Eof(archivo))) then 
    Read(archivo, registro)
  else
    registro.codigo := valor_alto;
end;

function posicion_codigo_minimo(var registros: arreglo_registros): Integer;
var 
  i, codigo_minimo, posicion_minima: Integer;
begin
  posicion_minima := 1;
  codigo_minimo := registros[posicion_minima].codigo;
  for i := 2 to 8 do begin
    if (registros[i].codigo < codigo_minimo) then begin
      codigo_minimo := registros[i].codigo;
      posicion_minima := i;
    end;
  end;
  posicion_codigo_minimo := posicion_minima;
end;

procedure minimo(var detalles: arreglo_detalles; var registros: arreglo_productos; var minimo: producto);
var
  posicion_minima: Integer
begin
  posicion_minima := posicion_codigo_minimo(detalles);
  minimo := registros[posicion_minima];
  leer(detalles[posicion_minima], registros[posicion_minima]);
end;

var
  maestro: archivo_maestro;
  detalles: arreglo_detalles;
  registros: arreglo_productos;
  n_aux: String;
  i: Integer;
  registro_detalle, aux: producto;
  registro_maestro: producto_maestro;
  cantidad_actual: Integer;
begin
  Assign(maestro, 'maestro');
  Reset(maestro);
  for i := 1 to 8 do begin
    n_aux := 'detalle' + i;
    Assign(detalles[i], n_aux);
    Rewrite(detalles[i]);
    leer(detalles[i], registros[i]);
  end; 

  minimo(detalles, registros, registro_detalle);
  while (registro_detalle.codigo <> valor_alto) do begin
    aux := registro_detalle;
    cantidad_actual := 0;
    while (registro_detalle.codigo = aux.codigo) do begin
      cantidad_actual := cantidad_actual + registro_detalle.cantidad_vendida;
      minimo(detalles, registros, registro_detalle);
    end;  
    Read(maestro, registro_maestro);
    if ((registro_maestro.codigo = aux.codigo) and (registro_maestro.cantidad_vendida < cantidad_actual)) then
    begin
      WriteLn('Codigo: ', aux.codigo, ' Nombre: ', aux.nombre, ' Cantidad hasta mes anterior: ', registro_maestro.cantidad_vendida, 
        ' Cantidad mes actual: ', cantidad_actual);
      registro_maestro.cantidad_vendida := registro_maestro.cantidad_vendida + cantidad_actual;
      Seek(maestro, FilePos(maestro) - 1);
      Write(maestro, registro_maestro);
    end;
  end;
end.