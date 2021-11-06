/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
									Circuito_Final.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
        Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
        Carné: B51243
Fecha: 25/02/2021

Descripcion:
            Contiene instancias de modulos de otros archivos como un modulo para un Mux8x1, 
            un modulo para un registro con Flip-Flops tipo D transparente y para un     
            comparador de fechas. De modo que en este archivo se le da una entrada al registro 
            y se toman los primero 9 bits de salida del Registro como entrada del comparador y 
            lo ultimos 3 bits como entradas de seleccion del Mux8x1. Luego se le defininen
            valores a las entradas del Mux por medio de parametros. 
            Se tiene una salida P diciendo el precio del producto, y una salida V diciendo 
            Si esta vencido o no. 
	
***************************************************************************/
/**
* Se tienen que incluir los archivos del Mux8x1, del 
* Registro y del comparador ya que en este archivo se van
* a instanciar los modulos usados. 
**/ 
`include "Mux8x1.v"
`include "Comparador.v"
`include "Registro.v"

/** 
* En este modulo se definen los parametros para las litas de precio 
* segun lo establecido en el enunciado. y con estos valores se instancian 
* los modulos para el registro, el comparador y el mux8x1 para completar el lector de codigos. 
**/ 
module Circuito_Final (
/**
* Se definen las mismas entradas que se definieron en los archivos para el Mux8.1.v, el Registro.v
* y para el Comparador.v ya que se van a usar estas mismas para instanciar los modulos. 
**/ 
    input wire [11:0] L,
    input wire CLK, 
    input wire  CLR,
    input wire EN,
    input wire [4:0] diaRef,
    input wire [3:0] mesRef,
    output wire [3:0] P,
    output wire [1:0] V,
    output wire [11:0] QR
    
);
/**
* Se definen los parametros de 4 bits para cada producto segun la tabla de precios para la entrada del MUX8x1.  
**/ 
    parameter [3:0] f0 = 4'b0000;
    parameter [3:0] f1 = 4'b0000;
    parameter [3:0] f2 = 4'b1111;
    parameter [3:0] f3 = 4'b0001;
    parameter [3:0] f4 = 4'b1000;
    parameter [3:0] f5 = 4'b1010;
    parameter [3:0] f6 = 4'b0100;
    parameter [3:0] f7 = 4'b0000;
    
// Se define un parametro e que contiene los 8 parametros de 4 bits definidos para las entradas del MUX8x1.
    parameter [31:0] e = {f0, f1, f2, f3, f4, f5, f6, f7};

    /** 
    * Se instancia el modulo Registro del archivo Registro.v y se le asignan valores. 
    **/ 
    Registro Reg( .L(L), .CLK(CLK), .CLR(CLR), .EN(EN), .QR(QR) );
    /** 
    * Se instancia el modulo Comparador del archivo Comparador.v y se le asignan valores. 
    * Se puede observar que se le asignan los primero 5 bits de la salida del Registro al dia, 
    * los siguientes 4 bits al mes. 
    **/ 
    Comparador Comp( .dia(QR[11:7]), .mes(QR[6:3]), .diaRef(diaRef), .mesRef(mesRef), .V(V) );
    /** 
    * Se instancia el modulo Mux8x1 del archivo Mux8x1.v y se le asignan valores. Se puede observare 
    * que se le asignan los ultimos 3 bits de la salida del registro a las entradas de seleccion S 
    * del Mux8x1. 
    **/ 
    Mux8x1 Mux( .I(e), .S(QR[2:0]), .Q(P) );
endmodule
