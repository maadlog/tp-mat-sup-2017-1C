pkg load control;
run("./PF.m");

function ret_var = getGFromPQ()
	disp("Ingrese con el formato requerido [a1,a2,..,an]\n");
	numerador = input("Coeficientes del polinomio Numerador > ");
	denominador = input("Coeficientes del polinomio Denominador > ");
	ret_var = tf(numerador,denominador);
endfunction

function ret_var = getGfromPZK()
  disp("Ingrese con el formato requerido [a1,a2,..,an]\n");
	ceros = input("Ceros > ");
	polos = input("Polos > ")  ;
  disp("Ingrese un valor unico k\n")  ;
	ganancia = input("Ganancia > ");
	ret_var = zpk(ceros,polos,ganancia);
endfunction

function ret_var = promptG()

	opt = menu ("Seleccione la forma en la que se proveerá el Sistema de Control que desea Analizar\n",
		"Coeficientes de polinomios",
		"Ceros, Polos y Ganancia");

	if (opt == 1)
		ret_var=getGFromPQ();
	else
	  	ret_var=getGfromPZK();
	endif

endfunction

function k = gain(tf)
	[_,_,k] = zpkdata(tf);
endfunction

function determineStability(tf)
	if (isstable(tf))
		display("El sistema es estable");
	else
		display("El sistema es inestable");
	endif
endfunction


G = promptG();

while(true)

	opt = menu ("Indique la operación a realizar\n",

		"Expresar la función transferencia.",
		"Indicar Polos.",
		"Indicar Ceros.",
		"Indicar Ganancia.",
		"Obtener expresión con polos, ceros y ganancia.",
		"Constelación de polos y ceros.",
		"Estabilidad del sistema.",
		"Obtener todas las características de la función transferencia",
		"Ingresar una nueva función",
		"Finalizar"
	);

	if (opt == 8)
		range = 1:7; #"Obtener todas las características de la función transferencia"
	else
		range = opt:opt;
	endif

	for i = range
		switch (i)
			case 1 #"Expresar la función transferencia."
				G = tf(G)
			case 2 #"Indicar Polos."
				Polos = pole(G)
			case 3 #"Indicar Ceros."
				Ceros = zero(G)
			case 4 #"Indicar Ganancia."
				Ganancia = gain(G)
			case 5 #"Obtener expresión con polos, ceros y ganancia."
				G = zpk(G)
			case 6 #"Constelación de polos y ceros."
				pzmap(G);
			case 7 #"Estabilidad del sistema."
				determineStability(G);
			case 9 #"Ingresar una nueva función"
				G = promptG();
			otherwise #"Finalizar"
				quit;
		endswitch
	endfor

endwhile
