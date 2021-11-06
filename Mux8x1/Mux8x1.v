/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
									Mux8x1.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
		 Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
		 Carné: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene el modulo de un Mux 8x1 construido a partir de modulos Mux4x1,
	que a su vez estan construidos a partir de modulos Mux2x1.
	
***************************************************************************/


/**
* Mux 2x1 Estructural
**/

module Mux2x1(
	input wire [1:0][3:0] I, // Dos entradas de 4 bits
	input wire S, // Entrada de seleccion
	output wire [3:0] Q // Salida de 4 bits
	);

	/**
	* Se utiliza una asignacion condicional, con respecto a
	* la entrada de seleccion, para establecer el valor de 
	* la salida Q
	**/

assign Q = S ? I[1] : I[0]; // Si S=1 => Q=I1, si S=0 => Q=I0
endmodule

/**
* MUX 4x1 construido a partir de modulos Mux2x1
**/

module Mux4x1(
	input wire [3:0][3:0] I, // Cuantro entradas de 4 bits
	input wire [1:0] S, // Dos entradas de seleccion
	output wire [3:0] Q); // Salida de 4 bits

	/**
	* c_arriba es el cable que conecta la salida del mux_arriba con una
	* de las entradas del mux_final y c_abajo es el cable que conecta la
	* salida del mux_abajo con la otra entrada del mux_final.
	**/

	wire [3:0] c_arriba, c_abajo; 

	// Se instancian dos modulos de Mux2x1 

	Mux2x1 mux_arriba(I[1:0], S[0], c_arriba);
	Mux2x1 mux_abajo(I[3:2], S[0], c_abajo);

	// Para el mux_final: c_abajo -> I1 y c_arriba -> I0

	Mux2x1 mux_final({c_abajo, c_arriba}, S[1], Q);

endmodule

/**
* MUX 8x1 construido a partir de modulos Mux4x1
**/

module Mux8x1(
	input wire [7:0][3:0] I, // Ocho entradas de 4 bits
	input wire [2:0] S, // Tres entradas de seleccion
	output wire [3:0] Q); // Salida de 4 bits

	/**
	* c_arriba es el cable que conecta la salida del mux_arriba con una
	* de las entradas del mux_final y c_abajo es el cable que conecta la
	* salida del mux_abajo con la otra entrada del mux_final.
	**/

	wire [3:0] c_arriba, c_abajo; 

	// Se instancian dos modulos de Mux4x1 

	Mux4x1 mux_arriba(I[3:0], S[1:0], c_arriba);
	Mux4x1 mux_abajo(I[7:4], S[1:0], c_abajo);

	/**
	* Para el mux_final se hara una instancia de Mux2x1 
	* donde: c_abajo -> I1 y c_arriba -> I0
	**/

	Mux2x1 mux_final({c_abajo, c_arriba}, S[2], Q);

endmodule
