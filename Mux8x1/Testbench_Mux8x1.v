/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
								Testbench_Mux8x1.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
         Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
		 Carné: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene el testbench para el modulo de un Mux 8x1
	
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
* y se observaran las respuestas del modulo Mux8x1
**/

module Testbench_Mux8x1(
	output reg [7:0][3:0] I,
	output reg [2:0] S,
	input wire [3:0] Q);

	/**
	* Los siguientes parameters serviran como entradas
	* de prueba para el Mux8x1
	**/

	parameter e0 = 4'd0;
	parameter e1 = 4'd1;
	parameter e2 = 4'd2;
	parameter e3 = 4'd3;
	parameter e4 = 4'd4;
	parameter e5 = 4'd5;
	parameter e6 = 4'd6;
	parameter e7 = 4'd7;

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

			$dumpfile("Mux8x1.vcd");
			$dumpvars; // Especificacion para que se guarden todas las variables en el archivo .vcd

			/**
			* Se pasan los valores de los parameters definidos
			* anteriormente a las entradas del Mux8x1
			**/
			I[0] = e0;
			I[1] = e1;
			I[2] = e2;
			I[3] = e3;
			I[4] = e4;
			I[5] = e5;
			I[6] = e6;
			I[7] = e7;

			// Pruebas para el Mux8x1

			/** 
			* Tomando las entradas de seleccion en orden de precedencia 
			* como S[2]S[1]S[0] y dejando un retardo de una unidad de
			* tiempo entre cada prueba
			**/

			//Prueba 1 - S[2]S[1]S[0] = 000
			#1
			S[2] = 0;
			S[1] = 0;
			S[0] = 0;

			//Prueba 2 - S[2]S[1]S[0] = 001
			#1
			S[2] = 0;
			S[1] = 0;
			S[0] = 1;

			//Prueba 3 - S[2]S[1]S[0] = 010
			#1
			S[2] = 0;
			S[1] = 1;
			S[0] = 0;

			//Prueba 4 - S[2]S[1]S[0] = 011
			#1
			S[2] = 0;
			S[1] = 1;
			S[0] = 1;

			//Prueba 5 - S[2]S[1]S[0] = 100
			#1
			S[2] = 1;
			S[1] = 0;
			S[0] = 0;

			//Prueba 6 - S[2]S[1]S[0] = 101
			#1
			S[2] = 1;
			S[1] = 0;
			S[0] = 1;

			//Prueba 7 - S[2]S[1]S[0] = 110
			#1
			S[2] = 1;
			S[1] = 1;
			S[0] = 0;

			//Prueba 8 - S[2]S[1]S[0] = 111
			#1
			S[2] = 1;
			S[1] = 1;
			S[0] = 1;

			/** 
			* Se da una unidad de tiempo mas para poder
			* observar los resultados de la ultima prueba
			* y se termina la simulacion con el keyword finish
			**/
			#1 $finish;
		end
endmodule
