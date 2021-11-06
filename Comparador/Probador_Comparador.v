/** Includes 
* Se tienen que incluir los archivos del programa principal
* y el del testbench del programa donde se simula
**/ 
`include "Comparador.v"
`include "Testbench_Comparador.v"
/** 
* En el modulo del probador se declaran los cables de las entradas 
* y salidas del programa. Y se llaman los modulos del testbench 
* y el comparador y se les asignan valores.
**/ 
module Probador();
/** 
	* Se declaran los wires que van a conectar cada una de las entradas
	* y salidas entre el modulo Comparador y su testbench
**/
 
	wire [4:0] dia, diaRef;

    wire [3:0] mes, mesRef;

    wire [1:0] V;
/**
* Se instancia el modulo del comparador del archivo "Comparador.v" y
* se le asignan los valores declarados en el testbench. 
**/
Comparador comparador(.dia(dia), .diaRef(diaRef), .mes(mes), .mesRef(mesRef), .V(V));
/**
* Se llama al modulo del Testbench del archivo "Testbench_Comparador.v" y
* se le asignan los valores declarados en el testbench. 
**/
Testbench_Comparador signals_generator(.dia(dia), .diaRef(diaRef), .mes(mes), .mesRef(mesRef), .V(V));

endmodule
