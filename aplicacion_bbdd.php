<?php

    // Nota: El código HTML está "incrustado" en el código PHP
	
	// ------------ CONEXIÓN -------------------------------------------------------------------
	// Sustituir por la cadena de conexión de local y de la nube, según el caso
    // Datos de la cadena de conexión

    //LOCAL

    $maquina = "localhost"; // cambiar por localhost si local o la máquina que indica ElephantSQL si la nube
    $puerto = "5432";
    $bbdd = "CarlosArangoVelez"; // cambiar por tu bbdd
    $usuario = "postgres"; // cambiar por tu usuario
    $contrasenya = "<clave>"; // cambiar por tu contraseña

///NUBE


   /* $maquina = "ziggy.db.elephantsql.com"; // cambiar por localhost si local o la máquina que indica ElephantSQL si la nube
    $puerto = "5432";
    $bbdd = "ulsncvni"; // cambiar por tu bbdd
    $usuario = "ulsncvni"; // cambiar por tu usuario
    $contrasenya = "<clave>";*/


    // Usar utf8_encode para que se muestren bien los caracteres con acentos y eñes (codifica un string ISO-8859-1 a UTF-8)
    // Establecer la conexión a bbdd PostgreSQL
    $conexion = pg_connect("host=$maquina port=$puerto dbname=$bbdd user=$usuario password=$contrasenya");

    // Estado de la conexión
    if(!$conexion) {
        echo utf8_encode("Error: No se ha podido realizar la conexión.");
        exit;
    }

	// ------------ CONSULTAS -------------------------------------------------------------------
    //<<<añadir consultaJOIN1>>>
    // Consulta JOIN 1
    function consulta_join1($conexion) {
        // Realizar una consulta SQL
        //select * from profesor LEFT JOIN cargo ON profesor.id_cargo=cargo.id_cargo
        $consulta = "SELECT * from profesor left join cargo on  profesor.id_cargo=cargo.id_cargo"; // Cambiar por vuestra SELECT
        $resultado = pg_query($conexion, $consulta);
		
		// Comprobar resultado de la consulta
        if (!$resultado) {
            echo utf8_encode("No se ha podido realizar la consulta join 1, error: ").pg_last_error();
            exit;
        }

        // Comprobar que devuelve la consulta
        if (pg_num_rows($resultado) == 0) { // La consulta no tiene ninguna fila
            echo utf8_encode("No se encontró ninguna fila que coincida con la consulta join 1.");
        }
        else {
			//<<<añadir mostrar consultaJOIN1>>>
	        echo "<p>===================<br/>";
            echo "CARGO Y SALARIO DE PROFESORES<br/>";
	        echo "===================<p/>";
	        echo "<p>";
			// Mostrar los datos de la consulta
            while ($fila = pg_fetch_row($resultado)) { 
			    // Añadir todos los campos que se quieran mostrar $fila[0] para primer campo, $fila[1] para segundo campo, $fila[2] para tercer campo, ...
                echo "Identificación: $fila[0]  Nombre: $fila[1] Apellidos: $fila[2]  $fila[3] campo 5: $fila[4] Cargo: $fila[15] Salario: $fila[16]"; 
                echo "<br />\n";
            }
	        echo "===================<p/>";
			//<<<añadir mostrar consultaJOIN1>>>
        }
		
		// Liberar los resultados
        pg_free_result($resultado);
	}
    // Realizar consultajoin1
    consulta_join1($conexion);	
	//<<<añadir consultaJOIN1>>>
	
	//<<<añadir consultaJOIN2>>>
    // Consulta JOIN 2
    function consulta_join2($conexion) {
        // Realizar una consulta SQL
     

        $consulta = "SELECT * from estudiante INNER JOIN nota ON estudiante.dni_alumno=nota.dni_alumno"; // Cambiar por vuestra SELECT
        $resultado = pg_query($conexion, $consulta);
		
		// Comprobar resultado de la consulta
        if (!$resultado) {
            echo utf8_encode("No se ha podido realizar la consulta join 2, error: ").pg_last_error();
            exit;
        }

        // Comprobar que devuelve la consulta
        if (pg_num_rows($resultado) == 0) { // La consulta no tiene ninguna fila
            echo utf8_encode("No se encontrñ ninguna fila que coincida con la consulta join 2.");
        }
        else {
			//<<<añadir mostrar consultaJOIN2>>>
	        echo "<p>===================<br/>";
            echo "NOTAS DE LOS ALUMNOS<br/>";
	        echo "===================<p/>";
	        echo "<p>";
			// Mostrar los datos de la consulta
            while ($fila = pg_fetch_row($resultado)) { 
			    // Añadir todos los campos que se quieran mostrar $fila[0] para primer campo, $fila[1] para segundo campo, $fila[2] para tercer campo, ...
                echo "Identificacion: $fila[0]  Apellidos: $fila[1]  $fila[2] Nombre: $fila[3] Nota: $fila[20]"; 
                echo "<br />\n";
                echo "<br />\n";
            }
	        echo "===================<p/>";
			//<<<añadir mostrar consultaJOIN2>>>
        }
		
		// Liberar los resultados
        pg_free_result($resultado);
	}
    // Realizar consultajoin2
    consulta_join2($conexion);	
	//<<<añadir consultaJOIN2>>>
	
	
    //<<<añadir consultaAGREGADA1>>>
    // Consulta AGREGADA 1
    function consulta_agregada1($conexion) {
        // Realizar una consulta SQL
        $consulta = "SELECT AVG(nota) FROM nota;"; // Cambiar por vuestra SELECT
        $resultado = pg_query($conexion, $consulta);
		
		// Comprobar resultado de la consulta
        if (!$resultado) {
            echo utf8_encode("No se ha podido realizar la consulta agregada 1, error: ").pg_last_error();
            exit;
        }

        // Comprobar que devuelve la consulta
        if (pg_num_rows($resultado) == 0) { // La consulta no tiene ninguna fila
            echo utf8_encode("No se encontró ninguna fila que coincida con la consulta agregada 1.");
        }
        else {
			//<<<añadir mostrar AGREGADA1>>>
	        echo "<p>===================<br/>";
            echo "PROMEDIO NOTAS <br/>";
	        echo "===================<p/>";
	        echo "<p>";
			// Mostrar los datos de la consulta
            while ($fila = pg_fetch_row($resultado)) { 
			    // Añadir todos los campos que se quieran mostrar $fila[0] para primer campo, $fila[1] para segundo campo, $fila[2] para tercer campo, ...
                echo "Promedio: $fila[0]"; 
                echo "<br />\n";
            }
	        echo "===================<p/>";
			//<<<añadir mostrar consultaAGREGADA1>>>
        }
		
		// Liberar los resultados
        pg_free_result($resultado);
	}
    // Realizar consultaAGREGADA1
    consulta_agregada1($conexion);	
	////<<<añadir consultaAGREGADA1>>>
	
	//<<<añadir consultaAGREGADA2>>>
    // Consulta AGREGADA 2
    function consulta_agregada2($conexion) {
        // Realizar una consulta SQL
        $consulta = "SELECT COUNT(*) FROM ESTUDIANTE WHERE SEXO='M';"; // Cambiar por vuestra SELECT
        $resultado = pg_query($conexion, $consulta);
		
		// Comprobar resultado de la consulta
        if (!$resultado) {
            echo utf8_encode("No se ha podido realizar la consulta agregada 2, error: ").pg_last_error();
            exit;
        }

        // Comprobar que devuelve la consulta
        if (pg_num_rows($resultado) == 0) { // La consulta no tiene ninguna fila
            echo utf8_encode("No se encontró ninguna fila que coincida con la consulta agregada 2.");
        }
        else {
			//<<<añadir mostrar consultaAGREGADA2>>>
	        echo "<p>===================<br/>";
            echo "CANTIDAD DE ESTUDIANTES MUJERES ACTIVAS ACTUALMENTE<br/>";
	        echo "===================<p/>";
	        echo "<p>";
			// Mostrar los datos de la consulta
            while ($fila = pg_fetch_row($resultado)) { 
			    // Añadir todos los campos que se quieran mostrar $fila[0] para primer campo, $fila[1] para segundo campo, $fila[2] para tercer campo, ...
                echo "Cantidad ninas: $fila[0]"; 
                echo "<br />\n";
            }
	        echo "===================<p/>";
			//<<<añadir mostrar consultaAGREGADA2>>>
        }

		// Liberar los resultados
        pg_free_result($resultado);
	}
	// Realizar consultaAGREGADA2
    consulta_agregada2($conexion);	
	////<<<añadir consultaAGREGADA2>>>

    // Cerrar la conexión
    pg_close($conexion);

?>