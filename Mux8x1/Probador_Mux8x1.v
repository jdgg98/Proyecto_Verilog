/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
								Probador_Mux8x1.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
         Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
		 Carné: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene el probador que conecta al modulo Mux8x1 con su modulo de 
	testbench.
	
***************************************************************************/

/** 
* Se incluye el contenido de los archivos Mux8x1.v y Testbench_Mux8x1.v,
* los cuales contienen el modulo Mux8x1 a probar y su respectivo 
* testbench
**/
`include "Mux8x1.v"
`include "Testbench_Mux8x1.v"

/**
* Modulo probador para el Mux8x1 diseñado
**/
module Probador();

	/** 
	* Se declaran los wires que van a conectar cada una de las entradas
	* y salidas entre el modulo Mux8x1 y su testbench
	**/
	wire [7:0][3:0] I; 
	wire [2:0] S;
	wire [3:0] Q;

	/** 
	* Se instancian los modulos del Mux8x1 y su testbench,
	* y se conectan sus entradas y salidas a los correspondientes wires
	**/
	Mux8x1 mux8x1(I, S, Q);
	Testbench_Mux8x1 signals_generator(I, S, Q);

endmodule
