/** Includes 
* Se tienen que incluir los archivos del programa principal
* y el del testbench del programa donde se simula
**/ 
`include "Registro.v"
`include "Testbench_Registro.v"
/** 
* En el modulo del probador se declaran los cables de las entradas 
* y salidas del programa. Y se llaman los modulos del testbench 
* y el registro y se les asignan valores.
**/ 
module probador ();
	/** 
	* Se declaran los wires que van a conectar cada una de las entradas
	* y salidas entre el modulo Registro y su testbench
	**/
    wire [11:0] L, QR; 
    wire CLK;
    wire CLR; 
    wire EN; 
/**
* Se instancia el modulo del registro del archivo "Registro.v" y
* se le asignan los valores declarados en el testbench. 
**/
Registro registrofinal( .L(L), .QR(QR), .CLR(CLR), .CLK(CLK), .EN(EN)  );
/**
* Se instancia el modulo del Testbench del archivo "Testbench_Registro.v" y
* se le asignan los valores declarados en el testbench. 
**/
tb_Registro signals_generator( .L(L), .Q(QR), .clr(CLR), .clk(CLK), .en(EN)  );
endmodule
