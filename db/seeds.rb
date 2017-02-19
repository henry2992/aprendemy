puts "Espere un momento ..."

# Create Test Vocacional
Test.create! id: 4, title: "Test Vocacional", description: "Test Vocacional", time_limit: nil, test_type: "attitude", legend: "\u003cspan\u003e\u003cstrong\u003eArea 1:\u003c/strong\u003e Arte y Creatividad\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 2:\u003c/strong\u003e Ciencias Sociales\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 3:\u003c/strong\u003e Económica, Administrativa y Financiera\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 4:\u003c/strong\u003e Ciencia y Tecnología\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 5:\u003c/strong\u003e Ciencias Ecológicas, Biológicas y de Salud\u003c/span\u003e\u003cbr\u003e"
tv = Test.find(4)
# Create Choices for Test Vocacional's questions
choice1 = { content:"Me interesa", value_count:1 }
choice2 = { content:"No me interesa" }

Area.create! id:1, name: "Área 1", description: "Arte y Creatividad"
Area.create! id:2, name: "Área 2", description: "Ciencias Sociales"
Area.create! id:3, name: "Área 3", description: "Económica, Administrativa y Financiera"
Area.create! id:4, name: "Área 4", description: "Ciencia y Tecnología"
Area.create! id:5, name: "Área 5", description: "Ciencias Ecológicas, Biológicas y de Salud"

q = Question.create! content: "T.V-4985) Diseñar programas de computación y explorar nuevas aplicaciones tecnológicas para uso del internet.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-4986) Criar, cuidar y tratar animales domésticos y de campo", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-4987) Investigar sobre áreas verdes, medio ambiente y cambios climáticos", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-4988) Ilustrar, dibujar y animar digitalmente.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-4989) Seleccionar, capacitar y motivar al personal de una organización/empresa", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-4990) Realizar excavaciones para descubrir restos del pasado", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-4991) Resolver problemas de cálculo para construir un puente.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-4992) Diseñar cursos para enseñar a la gente sobre temas de salud e higiene", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-4993) Tocar un instrumento y componer música", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-4994) Planificar cuáles son las metas de una organización pública o privada a mediano y largo plazo.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-4995) Diseñar y planificar la producción masiva de artículos como muebles, autos, equipos de oficina, empaques y envases para alimentos y otros.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-4996) Diseñar logotipos y portadas de una revista", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-4997) Organizar eventos y atender a sus asistentes.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-4998) Atender la salud de personas enfermas.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-4999) Controlar ingresos y egresos de fondos y presentar el balance final de una institución.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5000) Hacer experimentos con plantas (frutas, árboles, flores)", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5001) Concebir planos para viviendas, edificios y ciudadelas", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5002) Investigar y probar nuevos productos farmacéuticos", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5003) Hacer propuestas y formular estrategias para aprovechar las relaciones económicas entre dos países.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5004) Pintar, hacer esculturas, ilustrar libros de arte, etcétera.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5005) Elaborar campañas para introducir un nuevo producto al mercado.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5006) Examinar y tratar los problemas visuales", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5007) Defender a clientes individuales o empresas en juicios de diferente naturaleza.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5008) Diseñar máquinas que puedan simular actividades humanas.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5009) Investigar las causas y efectos de los trastornos emocionales", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5010) Supervisar las ventas de un centro comercial", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5011) Atender y realizar ejercicios a personas que tienen limitaciones físicas, problemas de lenguaje, etcétera.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5012) Prepararse para ser modelo profesional.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5013) Aconsejar a las personas sobre planes de ahorro e inversiones.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5014) Elaborar mapas, planos e imágenes para el estudio y análisis de datos geográficos.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5015) Diseñar juegos interactivos electrónicos para computadora.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5016) Realizar el control de calidad de los alimentos", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5017) Tener un negocio propio de tipo comercial.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5018) Escribir artículos periodísticos, cuentos, novelas y otros", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5019) Redactar guiones y libretos para un programa de televisión", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5020) Organizar un plan de distribución y venta de un gran almacén", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5021) Estudiar la diversidad cultural en el ámbito rural y urbano ", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5022) Gestionar y evaluar convenios internacionales de cooperación para el desarrollo social.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5023) Crear campañas publicitarias", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5024) Trabajar investigando la reproducción de peces, camarones y otros animales marinos.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5025) Dedicarse a fabricar productos alimenticios de consumo masivo", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5026) Gestionar y evaluar proyectos de desarrollo en una institución educativa y/o fundación.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5027) Rediseñar y decorar espacios físicos en viviendas, oficinas y locales comerciales", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5028) Administrar una empresa de turismo y/o agencias de viaje.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5029) Aplicar métodos alternativos a la medicina tradicional para atender personas con dolencias de diversa índole.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5030) Diseñar ropa para niños, jóvenes y adultos.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5031) Investigar organismos vivos para elaborar vacunas.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5032) Manejar y/o dar mantenimiento a dispositivos/aparatos tecnológicos en aviones, barcos, radares, etcétera.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5033) Estudiar idiomas extranjeros –actuales y antiguos- para hacer traducción.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5034) Restaurar piezas y obras de arte", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5035) Revisar y dar mantenimiento a artefactos eléctricos, electrónicos y computadoras", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5036) Enseñar a niños de 0 a 5 años", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5037) Investigar y/o sondear nuevos mercados.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5038) Atender la salud dental de las personas", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5039) Tratar a niños, jóvenes y adultos con problemas psicológicos.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5040) Crear estrategias de promoción y venta de nuevos productos ecuatorianos en el mercado internacional.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5041) Planificar y recomendar dietas para personas diabéticas y/o con sobrepeso.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5042) Trabajar en una empresa petrolera en un cargo técnico como control de la producción.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5043) Administrar una empresa (familiar, privada o pública)", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5044) Tener un taller de reparación y mantenimiento de carros, tractores, etcétera.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5045) Ejecutar proyectos de extracción minera y metalúrgica.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5046) Asistir a directivos de multinacionales con manejo de varios idiomas.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5047) Diseñar programas educativos para niños con discapacidad", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5048) Aplicar conocimientos de estadística en investigaciones en diversas áreas (social, administrativa, salud, etcétera.)", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5049) Fotografiar hechos históricos, lugares significativos, rostros, paisajes para el área publicitaria, artística, periodística y social", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5050) Trabajar en museos y bibliotecas nacionales e internacionales.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5051) Ser parte de un grupo de teatro.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5052) Producir cortometrajes, spots publicitarios, programas educativos, de ficción, etcétera.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5053) Estudiar la influencia entre las corrientes marinas y el clima y sus consecuencias ecológicas.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5054) Conocer las distintas religiones, su filosofía y transmitirlas a la comunidad en general", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5055) Asesorar a inversionistas en la compra de bienes/acciones en mercados nacionales e internacionales.", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3
q = Question.create! content: "T.V-5056) Estudiar grupos étnicos, sus costumbres, tradiciones, cultura y compartir sus vivencias.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5057) Explorar el espacio sideral, los planetas, características y componentes.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5058) Mejorar la imagen facial y corporal de las personas aplicando diferentes técnicas.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5059) Decorar jardines de casas y parques públicos.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5060) Administrar y renovar menúes de comidas en un hotel o restaurante.", explanation: "", url: "", video_url: "", area: 5, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 5
q = Question.create! content: "T.V-5061) Trabajar como presentador de televisión, locutor de radio y televisión, animador de programas culturales y concursos.", explanation: "", url: "", video_url: "", area: 1, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 1
q = Question.create! content: "T.V-5062) Diseñar y ejecutar programas de turismo.", explanation: "", url: "", video_url: "", area: 2, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 2
q = Question.create! content: "T.V-5063) Administrar y ordenar (planificar) adecuadamente la ocupación del espacio físico de ciudades, países etc., utilizando imágenes de satélite, mapas.", explanation: "", url: "", video_url: "", area: 4, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 4
q = Question.create! content: "T.V-5064) Organizar, planificar y administrar centros educativos", explanation: "", url: "", video_url: "", area: 3, parent: tv
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 3


# Create Test de Inteligencias Múltiples
Test.create! id: 5, title: "Test de Inteligencias Múltiples", description: "Test de Inteligencias multiples", time_limit: nil, test_type: "attitude", legend: "\u003cspan\u003e\u003cstrong\u003eArea 1:\u003c/strong\u003e Int. Verbal\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 2:\u003c/strong\u003e Int. Lógico-matemática\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 3:\u003c/strong\u003e Int. Visual espacial\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 4:\u003c/strong\u003e Int. kinestesica-corporal\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 5:\u003c/strong\u003e Int. Musical-rítmica\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 6:\u003c/strong\u003e Int. Intrapersonal\u003c/span\u003e\u003cbr\u003e\u003cspan\u003e\u003cstrong\u003eArea 7:\u003c/strong\u003e Int Interpersonal\u003c/span\u003e\u003cbr\u003e"
ti = Test.find(5)

# Create Choices for Test de Inteligencias's questions
choice1 = { content:"Sí", value_count:1 }
choice2 = { content:"No" }

Area.create! id:6, name: "Área 1", description: "Int. Verbal"
Area.create! id:7, name: "Área 2", description: "Int. Lógico-matemática"
Area.create! id:8, name: "Área 3", description: "Int. Visual espacial"
Area.create! id:9, name: "Área 4", description: "Int. kinestesica-corporal"
Area.create! id:10, name: "Área 5", description: "Int. Musical-rítmica"
Area.create! id:11, name: "Área 6", description: "Int. Intrapersonal"

q = Question.create! content: "T.IM-5065) Prefiero hacer un mapa que explicarle a alguien como tiene que llegar.", explanation: "", url: "", video_url: "", area: 8, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 8
q = Question.create! content: "T.IM-5066) Si estoy enojado(a) o contento (a) generalmente sé exactamente por qué.", explanation: "", url: "", video_url: "", area: 11, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 11
q = Question.create! content: "T.IM-5067) Sé tocar (o antes sabía tocar) un instrumento musical.", explanation: "", url: "", video_url: "", area: 10, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 10
q = Question.create! content: "T.IM-5068) Asocio la música con mis estados de ánimo.", explanation: "", url: "", video_url: "", area: 10, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 10
q = Question.create! content: "T.IM-5069) Puedo sumar o multiplicar mentalmente con mucha rapidez", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5070) Puedo ayudar a un amigo a manejar sus sentimientos porque yo lo pude hacer antes en relación a sentimientos parecidos.", explanation: "", url: "", video_url: "", area: 11, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 11
q = Question.create! content: "T.IM-5071) Me gusta trabajar con calculadoras y computadores.", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5072) Aprendo rápido a bailar un ritmo nuevo.", explanation: "", url: "", video_url: "", area: 9, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 9
q = Question.create! content: "T.IM-5073) No me es difícil decir lo que pienso en el curso de una discusión o debate.", explanation: "", url: "", video_url: "", area: 6, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 6
q = Question.create! content: "T.IM-5074) Disfruto de una buena charla, discurso o sermón.", explanation: "", url: "", video_url: "", area: 6, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 6
q = Question.create! content: "T.IM-5075) Siempre distingo el norte del sur, esté donde esté.", explanation: "", url: "", video_url: "", area: 8, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 8
q = Question.create! content: "T.IM-5076) Me gusta reunir grupos de personas en una fiesta o en un evento especial.", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5077) La vida me parece vacía sin música.", explanation: "", url: "", video_url: "", area: 10, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 10
q = Question.create! content: "T.IM-5078) Siempre entiendo los gráficos que vienen en las instrucciones de equipos o instrumentos.", explanation: "", url: "", video_url: "", area: 8, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 8
q = Question.create! content: "T.IM-5079) Me gusta hacer rompecabezas y entretenerme con juegos electrónicos", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5080) Me fue fácil aprender a andar en bicicleta(o patines)", explanation: "", url: "", video_url: "", area: 9, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 9
q = Question.create! content: "T.IM-5081) Me enojo cuando oigo una discusión o una afirmación que parece ilógica.", explanation: "", url: "", video_url: "", area: 6, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 6
q = Question.create! content: "T.IM-5082) Soy capaz de convencer a otros que sigan mis planes.", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5083) Tengo buen sentido de equilibrio y coordinación.", explanation: "", url: "", video_url: "", area: 9, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 9
q = Question.create! content: "T.IM-5084) Con frecuencia veo configuraciones y relaciones entre números con más rapidez y facilidad que otros.", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5085) Me gusta construir modelos ( o hacer esculturas)", explanation: "", url: "", video_url: "", area: 9, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 9
q = Question.create! content: "T.IM-5086) Tengo agudeza para encontrar el significado de las palabras.", explanation: "", url: "", video_url: "", area: 6, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 6
q = Question.create! content: "T.IM-5087) Puedo mirar un objeto de una manera y con la misma facilidad verlo.", explanation: "", url: "", video_url: "", area: 8, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 8
q = Question.create! content: "T.IM-5088) Con frecuencia hago la conexión entre una pieza de música y algún evento de mi vida.", explanation: "", url: "", video_url: "", area: 10, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 10
q = Question.create! content: "T.IM-5089) Me gusta trabajar con números y figuras", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5090) Me gusta sentarme silenciosamente y reflexionar sobre mis sentimientos íntimos.", explanation: "", url: "", video_url: "", area: 11, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 11
q = Question.create! content: "T.IM-5091) Con sólo mirar la forma de construcciones y estructuras me siento a gusto.", explanation: "", url: "", video_url: "", area: 8, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 8
q = Question.create! content: "T.IM-5092) Me gusta tararear, silbar y cantar en la ducha o cuando estoy sola.", explanation: "", url: "", video_url: "", area: 10, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 10
q = Question.create! content: "T.IM-5093) Soy bueno(a) para el atletismo.", explanation: "", url: "", video_url: "", area: 9, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 9
q = Question.create! content: "T.IM-5094) Me gusta escribir cartas detalladas a mis amigos.", explanation: "", url: "", video_url: "", area: 6, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 6
q = Question.create! content: "T.IM-5095) Generalmente me doy cuenta de la expresión que tengo en la cara ", explanation: "", url: "", video_url: "", area: 11, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 11
q = Question.create! content: "T.IM-5096) Me doy cuenta de las expresiones en la cara de otras personas.", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5097) Me mantengo 'en contacto' con mis estados de ánimo. No me cuesta identificarlos.", explanation: "", url: "", video_url: "", area: 11, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 11
q = Question.create! content: "T.IM-5098) Me doy cuenta de los estados de ánimo de otros.", explanation: "", url: "", video_url: "", area: 7, parent: ti 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7
q = Question.create! content: "T.IM-5099) Me doy cuenta bastante bien de lo que otros piensan de mí.", explanation: "", url: "", video_url: "", area: 7, parent: ti
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 7


# Create Test de Carácter
Test.create! id: 6, title: "Test de Caracter", description: "Test de Carácter", time_limit: nil, test_type: "attitude", legend: ""
tc = Test.find(6)

choice1 = { content: "SI", value_count: 1 }
choice2 = { content: "NO" }

Area.create! id:12, name: "Área 1", description: ""
Area.create! id:13, name: "Área 2", description: ""
Area.create! id:14, name: "Área 3", description: ""
Area.create! id:15, name: "Área 4", description: ""
Area.create! id:16, name: "Área 5", description: ""
Area.create! id:17, name: "Área 6", description: ""
Area.create! id:18, name: "Área 7", description: ""
Area.create! id:19, name: "Área 8", description: ""

q = Question.create! content: "T.C-5102) Tiene mucho sentido práctico, se desenvuelve con facilidad en los problemas de la vida común y corriente.", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5103) Se le reconoce el sentido del humor. ", explanation: "", url: "", video_url: "", area: 16, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 16
q = Question.create! content: "T.C-5104) Poco sentido práctico, se desenvuelve mal en los problemas de la vida común y corriente. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5107) Calmado, ponderado, objetivo, de carácter igual.", explanation: "", url: "", video_url: "", area: 16, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 16
q = Question.create! content: "T.C-5110) Tiene en realidad reputación de valeroso frente al peligro. ", explanation: "", url: "", video_url: "", area: 16, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 16
q = Question.create! content: "T.C-5113) Poco interés por las cuestiones íntimas de la personalidad (sentimientos, emociones.", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5116) Apegado a las costumbres, rutinario. ", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5119) Le gusta una vida sencilla, adusta y moderada. ", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5122) Optimista, contento de la vida", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5125) Se le reprocha una actitud fría y despreocupada. ", explanation: "", url: "", video_url: "", area: 16, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 16
q = Question.create! content: "T.C-5127) Aprecia la elocuencia, tiene cualidades oratorias. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5129) Pone dificultades para la reconciliación: guarda durante largo tiempo el recuerdo de una ofensa. ", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5131) Se le considera como perezoso. ", explanation: "", url: "", video_url: "", area: 18, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 18
q = Question.create! content: "T.C-5132) Gusta de la grandeza y de las grandes causas.", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5133) Es tenaz y perseverante. ", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5134) Inconstantes, sentimientos vivos, móviles, cambiantes.", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5135)Se le considera de espíritu positivo y fríamente “Realista”, no se fía de los sistemas. ", explanation: "", url: "", video_url: "", area: 17, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 17
q = Question.create! content: "T.C-5136) Tiene tendencia a la melancolía.", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5137) Gusta de lo abstracto y de las teorías. ", explanation: "", url: "", video_url: "", area: 16, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 16
q = Question.create! content: "T.C-5138) Necesita mejorar la realidad; modifica con facilidad lo objetivo. ", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5139) Se le reprocha fácilmente su falta de gusto y de mesura. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5140) Gusta de las diversiones y de las cosas excitantes. ", explanation: "", url: "", video_url: "", area: 15, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 15
q = Question.create! content: "T.C-5141) Es puntual. ", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5142) Le gusta vivamente el arte subjetivo, tiene vivo sentido práctico.", explanation: "", url: "", video_url: "", area: 15, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 15
q = Question.create! content: "T.C-5143) Le gustan las novelas. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5144) Se le reconoce una autoridad natural y poder de decisión, le gusta mandar. ", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5145) Respeta los principios, los cita frecuentemente. ", explanation: "", url: "", video_url: "", area: 16, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 16
q = Question.create! content: "T.C-5146) Se le reconoce talento diplomático.", explanation: "", url: "", video_url: "", area: 17, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 17
q = Question.create! content: "T.C-5147) Desea asombrar y atraer la atención sobre sí mismo. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5148) Acogido a la vida familiar, patriota o religiosa. ", explanation: "", url: "", video_url: "", area: 15, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 15
q = Question.create! content: "T.C-5149) Se complace en la soledad.", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5150) Gusta de lo extraño, de lo raro.", explanation: "", url: "", video_url: "", area: 15, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 15
q = Question.create! content: "T.C-5151) Se le reprocha negligencia o despilfarro. ", explanation: "", url: "", video_url: "", area: 15, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 15
q = Question.create! content: "T.C-5152) Gusta del contacto con la naturaleza y de buscar refugio con ella", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5153) Muy exigente consigo mismo.", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5154) Le gusta ante todo comer, beber, dormir, predominan los deseos orgánicos. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5155) Realiza sus ambiciones esforzadamente a largo plazo y no se amilana por obstáculos.", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5156) Indeciso, tímido, vulnerable, escrupuloso y se desalienta fácilmente.", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5157) Su actividad está concentrada con ardor sobre un fin determinado, puesta al servicio de una pasión dominante.", explanation: "", url: "", video_url: "", area: 12, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 12
q = Question.create! content: "T.C-5158) Siente necesidad de acción intensa en múltiples direcciones.", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5159) Busca ante todo la tranquilidad.", explanation: "", url: "", video_url: "", area: 18, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 18
q = Question.create! content: "T.C-5160) Habla poco y no se ríe casi nunca.", explanation: "", url: "", video_url: "", area: 18, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 18
q = Question.create! content: "T.C-5161) Es cordial, de carácter expansivo y de éxito en la sociedad. ", explanation: "", url: "", video_url: "", area: 13, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 13
q = Question.create! content: "T.C-5162) Reconcentrado, vida interior intensa: dado a escribir diarios íntimos o autobiografías", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5163) Se dice que usted es irritante pero atractivo al mismo tiempo. ", explanation: "", url: "", video_url: "", area: 15, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 15
q = Question.create! content: "T.C-5164) Se le considera poco servicial y poco complaciente. ", explanation: "", url: "", video_url: "", area: 18, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 18
q = Question.create! content: "T.C-5165) Usted se complace en contar largamente los sucesos pasados; en imaginar lo que hubiera podido pasar sí. ", explanation: "", url: "", video_url: "", area: 14, parent: tc 
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 14
q = Question.create! content: "T.C-5166) Indiferente al pasado y al porvenir. ", explanation: "", url: "", video_url: "", area: 19, parent: tc  
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 19
q = Question.create! content: "T.C-5167) Le gusta la broma, la ironía fundada en el escepticismo. ", explanation: "", url: "", video_url: "", area: 17, parent: tc  
q.choices.create! [ choice1, choice2 ]
q.area_questions.create! area_id: 17

puts "El proceso a finalizado sin problemas"