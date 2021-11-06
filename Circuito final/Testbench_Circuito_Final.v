/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
							Testbench_Circuito_Final.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
         Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr
         Carné: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene el testbench para el modulo del circuito final
	
***************************************************************************/

/** 
* Se incluye la directiva de compilar timescale para indicar el valor
* de cada unidad de tiempo.
* Unidad: 1ns
* Precision: 1ns
**/
`timescale 1ns/1ns

/**
* Modulo de prueba en el que se aplicaran las señales de entrada
* y se observaran las respuestas del modulo del circuito final
**/
module Testbench_Circuito_Final(
    output reg [11:0] L,
    output reg clk, 
    output reg  clr,
    output reg en,
    output reg [4:0] diaRef,
    output reg [3:0] mesRef,
    input wire [3:0] P,
    input wire [1:0] V,
    input wire [11:0] QR);

	/** 
    * Se dispone de un initial block para inicializar las variables
    * de clock(clk), clear(clr) y enable(en)
    **/
    initial begin
        clk = 0; // El reloj empieza en estado bajo
        clr = 0; // Clear empieza en estado bajo (por lo tanto esta activa)
        en = 1; // Enable comienza en estado alto (activa)
    end

    /**
    * Bloque always que cambia el estado del clk, entre alto y bajo, 
    * en cada unidad de tiempo hasta que la simulacion finaliza
    **/
    always #1 clk = ~clk;

    /** 
	* Se dispone de un initial block para estimular todas
	* las señales especificas en una sola prueba, subdividida
	* en varias sub-pruebas
	**/
    initial 
        begin

            /**
			* Se define el nombre el archivo .vcd en cual se
			* guardaran todos los valores de las nets y regs que
			* cambian en la simulacion
			**/
            $dumpfile("Circuito_Final.vcd");
            $dumpvars; // Especificacion para que se guarden todas las variables en el archivo .vcd

             //Se definen el dia y mes de referencia. Fecha de referencia: 25/Feb/2021
             diaRef = 5'b11001; 
	         mesRef = 4'b0010;

             // Pruebas para el circuito final

             /**
             * Cada entrada L estara compuesta por una palabra de 12 bits. De izquierda a
             * derecha, los primeros 5 bits representaran el numero de un dia, los siguientes
             * 4 indicaran el numero del mes y los ultimos 3 señalaran el codigo del producto
             **/
             
             /** Prueba 1 
             * Codigo: 2, Producto: Cafe, Precio: $10, Fecha de caducidad: 31/12
             **/
             #1 clr = 1;
             #2 L = 12'b111111100010; 

             /**
             * Nota: A partir de aqui clear siempre se mantendra inactiva y enable activa
             * para permitir que el registro pase todas las entradas L que le lleguen
             **/
             
             /** Prueba 2 
             * Codigo: 5, Producto: Huevos, Precio: $15, Fecha de caducidad: 25/02
             **/
             #2 L = 12'b110010010101; 

             /** Prueba 3
             * Codigo: 1, Producto: Atun, Precio: $4, Fecha de caducidad: 26/02
             **/
             #2 L = 12'b110100010001;

            /** Prueba 4
            * Codigo: 7, Producto: No asignado (N/A), Precio: $0, Fecha de caducidad: 00/00
            **/
            #5 L = 12'b000000000111; 
            
            /** 
			* Se dan 5 unidades de tiempo mas para poder
			* observar los resultados de la ultima prueba
			* y se termina la simulacion con el keyword finish
			**/
            #5 $finish;
        end
endmodule
