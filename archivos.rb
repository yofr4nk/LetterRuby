require 'pdf/writer'
class CartaTxt 
	attr_accessor :titulo
	def initialize
		@titulo = ""
	end
	def agregar_linea
		puts "Ingresa el Titulo de la carta"
		@titulo = gets.chomp
		linea = ""
		while linea
			puts "Agregar linea de la carta, (Dejar en blanco para terminar)"
			linea = gets.chomp
			if linea.length>0
				File.open "files/#{@titulo}.txt", "a+" do |archivo|
					archivo.puts "#{linea} "
				end
				linea
			else
				linea=nil
			end
		end
	end
	def leer_carta titulo
		exist_file = Dir.glob "files/#{titulo}.txt"
		if exist_file.length>0
			puts IO.readlines "files/#{titulo}.txt"
			puts "\n \n \n \n"
		else
			puts "No se encuentra el archivo \n \n \n \n"
		end
	end
	def eliminar_carta titulo
		exist_file = Dir.glob "files/#{titulo}.txt"
		if exist_file.length>0
			File.delete("files/#{titulo}.txt")
			puts "Carta eliminada!! \n \n \n \n"
		else
			puts "No se encuentra el archivo \n \n \n \n"
		end
	end
	def mostrar_cartas
		exist_file = Dir.glob "files/*.txt"
		if exist_file.length>0
			for i in exist_file 
				files = i.gsub('files/','')
				puts " \n \n LISTA DE CARTAS:  "
				puts "\n \n #{files} \n \n \n \n"
			end
		else
			puts "No se encuentra archivos \n \n \n \n"
		end
	end
	def convertir_a_pdf titulo
		exist_file = Dir.glob "files/#{titulo}.txt"
		if exist_file.length>0
			pdf = PDF::Writer.new
			pdf.select_font "Times-Roman"
			texto = []
			File.open("files/#{titulo}.txt", "r") do |f|
			    f.each_line do |line|
			        texto.push line
			    end
			end
			pdf.text texto, :font_size => 12, :justification => :left
			pdf.save_as("../../../Descargas/#{titulo}.pdf")
			puts "Archivo Guardado correctamente en su carpeta de Descargas"
		else
			puts "No se encuentra archivos \n \n \n \n"
		end
	end
end
opcion = ""
carta = CartaTxt.new
while opcion != nil
	puts "Ingresar las opciones a realizar: \n Leer carta: 1 \n Redactar Carta 2 \n Eliminar Carta 3 \n Mostrar Cartas 4 \n Descargar cartas en Pdf 5 \n Salir 0"
	opcion = gets.chomp.to_i
	if opcion == 1
		puts "Ingresar titulo de la carta a leer"
		titulo = gets.chomp
		carta.leer_carta titulo
	elsif opcion == 2
		carta.agregar_linea
	elsif opcion == 3
		puts "Ingresar carta a eliminar"
		titulo = gets.chomp
		carta.eliminar_carta titulo 
	elsif opcion == 4
		carta.mostrar_cartas 
	elsif opcion == 5
		puts "Ingresar carta a convertir"
		titulo = gets.chomp
		carta.convertir_a_pdf titulo
	elsif opcion == 0 || opcion>5
		puts "Bye"
		opcion = nil
	end
end