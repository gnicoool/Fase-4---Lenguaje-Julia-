# Jackelyn Nicolle Giròn Villacinda
# Carnè 24737

using Dates
#Atributos de tareas
mutable struct Tarea
    titulo::String
    fecha::Date
    estado::Bool
    categoria::String
end

# Diccionario con   las prioridades para las tareas, A es alta, M es media y B es baja
tareas = Dict("A" => Tarea[], "M" => Tarea[], "B" => Tarea[])
const Categorias =["Trabajo", "Casa", "Estudio", "Personal", "Otros"]

function agregarT()
    println("Ingrese la tarea:")
    titulo = readline()

    println("Ingrese la fecha límite de la tarea (dd-mm-yyyy):")
    fechastr = readline()
    fecha = Date(fechastr, "dd-mm-yyyy")
    if fecha < today()
        println("La fecha no puede ser anterior a hoy.")
        return
    end

    println("Ingrese la prioridad de la tarea (A:alta, M:media, B:baja) :")
    prioridad = uppercase(readline())
    if !haskey(tareas, prioridad)
        println("Prioridad no válida.")
        return
    end

    println("Ingrese la categoria de su tarea (Trabajo, Casa, Estudio, Personal, Otros):")
    categoria = readline()
    if !(categoria in Categorias)
        println("Categoría no válida.")
        return
    end

    nueva_tarea = Tarea(titulo, fecha, false, categoria)
    push!(tareas[prioridad], nueva_tarea)
    println("Tarea agregada con éxito.")
end

# Listar tareas por prioridad 
function listarxPrioridad()
    for (prioridad, lista) in tareas
        println("\n+ Prioridad: $(prioridad)")
        ordenadas = sort(lista, by = t -> t.fecha)
        for (i, t) in enumerate(ordenadas)
            estado_str = t.estado ? "Completada" : "Pendiente"
            println("[$i] $(t.titulo) - $(t.fecha) - $(estado_str) - Categoria: $(collect(t.categoria))")
        end
    end
end


