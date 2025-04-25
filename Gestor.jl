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
            println("[$i] $(t.titulo) - $(t.fecha) - $(estado_str) - Categoria: $(t.categoria)")
        end
    end
end

# Marcar tarea como completada
function completarT()
    println("Ingrese la prioridad de la tarea (A, M, B):")
    prioridad = uppercase(readline())

    if !haskey(tareas, prioridad)
        println("Prioridad no válida.")
        return
    end
    if isempty(tareas[prioridad])
        println("No hay tareas en esta prioridad.")
        return
    end

    println("Tareas pendientes en la prioridad $(prioridad):")
    tareasPendientes = filter(t -> !t.estado, tareas[prioridad])
    if isempty(tareasPendientes)
        println("No hay tareas pendientes en esta prioridad.")
        return
    end
    for (i, t) in enumerate(tareasPendientes)
        println("$(i) $(t.titulo) - $(Dates.format(t.fecha, "dd-mm-yyyy"))")
    end

    println("Ingrese el numero de la tarea a completar:")
    try
        indice = parse(Int, readline())
        if indice < 1 || indice > length(tareasPendientes)
            println("Numero de tarea no valido")
            return
        end
        tareaCompletar = tareasPendientes[indice]
        tareaCompletar.estado = true
        println("Tarea marcada como completada: $(tareaCompletar.titulo)")
    catch e
        println("Error al ingresar el número de tarea:")
    end

end

# Listar tareas por fecha
function listarxFecha()
    println("\n Tareas ordenadas por fecha:")
    todas = reduce(vcat, values(tareas))
    ordenadas = sort(todas, by = t -> t.fecha)

    for (i, t) in enumerate(ordenadas)
        estado_str = t.estado ? "Completada" : "Pendiente"
        println("[$i] $(t.titulo) - $(t.fecha) - $(estado_str) - Categoria: $(t.categoria)")
    end
end

#Listar tareas por categoria
function listarxCategoria()
    println("\nTareas agrupadas por categoría:")

    todast = reduce(vcat, values(tareas))

    for categoria in Categorias
        println("\nCategoría: $categoria")
        tareaCate = filter(t -> t.categoria == categoria, todast)
        if isempty(tareaCate)
            println("  No hay tareas en esta categoría.")
        else
            tareasOrden = sort(tareaCate, by = t -> t.fecha)
            for t in tareasOrden
                estadostr = t.estado ? "Completada" : "Pendiente"
                println(" - $(t.titulo) - $(t.fecha) - $(estadostr)")
            end
        end
    end
end

function menu()
    while true
        println("\n Gestor de Tareas")
        println("1. Agregar tarea")
        println("2. Listar tareas por prioridad")
        println("3. Listar tareas por fecha")
        println("4. Listar tareas por categoria")
        println("5. Marcar tarea como completada")
        println("6. Salir")
        print("Ingrese la opcion que desea: ")
        
        opcion = readline()

        if opcion == "1"
            agregarT()
        elseif opcion == "2"
            listarxPrioridad()
        elseif opcion == "3"
            listarxFecha()
        elseif opcion == "4"
            listarxCategoria()
        elseif opcion == "5"
            completarT()
        elseif opcion == "6"
            println(" Cerrando el programa")
            break
        else
            println(" Opción no válida.")
        end
    end
end

# Iniciar el programa
menu()