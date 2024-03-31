program ejercicio1;
const 
  valor_alto = '9999';
  cantidad_detalles = 10;
type
  cadena = String[30];
  registro_detalle = record
    codigo_empleado: Integer;
    fecha: cadena;
    dias: Integer;
  end;

  registro_maestro = record
    codigo_empleado: Integer;
    nombre: cadena;
    apellido: cadena;
    fecha_nacimiento: cadena;
    direccion: cadena;
    hijos: Integer;
    telefono: Integer;
    dias_vacaciones: Integer;
  end;

  detalle = file of registro_detalle;
  maestro = file of registro_maestro;

  registros_detalle = array[1..cantidad_detalles] of registro_detalle;
  archivos_detalle = array[1..cantidad_detalles] of detalle;

procedure leer(var det: detalle; var registro: registro_detalle);
begin
  if (not(Eof(det))) then
    read(det, registro)
  else
    registro.codigo_empleado := valor_alto;
end;

function posicion_codigo_minimo(var vector: registros_detalle): Integer;
var 
  i, valor_minimo, posicion_minima: Integer;
begin
  valor_minimo := registro_detalle[1].codigo_empleado;
  posicion_minima := 1;
  for i := 1 to cantidad_detalles do 
  begin
    if (registros_detalle[i].codigo_empleado < valor_minimo) then
    begin
      valor_minimo := registro_detalle[i].codigo_empleado;
      posicion_minima := i;
    end;
  end;
  posicion_codigo_minimo := posicion_minima;
end;

procedure minimo(var registros: registros_detalle; var minimo: registro_detalle; var detalles: archivos_detalle);
var posicion_minima: Integer;
begin
  posicion_minima := posicion_codigo_minimo(detalles);
  minimo := registros[posicion_minima];
  leer(detalles[minimo], registros[minimo]);
end;

procedure actualizar(var archivo_maestro: maestro; var detalles: archivos_detalle )
var 
  reg_maestro: registro_maestro;
  regs_detalle: registros_detalle;
  minimo: registro_detalle;
  aux, i: Integer
  informe: Text;
begin
  // genero archivos detalle
  for i:= 1 to cantidad_detalles do 
  begin
    assign(detalles[i], 'tmp/ej1/detalle' + i);
    Reset(detalles[i]);
    leer(detalles[i], regs_detalle[i]);
  end;  
  Assign(archivo_maestro, 'tmp/ej1/maestro');
  Reset(archivo_maestro);
  Read(maestro, reg_maestro);
  minimo(regs_detalle, minimo, detalles);

  while (minimo.codigo_empleado <> valor_alto) do
  begin
    while (reg_maestro.codigo_empleado <> minimo.codigo_empleado) and (not(Eof(archivo_maestro))) do
      Read(archivo_maestro, reg_maestro);

    // si no termino el archivo maestro
    if (not (Eof(archivo_maestro))) then begin
      aux := minimo.codigo_empleado;
      
      // por si el empleado esta en varios detalles
      while (aux = minimo.codigo_empleado) do
      begin
        if (reg_maestro.dias_vacaciones < minimo.dias) then 
          WriteLn(informe, reg_maestro.codigo_empleado, reg_maestro.nombre, reg_maestro.dias_vacaciones, minimo.dias)
        else
          reg_maestro.dias_vacaciones := reg_maestro.dias_vacaciones - minimo.dias;
          minimo(regs_detalle, minimo, detalles); 
      end;
      Seek(archivo_maestro, FilePos(archivo_maestro) - 1);
      Write(maestro, reg_maestro);
    end;
      
  end;

  for i := 1 to cantidad_detalles do 
    Close(detalles[i]);
  Close(archivo_maestro);
  Close(informe);

end;

begin

end.