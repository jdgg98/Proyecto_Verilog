/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
								Testbench_Registro.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
        Carne: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
        Carne: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene testbench para el modulo del Registro Tipo D transparente. 
	El cual hace al modulo del Registro pasar por ciertas pruebas 
	para comprobar su funcionamiento.
	
***************************************************************************/
/** Se define una esacala de tiempo para definir lo que cada #1
 significa a la hora de simular el programa de la siguiente manera: 
 <Unidad de tiempo>/<Precision> 
 **/ 
`timescale 1ns/1ns
/** 
* El siguiente modulo es el modulo principal del testbench en el cual se 
* le aplican las pruebas pertinentes al modulo Registro. 
 **/ 
module tb_Registro (
    /** 
	* Tiene como salidas las entradas del modulo registro. 
	* El bus de 12 bits L, la entrada de clock CLK, la entrada de
    * reset clr y la entrada enable.  
	**/ 
    output reg [11:0] L, 
    output reg clk,
    output reg clr,
    output reg  en,
    /**
	*  Tiene como entradas las salidas del modulo registro. 
	* La salida Q en la que pasa los 12 bits del bus L. 
	**/ 
    input wire [11:0] Q
);
    /** 
    * Defino los estados iniciales de las variables CLR, CLK y EN. 
    * tal que el clock empiece en bajo, el clr desactivado y en en cero. 
    **/
    initial begin
        clk = 0; 
        clr = 1;
        en = 0;
    end

    /**
    * Defino un always que define que siempre que pasa un ciclo de tiempo
    * de reloj se pasa a cero. 
    **/ 
    always #1 clk = ~clk; 

	
	/** 
	* Se abre un bloque initial para realizar algunas simulaciones 
	* Secuenciales dentro de el. 
	**/ 
    initial 
    /** 
	*  Como se van a realizar varias pruebas se necesita inicial un bloque 
	* begin/end
	**/ 
        begin
			/**
			* Se crea un archivo tipo dump "Comparador.vcd" en el 
			* cual se van a guardar los cambios en los valores que se le hacen 
			* al archivo en  la simulacion. vcd por sus siglas en ingles value change dump. 
			**/
            $dumpfile("registro.vcd");
			/** 
			* Se usa dumpvars para especificar cuales variables se van a guardar 
			* en el archivo dump, como se declara sin argumento, se guardan todas.
			**/ 
            $dumpvars; 

            /** Prueba 1- 
            * Se prueba cuando se define primero el CLR ( en bajo), 
            * luego el enable ( en alto ) y despues L con un valor de la tabla 
            * para los cichles los cuales vencen el 1 de agosto. 
            **/

            #1 clr = 0; 
            #1 en = 1;
            #1 L = 12'b000011000100; 

            /**
            * Se vuelve a poner el valor de clr en alto y el valor de enable en cero. 
            **/ 
            #1 clr = 1;
            #1 en = 0; 
            /** Prueba 2- 
            * Se prueba cuando se define primero el clr en bajo, luego L y luego enable
            con valor de L de la tabla de Atun con fecha de 26 de febrero. 
            **/
            #1 clr = 0; 
            #1 L = 12'b110100010001; 
            #1 en = 1; 


            /**
            * Se vuelve a poner el valor de clr en alto y el valor de enable en cero. 
            **/
            #1 clr = 1;
            #1 en = 0; 
            /** Prueba 3- 
            * Se prueba cuando se define primero Enable, luego un valor 
            * de L para huevos segun la tabla de precios. Y por ultimo
            *  clear. 
            **/
            #1 en = 1; 
            #1 L = 12'b011110010101; 
            #2 clr = 0;
            // Se termina la simulacion. 
            #5 $finish;
        end
endmodule
