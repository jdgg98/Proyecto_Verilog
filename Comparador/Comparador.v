/* *************************************************************************
								Proyecto de Verilog
							Universidad de Costa Rica
						Escuela de Ingenieria Electrica
						IE-0323: Circuitos Digitales I 
							
								    Comparador.v
								 
Autores: Jafet David Gutierrez Guevara <jafet.gutierrez@ucr.ac.cr>
        Carné: B73558
		 Pablo Daniel Brenes Segura <pablo.brenessegura@ucr.ac.cr>
        Carné: B51243
Fecha: 25/02/2021

Descripcion:
	Contiene el modulo de un Comparador de Fechas, que recibe la fecha de 
    caducidad de un producto y basado en una fecha de referencia indica
    si el producto esta vencido, vigente o si la fecha recibida es invalida
    ya que los valores de entrada pueden dar fechas que no existen en el año 2021.
	
***************************************************************************/
/** Modulo de comparador en el cual se evaluan los casos invalidos de las fechas cada uno 
* por separado y se le asigna un valor de V de 00 en caso de que sea invalido 
* Despues se evaluan los casos validos y se comparan con la fecha de referenica
* para ver si el producto esta vencido o no. 
**/ 
module Comparador(
    // Se crea un un cable de entrada de 5 bits para el dia que se lee y el dia de referencia. 
    input wire [4:0] dia, diaRef,
    // Se crea un un cable de entrada de 4 bits para el mes que se lee y el mes de referencia. 
    input wire [3:0] mes, mesRef,
    /** Se tiene una salida tipo registro  de 2 bits ya que guarda la
    * informacion de si la fecha es invalida, vencida o vigente. 
    **/ 
    output reg [1:0] V);

    /** 
    * Se inicial un bloque always el cual ejecuta su contenido cada vez que hay un cambio
    * para esto es el asterisco '*' que se encuentra dentro de los parentesis. 
    **/ 
    always @(*) begin
        /** 
        * Se inicia un casez evaluando el mes y el dia que entran desde el registro. 
        * Se usa un casez debido a que se pueden ignorar algunos de los bits en algunos de los casos. 
        **/ 
        casez ({mes, dia})

        /**
        * Se verifican los casos en los que si el mes es febrero, 
        * no hayan dias 29, 30 ni 31. 
        **/ 
            9'b001011101: V <= 0;
            9'b00101111?: V <= 0;

        // Se verifica el caso en el que el mes sea cero.  
            9'b0000?????: V <= 0; 

        // Se verifica el caso en el que el dia sea cero.
            9'b????00000: V <= 0;
        /**
        * Se verifican los casos de los meses que no tienen 31 dias.
        * Por lo que hay que descartar los dias 31 de 4 meses.  
        **/ 
        //Caso en el que el mes no tenga 31 dias 
            9'b010011111: V <= 0;
            9'b011011111: V <= 0;
            9'b100111111: V <= 0;
            9'b101111111: V <= 0;

        /**
        * ya que se usan 4 bits para describir los meses, se tiene que 
        * Descartar los meses del 13 al 15 que no existen.
        **/ 
             9'b1101?????: V <= 0;
             9'b1110?????: V <= 0;
             9'b1111?????: V <= 0;

            // Se establece un caso default en caso de que ninguno de los casos anteriores se haya cumplido. 
            default: 
            // Se usa un bloque begin/end para inlcuir un if dentro. 
            begin
                /**
                * Con un if se comparan el dia y el mes de referencia 
                * con el dia y el mes que entran al modulo. 
                * Tal que si se cumple que el mes de referenia es mayor que el mes
                * del producto entonces se le asigna un valor de 01 a V (vencido). 
                * O si el mes de refencia es igual al mes de entrada pero el dia de refencia es mayor o igual. 
                * En caso de que no se cumpla ninguna de estas dos condiciones entonces se le asigna un valor de 
                * 10 a V (vigente). 
                **/ 
                if( (mes < mesRef) | (mes == mesRef) & (dia <= diaRef) ) V = 01; 
                else V = 10; 
            end
        endcase
    end
endmodule
