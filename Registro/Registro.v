/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
									Registro.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
        Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
        Carné: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene un modulo de Flip-Flop tipo D activado por flanco positivo con entrada de Clear, Enable y Clock. 
    Luego usando 12 veces este modulo para leer cada bit de la entrada del codigo de barras se hace un registro 
    para que lea cada bit por separado. 
	
***************************************************************************/
/**
* Registor tipo D transparente disparado por flanco creciente 
* Con reset asincronico disparado por flanco creciente y enable 
*
**/
module FF_D (
    input wire D, 
    input wire clr, 
    input wire en, 
    input wire clk,
    output reg   Q
);
 // Siempre que se encuentre un flanco positivo de la señal clk ejecuta lo que tiene dentro. 
    always@(posedge clk) 
        begin 
            // Si la entrada activada en bajo clr esta en bajo entonces transmite un valor de 0 a Q. 
            if(!clr) Q <= 0;
            /** Si no, entonces revisa la entrada de enable, 
            si esta en alto transmite el valor de entrada D a la salida Q. 
            */
            else if(en) Q <= D; 
            // Este caso es simplemente para que sea sintetizable. 
            else Q = Q;   
        end
endmodule
/** 
* Modulo de Registro llamando 12 veces al modulo de Flip Flop tipo D descrito. 
* Toma 12 bits de entrada y los transmite a una salida QR de 12 bits. 
**/ 
module Registro (
    input wire [11:0] L, 
    input wire CLK, 
    input wire  CLR,
    input wire EN, 
    output wire [11:0] QR 
);
    // Bits correspondientes al dia. 
    FF_D bit0( .D(L[0]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[0]) );
    FF_D bit1( .D(L[1]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[1]) );
    FF_D bit2( .D(L[2]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[2]) );
    FF_D bit3( .D(L[3]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[3]) );
    FF_D bit4( .D(L[4]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[4]) );
    //Bits correspondientes al mes 
    FF_D bit5( .D(L[5]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[5]) );
    FF_D bit6( .D(L[6]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[6]) );
    FF_D bit7( .D(L[7]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[7]) );
    FF_D bit8( .D(L[8]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[8]) );
    // Bits correspondientes al codigo del producto.
    FF_D bit9( .D(L[9]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[9]) );
    FF_D bit10( .D(L[10]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[10]) );
    FF_D bit11( .D(L[11]), .clr(CLR), .clk(CLK), .en(EN), .Q(QR[11]) );

endmodule
