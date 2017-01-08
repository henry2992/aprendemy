puts "Espere un momento ..."

# Create Test Vocacional
tv = Test.create! title: 'Test Vocacional', description: 'Test Vocacional', test_type: 1

# Create Choices for Test Vocacional's questions
choice1 = { "id": nil, "content":"Me interesa", "value_count":1 }
choice2 = { "id": nil, "content":"No me interesa" }

# Create Test Vocacional's questions
q = Question.create! "content": "Diseñar programas de computación y explorar nuevas aplicaciones tecnológicas para uso del internet.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Criar, cuidar y tratar animales domésticos y de campo", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Investigar sobre áreas verdes, medio ambiente y cambios climáticos", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Ilustrar, dibujar y animar digitalmente.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Seleccionar, capacitar y motivar al personal de una organización/empresa", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Realizar excavaciones para descubrir restos del pasado", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Resolver problemas de cálculo para construir un puente.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar cursos para enseñar a la gente sobre temas de salud e higiene", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Tocar un instrumento y componer música", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Planificar cuáles son las metas de una organización pública o privada a mediano y largo plazo.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar y planificar la producción masiva de artículos como muebles, autos, equipos de oficina, empaques y envases para alimentos y otros.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar logotipos y portadas de una revista", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Organizar eventos y atender a sus asistentes.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Atender la salud de personas enfermas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Controlar ingresos y egresos de fondos y presentar el balance final de una institución.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Hacer experimentos con plantas (frutas, árboles, flores)", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Concebir planos para viviendas, edificios y ciudadelas", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Investigar y probar nuevos productos farmacéuticos", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Hacer propuestas y formular estrategias para aprovechar las relaciones económicas entre dos países.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Pintar, hacer esculturas, ilustrar libros de arte, etcétera.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Elaborar campañas para introducir un nuevo producto al mercado.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Examinar y tratar los problemas visuales", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Defender a clientes individuales o empresas en juicios de diferente naturaleza.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar máquinas que puedan simular actividades humanas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Investigar las causas y efectos de los trastornos emocionales", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Supervisar las ventas de un centro comercial", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Atender y realizar ejercicios a personas que tienen limitaciones físicas, problemas de lenguaje, etcétera.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Prepararse para ser modelo profesional.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Aconsejar a las personas sobre planes de ahorro e inversiones.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Elaborar mapas, planos e imágenes para el estudio y análisis de datos geográficos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar juegos interactivos electrónicos para computadora.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Realizar el control de calidad de los alimentos", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Tener un negocio propio de tipo comercial.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Escribir artículos periodísticos, cuentos, novelas y otros", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Redactar guiones y libretos para un programa de televisión", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Organizar un plan de distribución y venta de un gran almacén", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Estudiar la diversidad cultural en el ámbito rural y urbano ", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Gestionar y evaluar convenios internacionales de cooperación para el desarrollo social.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Crear campañas publicitarias", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Trabajar investigando la reproducción de peces, camarones y otros animales marinos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Dedicarse a fabricar productos alimenticios de consumo masivo", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Gestionar y evaluar proyectos de desarrollo en una institución educativa y/o fundación.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Rediseñar y decorar espacios físicos en viviendas, oficinas y locales comerciales", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Administrar una empresa de turismo y/o agencias de viaje.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Aplicar métodos alternativos a la medicina tradicional para atender personas con dolencias de diversa índole.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar ropa para niños, jóvenes y adultos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Investigar organismos vivos para elaborar vacunas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Manejar y/o dar mantenimiento a dispositivos/aparatos tecnológicos en aviones, barcos, radares, etcétera.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Estudiar idiomas extranjeros –actuales y antiguos- para hacer traducción.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Restaurar piezas y obras de arte", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Revisar y dar mantenimiento a artefactos eléctricos, electrónicos y computadoras", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Enseñar a niños de 0 a 5 años", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Investigar y/o sondear nuevos mercados.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Atender la salud dental de las personas", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Tratar a niños, jóvenes y adultos con problemas psicológicos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Crear estrategias de promoción y venta de nuevos productos ecuatorianos en el mercado internacional.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Planificar y recomendar dietas para personas diabéticas y/o con sobrepeso.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Trabajar en una empresa petrolera en un cargo técnico como control de la producción.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Administrar una empresa (familiar, privada o pública)", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Tener un taller de reparación y mantenimiento de carros, tractores, etcétera.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Ejecutar proyectos de extracción minera y metalúrgica.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Asistir a directivos de multinacionales con manejo de varios idiomas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar programas educativos para niños con discapacidad", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Aplicar conocimientos de estadística en investigaciones en diversas áreas (social, administrativa, salud, etcétera.)", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Fotografiar hechos históricos, lugares significativos, rostros, paisajes para el área publicitaria, artística, periodística y social", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Trabajar en museos y bibliotecas nacionales e internacionales.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Ser parte de un grupo de teatro.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Producir cortometrajes, spots publicitarios, programas educativos, de ficción, etcétera.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Estudiar la influencia entre las corrientes marinas y el clima y sus consecuencias ecológicas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Conocer las distintas religiones, su filosofía y transmitirlas a la comunidad en general", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Asesorar a inversionistas en la compra de bienes/acciones en mercados nacionales e internacionales.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Estudiar grupos étnicos, sus costumbres, tradiciones, cultura y compartir sus vivencias.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Explorar el espacio sideral, los planetas, características y componentes.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Mejorar la imagen facial y corporal de las personas aplicando diferentes técnicas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Decorar jardines de casas y parques públicos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Administrar y renovar menúes de comidas en un hotel o restaurante.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Trabajar como presentador de televisión, locutor de radio y televisión, animador de programas culturales y concursos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Diseñar y ejecutar programas de turismo.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Administrar y ordenar (planificar) adecuadamente la ocupación del espacio físico de ciudades, países etc., utilizando imágenes de satélite, mapas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Organizar, planificar y administrar centros educativos", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": tv, "area": 3
q.choices.create! [ choice1, choice2 ]

ti = Test.create! title: 'Test de Inteligencias múltiples', description: 'Test de Inteligencias multiples', test_type: 1

# Create Choices for Test de Inteligencias's questions
choice1 = { "id": nil, "content":"Sí", "value_count":1 }
choice2 = { "id": nil, "content":"No" }

# Create Test de Inteligencias's questions
q = Question.create! "content": "Prefiero hacer un mapa que explicarle a alguien como tiene que llegar.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Si estoy enojado(a) o contento (a) generalmente sé exactamente por qué.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 6
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Sé tocar (o antes sabía tocar) un instrumento musical.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Asocio la música con mis estados de ánimo.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Puedo sumar o multiplicar mentalmente con mucha rapidez", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Puedo ayudar a un amigo a manejar sus sentimientos porque yo lo pude hacer antes en relación a sentimientos parecidos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 6
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta trabajar con calculadoras y computadores.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Aprendo rápido a bailar un ritmo nuevo.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "No me es difícil decir lo que pienso en el curso de una discusión o debate.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Disfruto de una buena charla, discurso o sermón.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Siempre distingo el norte del sur, esté donde esté.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta reunir grupos de personas en una fiesta o en un evento especial.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 7
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "La vida me parece vacía sin música.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Siempre entiendo los gráficos que vienen en las instrucciones de equipos o instrumentos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta hacer rompecabezas y entretenerme con juegos electrónicos", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me fue fácil aprender a andar en bicicleta(o patines)", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me enojo cuando oigo una discusión o una afirmación que parece ilógica.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Soy capaz de convencer a otros que sigan mis planes.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 7
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Tengo buen sentido de equilibrio y coordinación.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Con frecuencia veo configuraciones y relaciones entre números con más rapidez y facilidad que otros.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta construir modelos ( o hacer esculturas)", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Tengo agudeza para encontrar el significado de las palabras.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Puedo mirar un objeto de una manera y con la misma facilidad verlo.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Con frecuencia hago la conexión entre una pieza de música y algún evento de mi vida.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta trabajar con números y figuras", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 2
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta sentarme silenciosamente y reflexionar sobre mis sentimientos íntimos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 6
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Con sólo mirar la forma de construcciones y estructuras me siento a gusto.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 3
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta tararear, silbar y cantar en la ducha o cuando estoy sola.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 5
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Soy bueno(a) para el atletismo.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 4
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me gusta escribir cartas detalladas a mis amigos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 1
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Generalmente me doy cuenta de la expresión que tengo en la cara ", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 6
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me doy cuenta de las expresiones en la cara de otras personas.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 7
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me mantengo 'en contacto' con mis estados de ánimo. No me cuesta identificarlos.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 6
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me doy cuenta de los estados de ánimo de otros.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 7
q.choices.create! [ choice1, choice2 ]
q = Question.create! "content": "Me doy cuenta bastante bien de lo que otros piensan de mí.", "choice_id": nil, "explanation": "", "url": nil, "picture": nil, "parent": ti, "area": 7
q.choices.create! [ choice1, choice2 ]

puts "El proceso a finalizado sin problemas"