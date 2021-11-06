/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
							Probador_Circuito_Final.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
         Carne: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
		 Carne: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene el probador que conecta al modulo del circuito final con su 
	modulo de testbench.
	
***************************************************************************/

/** 
* Se incluye el contenido de los archivos Circuito_Final.v y 
* Testbench_Circuito_Final.v, los cuales contienen el modulo del circuito
* final a probar y su respectivo testbench
**/
`include "Circuito_Final.v"
`include "Testbench_Circuito_Final.v"

/**
* Modulo probador para el circuito final diseñado
**/
module Probador();

	/** 
	* Se declaran los wires que van a conectar cada una de las entradas
	* y salidas entre el modulo del circuito final y su testbench
	**/
	wire [11:0] L;
    wire CLK;
    wire  CLR;
    wire EN;
    wire [4:0] diaRef;
    wire [3:0] mesRef;
    wire [3:0] P;
    wire [1:0] V;
    wire [11:0] QR;

	/** 
	* Se instancian los modulos del circuito final y su testbench,
	* y se conectan sus entradas y salidas a los correspondientes wires
	**/
	Circuito_Final lector_codigos(.L(L), .CLK(CLK), .CLR(CLR), .EN(EN), .diaRef(diaRef), .mesRef(mesRef), .P(P), .V(V), .QR(QR));
	Testbench_Circuito_Final signals_generator(.L(L), .clk(CLK), .clr(CLR), .en(EN), .diaRef(diaRef), .mesRef(mesRef), .P(P), .V(V), .QR(QR));
endmodule