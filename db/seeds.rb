# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




#Create all the categories.

categories = Category.create([{ name: 'RAZONAMIENTO MATEMÁTICO' }, { name: 'RAZONAMIENTO VERBAL' }, { name: 'RAZONAMIENTO ABSTRACTO' }])


#Create all the subcategories

subcategories = SubCategory.create([
									#Matematica
									{ name: 'Operaciones Básicas', category_id: '1' },
									{ name: 'Potenciación y Radicación', category_id: '1'  },
									{ name: 'Razones y Proporciones', category_id: '1'  },
									{ name: 'Reglas de Tres', category_id: '1'  },
									{ name: 'Ecuaciones', category_id: '1'  },
									{ name: 'Porcentajes', category_id: '1'  },
									{ name: 'Geometría', category_id: '1'  },
									{ name: 'Probabilidad, Combinación y Variación', category_id: '1'  },
									# Verbal
									{ name: 'Hiperónimos', category_id: '2'  },
									{ name: 'Hipónimos', category_id: '2'  },
									{ name: 'Sinónimos', category_id: '2'  },
									{ name: 'Antónimos', category_id: '2'  },
									{ name: 'Presición Semántica', category_id: '2'  },
									{ name: 'Interpretación de refranes', category_id: '2'  },
									{ name: 'Analogías Verbales', category_id: '2'  },
									{ name: 'Comprensión de Lectura', category_id: '2'  },
									{ name: 'Término excluido', category_id: '2'  },
									#Abstracto
									{ name: 'Analogías entre figuras', category_id: '3'  },
									{ name: 'Relación entre figuras', category_id: '3'  },
									{ name: 'Secuencias gráficas horizontales', category_id: '3'  },
									{ name: 'Matrices gráficas horizontales', category_id: '3'  },
									{ name: 'Figuras excluidas', category_id: '3'  },
									{ name: 'Matrices de superposición', category_id: '3'  },
									{ name: 'Matrices gráficas', category_id: '3'  },
									{ name: 'Matrices lógicas', category_id: '3'  },
									{ name: 'Giros de figuras', category_id: '3'  },
									{ name: 'Vistas de cuerpos', category_id: '3'  },
									{ name: 'Figuras 3D', category_id: '3'  },
									{ name: 'Rompecabezas', category_id: '3'  }
									])

################################ Create Questiones #######################

### COUNTERS ####

math_1_counter = 1
math_2_counter = 1
math_3_counter = 1
math_4_counter = 1
math_5_counter = 1
math_6_counter = 1
math_7_counter = 1
math_8_counter = 1

##################

finder_start =  1
finder_end =  5

1.times do
	# Operaciones Básicas
	(1..30).each do |y|

		Question.create( content: 'Pregunta de prueba Operaciones Básicas ' + math_1_counter.to_s  , sub_category_id: 1, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4

		math_1_counter = math_1_counter + 1
	end
	#Potenciación y Radicación
	(31..60).each do |y|

		Question.create( content: 'Pregunta de prueba #Potenciación y Radicación ' + math_2_counter.to_s , sub_category_id: 2, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_2_counter = math_2_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	# Razones y Proporciones
	(61..90).each do |y|

		Question.create( content: 'Pregunta de prueba Razones y Proporciones ' + math_3_counter.to_s , sub_category_id: 3, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_3_counter = math_3_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Reglas de Tres
	(91..120).each do |y|

		Question.create( content: 'Pregunta de prueba Reglas de Tres ' + math_4_counter.to_s , sub_category_id: 4, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_4_counter = math_4_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Ecuaciones
	(121..150).each do |y|

		Question.create( content: 'Pregunta de prueba Ecuaciones ' + math_5_counter.to_s , sub_category_id: 5, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_5_counter = math_5_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Porcentajes
	(151..180).each do |y|

		Question.create( content: 'Pregunta de prueba Porcentajes ' + math_6_counter.to_s  , sub_category_id: 6, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_6_counter = math_6_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Geometría
	(181..210).each do |y|

		Question.create( content: 'Pregunta de prueba Geometría ' + math_7_counter.to_s  , sub_category_id: 7, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_7_counter = math_7_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Probabilidad, Combinación y Variación
	(211..240).each do |y|

		Question.create( content: 'Pregunta de prueba Probabilidad, Combinación y Variación ' + math_8_counter.to_s, sub_category_id: 8, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		math_8_counter = math_8_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end


end


################### VERBAL ############################

### COUNTERS ####

verb_1_counter = 1
verb_2_counter = 1
verb_3_counter = 1
verb_4_counter = 1
verb_5_counter = 1
verb_6_counter = 1
verb_7_counter = 1
verb_8_counter = 1
verb_9_counter = 1

##################


1.times do
	# Hiperónimos
	(241..270).each do |y|

		Question.create( content: 'Pregunta de prueba Hiperónimos ' + verb_1_counter.to_s  , sub_category_id: 9, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_1_counter= verb_1_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4

	end
	#Hipónimos
	(271..300).each do |y|

		Question.create( content: 'Pregunta de prueba Hipónimos ' + verb_2_counter.to_s , sub_category_id: 10, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_2_counter = verb_2_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	# Sinónimos
	(301..330).each do |y|

		Question.create( content: 'Pregunta de prueba Sinónimos ' + verb_3_counter.to_s , sub_category_id: 11, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_3_counter = verb_3_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Antónimos
	(331..360).each do |y|

		Question.create( content: 'Pregunta de prueba Antónimos ' + verb_4_counter.to_s , sub_category_id: 12, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_4_counter = verb_4_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Presición Semántica
	(361..390).each do |y|

		Question.create( content: 'Pregunta de prueba Presición Semántica ' + verb_5_counter.to_s , sub_category_id: 13, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_5_counter = verb_5_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Interpretación de refranes
	(391..420).each do |y|

		Question.create( content: 'Pregunta de prueba Interpretación de refranes ' + verb_6_counter.to_s  , sub_category_id: 14, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_6_counter = verb_6_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Analogías Verbales
	(421..450).each do |y|

		Question.create( content: 'Pregunta de prueba Analogías Verbales ' + verb_7_counter.to_s  , sub_category_id: 15, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_7_counter = verb_7_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Comprensión de Lectura
	(451..480).each do |y|

		Question.create( content: 'Pregunta de prueba Comprensión de Lectura ' + verb_8_counter.to_s, sub_category_id: 16, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_8_counter = verb_8_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Término excluido
	(481..510).each do |y|

		Question.create( content: 'Pregunta de prueba Término excluido ' + verb_9_counter.to_s, sub_category_id: 17, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		verb_9_counter = verb_9_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

end


################### Abstracto ############################

### COUNTERS ####

abs_1_counter = 1
abs_2_counter = 1
abs_3_counter = 1
abs_4_counter = 1
abs_5_counter = 1
abs_6_counter = 1
abs_7_counter = 1
abs_8_counter = 1
abs_9_counter = 1
abs_10_counter = 1
abs_11_counter = 1

##################



1.times do

	# Analogías entre figuras
	(511..540).each do |y|

		Question.create( content: 'Pregunta de prueba Analogías entre figuras ' + abs_1_counter.to_s  , sub_category_id: 18, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_1_counter = abs_1_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4

	end
	# Relación entre figuras
	(541..570).each do |y|

		Question.create( content: 'Pregunta de prueba Relación entre figuras ' + abs_1_counter.to_s  , sub_category_id: 19, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_1_counter = abs_1_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4

	end
	#Secuencias gráficas horizontales
	(571..600).each do |y|

		Question.create( content: 'Pregunta de prueba Secuencias gráficas horizontales ' + abs_2_counter.to_s , sub_category_id: 20, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_2_counter = abs_2_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	# Gráficas horizontales
	(601..630).each do |y|

		Question.create( content: 'Pregunta de prueba Matrices gráficas horizontales ' + abs_3_counter.to_s , sub_category_id: 21, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_3_counter = abs_3_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Figuras excluidas
	(631..660).each do |y|

		Question.create( content: 'Pregunta de prueba Figuras excluidas ' + abs_4_counter.to_s , sub_category_id: 22, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_4_counter = abs_4_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Matrices de superposición
	(661..690).each do |y|

		Question.create( content: 'Pregunta de prueba Matrices de superposición ' + abs_5_counter.to_s , sub_category_id: 23, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_5_counter = abs_5_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Matrices gráficas
	(691..720).each do |y|

		Question.create( content: 'Pregunta de prueba Matrices gráficas ' + abs_6_counter.to_s  , sub_category_id: 24, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_6_counter = abs_6_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Matrices lógicas
	(721..750).each do |y|

		Question.create( content: 'Pregunta de prueba Matrices lógicas ' + abs_7_counter.to_s  , sub_category_id: 25, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_7_counter = abs_7_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Giros de figuras
	(751..780).each do |y|

		Question.create( content: 'Pregunta de prueba Giros de figuras ' + abs_8_counter.to_s, sub_category_id: 26, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end

		abs_8_counter= abs_8_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Vistas de cuerpos
	(781..810).each do |y|

		Question.create( content: 'Pregunta de prueba Vistas de cuerpos ' + abs_9_counter.to_s, sub_category_id: 27, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_9_counter = abs_9_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Figuras 3D
	(811..840).each do |y|

		Question.create( content: 'Pregunta de prueba Figuras 3D ' + abs_10_counter.to_s, sub_category_id: 28, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_10_counter = abs_10_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

	#Rompecabezas
	(841..1000).each do |y|

		Question.create( content: 'Pregunta de prueba Rompecabezas ' + abs_11_counter.to_s, sub_category_id: 29, explanation: "Explicacion" )

		(1..4).each do |z|
			Choice.create(content: 'Opcion' + z.to_s, question_id: (y))
		end
		abs_11_counter = abs_11_counter + 1

		q = Question.find_by_id(y)
		q.choice_id = Random.rand(finder_start..finder_end)
		q.save!
		finder_start = finder_start + 4
		finder_end = finder_end + 4
	end

end
##################V2###########################################
enes = Course.create! name: 'ENES', description: 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.'
enes2 = Course.create! name: 'ENES 2', description: 'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen.'
courses = [enes, enes2]
courses.each do |c|
	(1..5).each do |s|
		section = Section.create! name: "section #{s}", course_id: c.id

		blog = Blog.create! title: "blog #{s}", content: '<h2><span class="mw-headline" id="Controversia">Controversia</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Wiki&amp;action=edit&amp;section=3" title="Editar sección: Controversia">editar</a><span class="mw-editsection-bracket">]</span></span></h2><p>Lo más importante se describe como la posibilidad de introducir adendos y modificaciones carentes de autenticidad y rigor siempre y cuando sea una wiki que haya sido configurada para permitir a cualquier usuario editar contenido, ya que su amplio sistema de extensiones y configuración permite que se impongan todo tipo de restricciones a los usuarios o a los artículos. En una wiki que se permita editar a cualquier persona, se podrá intervenir sin que su información o comentarios estén suficientemente contrastados, lo cual no sería un inconveniente directo del sistema wiki, sino de la decisión del propietario o administrador respecto a quién puede editar el contenido. Debido a ello, en las wikis donde se permite editar a todas las personas, se toman las medidas más adecuadas al alcance de los mecanismos editoriales con objeto de optimizar la fiabilidad de las informaciones introducidas.</p><h2><span class="mw-headline" id="Caracter.C3.ADsticas">Características</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Wiki&amp;action=edit&amp;section=4" title="Editar sección: Características">editar</a><span class="mw-editsection-bracket">]</span></span></h2><p>Según su creador una wiki es “la base de datos en línea más simple que pueda funcionar". Se trata de un tipo de página web que brinda la posibilidad de que multitud de usuarios puedan editar sus contenidos a través del navegador web, con ciertas restricciones mínimas. De esta forma permite que múltiples autores puedan crear, modificar o eliminar los contenidos. Se puede identificar a cada usuario que realiza un cambio y recuperar los contenidos modificados, volviendo a un estado anterior. Estas características facilitan el trabajo en colaboración así como la coordinación de acciones e intercambio de información sin necesidad de estar presentes físicamente ni conectados de forma simultánea. El ejemplo más conocido y de mayor tamaño de este tipo de páginas web es la enciclopedia colaborativa <a href="/wiki/Wikipedia" title="Wikipedia">Wikipedia</a> (www.wikipedia.org). A favor: Es una fuente de información y bibliográfica de construcción colectiva. Problemas: La información publicada puede provenir de fuentes erróneas o no válidas. Solución/recomendaciones: Es recomendable trabajar criterios sobre el empleo de fuentes de información confiables y formas de validar los contenidos.<sup id="cite_ref-5" class="reference"><a href="#cite_note-5"><span class="corchete-llamada">[</span>4<span class="corchete-llamada">]</span></a></sup></p><p>Un wiki permite que se escriban artículos colectivamente (co-autoría) por medio de un lenguaje de <a href="/wiki/Wikitexto" title="Wikitexto">wikitexto</a> editado mediante un <a href="/wiki/Navegador_web" title="Navegador web">navegador</a>. Una página wiki singular es llamada «página wiki», mientras que el conjunto de páginas (normalmente interconectadas mediante <a href="/wiki/Hiperenlace" title="Hiperenlace">hipervínculos</a>) es «el wiki». Es mucho más sencillo y fácil de usar que una <a href="/wiki/Base_de_datos" title="Base de datos">base de datos</a>.</p><p>Una característica que define la tecnología wiki es la facilidad con que las páginas pueden ser creadas y actualizadas. En general no hace falta revisión para que los cambios sean aceptados. La mayoría de wikis están abiertos al público sin la necesidad de registrar una cuenta de usuario. A veces se requiere hacer login para obtener una cookie de «wiki-firma», para autofirmar las ediciones propias. Otros wikis más privados requieren autenticación de usuario.</p><h3><span class="mw-headline" id="Perspectivas_pedag.C3.B3gicas_de_Wiki">Perspectivas pedagógicas de Wiki</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Wiki&amp;action=edit&amp;section=5" title="Editar sección: Perspectivas pedagógicas de Wiki">editar</a><span class="mw-editsection-bracket">]</span></span></h3><p>Por lo explicado, las Wiki son una muy buena opción <a href="/wiki/Pedagog%C3%ADa" title="Pedagogía">pedagógica</a> para realizar actividades educativas, ya que como explica Mariana Maggio, se pueden generar propuestas que los alumnos puedan integrar en las Wiki a partir de la reconstrucción de las mismas en un sentido didáctico. En la actualidad los documentos <a href="/wiki/World_Wide_Web" title="World Wide Web">Web</a>, como lo es el ejemplo de las Wiki, crean tendencias y cuando éstas configuran los usos de los niños y los jóvenes, es importante que los educadores las reconozcan y se preocupen por entenderlas a partir de su exploración.</p><p>Para Maggio, «un proyecto <a href="/wiki/Did%C3%A1ctica" title="Didáctica">didáctico</a> maravilloso puede ser, cuando el tema lo justifique, generar contenidos para Wikipedia o revisar los publicados allí: entender el tema de un modo profundo, verificar los contenidos, transparentar y discutir los criterios, ampliar lo publicado, ofrecer versiones y especificaciones de alto valor local».<sup id="cite_ref-6" class="reference"><a href="#cite_note-6"><span class="corchete-llamada">[</span>5<span class="corchete-llamada">]</span></a></sup></p><p>Un wiki también puede ser un espacio usado para seguimiento individual de los alumnos, donde ellos puedan crear sus proyectos independientemente y el profesor pueda intervenir guiando y corrigiendo. Se ha utilizado también en procesos de formación docente ayudando al mejoramiento de sus habilidades tecnológicas, pero también los procesos de colaboración entre pares <sup id="cite_ref-7" class="reference"><a href="#cite_note-7"><span class="corchete-llamada">[</span>6<span class="corchete-llamada">]</span></a></sup> . Permite la creación colectiva de documentos en un lenguaje simple de marcas utilizando un navegador web. Generalmente no se hacen revisiones previas antes de aceptar las modificaciones y la mayoría de los wikis están abiertas. Permite a los participantes trabajar juntos en páginas web, para añadir o modificar su contenido. Las versiones antiguas nunca se eliminan y pueden restaurarse. Se puede seleccionar diferentes tipos de wiki, profesor, grupo, alumno.</p><h3><span class="mw-headline" id="P.C3.A1ginas_y_edici.C3.B3n">Páginas y edición</span><span class="mw-editsection"><span class="mw-editsection-bracket">[</span><a href="/w/index.php?title=Wiki&amp;action=edit&amp;section=6" title="Editar sección: Páginas y edición">editar</a><span class="mw-editsection-bracket">]</span></span></h3><p>En un wiki tradicional existen tres representaciones por cada página:</p><ul><li>El «<a href="/wiki/C%C3%B3digo_fuente" title="Código fuente">código fuente</a>»,que pueden editar los usuarios. Es el formato almacenado localmente en el servidor. Normalmente es texto plano, sólo es visible para el usuario cuando lo muestra la operación «Editar».</li><li>Una plantilla (en ocasiones generada internamente) que define la disposición y elementos comunes de todas las páginas.</li><li>El código <a href="/wiki/HTML" title="HTML">HTML</a>, puesto en tiempo real por el servidor a partir del código fuente cada vez que la página se solicita.</li></ul>'
		video = Video.create! name: "Video explicativo #{s}", description: 'test', url: "https://www.youtube.com/embed/jdYJf_ybyVo"
		task = Task.create! title: "Tarea #{s}", description: 'Descripción de la tarea'
		
		rnumber = Random.rand(5..10)
		rnumber.times do |i|
			question = Question.find_by_id(Random.rand(1...1000))
			question.update_attribute(:parent, task)
		end

		resource = Resource.new generic_name: "Recurso de video #{s}" , section_id: section.id
		resource.material = video
		resource.save

		resource = Resource.new generic_name: "Recurso de blog #{s}" , section_id: section.id
		resource.material = blog
		resource.save

		resource = Resource.new generic_name: "Recurso de Tarea #{s}" , section_id: section.id
		resource.material = task
		resource.save
  end
end

test = Test.create! title: 'first test', description: 'description test', time_limit: 60,  total_questions: 10, course_id: enes.id
puts test.title
(1..10).each do |n|
  q = Question.create( content: 'Pregunta de examen' + n.to_s, sub_category_id: 29, explanation: "Explicacion" )
  choices = []
  (1..4).each do |z|
    c = Choice.create content: 'Opcion' + z.to_s, question_id: q.id
    choices << c
  end
  question = Question.find_by_id(q.id)
  question.choice_id = choices.map(&:id).sample
  question.save!
  test.questions << question
  test.save
end
