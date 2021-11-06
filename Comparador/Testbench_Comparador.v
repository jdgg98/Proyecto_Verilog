/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
								Testbench_Comparador.v
								
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
        Carne: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
        Carne: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene testbench para el modulo del Comparador de Fechas. 
	El cual hace al modulo del comparador pasar por ciertas pruebas 
	para comprobar su funcionamiento.
	
***************************************************************************/
/** Se define una esacala de tiempo para definir lo que cada #1
 significa a la hora de simular el programa de la siguiente manera: 
 <Unidad de tiempo>/<Precision> 
 **/ 
`timescale 1ns/1ns
/** 
* El siguiente modulo es el modulo principal del testbench en el cual se 
* le aplican las pruebas pertinentes al modulo Comparador. 
 **/ 
module Testbench_Comparador(
	/** 
	* Tiene como salidas las entradas del modulo comparador. 
	* el dia y mes que entran del modulo registro y los de referencia. 
	**/ 
	output reg [4:0] dia, diaRef,
	output reg [3:0] mes, mesRef,
	/**
	*  Tiene como entradas las salidas del modulo comparador. 
	* la salida V del modulo comparador diciendo si el producto es 
	* vigente, vencido o no valido. 
	**/ 
	input wire [1:0] V);	
	
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
			$dumpfile("Comparador.vcd");
			/** 
			* Se usa dumpvars para especificar cuales variables se van a guardar 
			* en el archivo dump, como se declara sin argumento, se guardan todas.
			**/ 
			$dumpvars;

			/** 
			* Pruebas para el testbench del Comparador de Fechas. 
			**/ 

			//Prueba 1 - Todos los bits en 1
			#1
			dia = 5'b11111;
			mes = 4'b1111;
			diaRef = 5'b10110; 
			mesRef = 4'b0010;

			//Prueba 2 - Todos los bits en 0
			#1
			dia = 5'b00000;
			mes = 4'b0000;
			diaRef = 5'b10110; 
			mesRef = 4'b0010; 

			//Prueba 3- Una fecha invalida - 30 de febrero
			#1
			dia = 5'b11110;
			mes = 4'b0010;
			diaRef = 5'b10110; 
			mesRef = 4'b0010;

			//Prueba 4 - Una fecha invalida - 31 de junio
			#1
			dia = 5'b11111;
			mes = 4'b0110;
			diaRef = 5'b10110; 
			mesRef = 4'b0010;

			//Prueba 5 - Una fecha invalida - 5 del mes 14
			#1
			dia = 5'b00101;
			mes = 4'b1110;
			diaRef = 5'b10110; 
			mesRef = 4'b0010;

			//Prueba 6 - Una fecha invalida - 17 del mes 15
			#1
			dia = 5'b10001;
			mes = 4'b1111;
			diaRef = 5'b10110; 
			mesRef = 4'b0010;

			//Prueba 7 - Una fecha valida - 22 de febrero
			#1
			dia = 5'b10110;
			mes = 4'b0010;
			// fecha de referencia igual, vencido - 22 de febrero 
			diaRef = 5'b10110; 
			mesRef = 4'b0010;

			//Prueba 8 - Una fecha valida - 1 de enero
			#1
			dia = 5'b00001;
			mes = 4'b0001;
			// fecha de referencia, vencido -  16 de enero
			diaRef = 5'b10000; 
			mesRef = 4'b0001;

			//Prueba 9 - Una fecha valida - 14 de abril
			#1
			dia = 5'b01110;
			mes = 4'b0100;
			// Fecha de referencia vigente -  16 de enero
			diaRef = 5'b10000; 
			mesRef = 4'b0001;

			//Prueba 10 - Una fecha valida - 23 de febrero
			#1
			dia = 5'b10111;
			mes = 4'b0010;
			// Fecha de referencia vencida - 27 de julio
			diaRef = 5'b11011; 
			mesRef = 4'b0111;
			// Se termina la simulacion. 
			#1 $finish;
		end
endmodule
