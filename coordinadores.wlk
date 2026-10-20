
class Coordinador {
    var viajesRealizados
    var motivado
    var aniosExperiencia
    var rol

    method viajesRealizados() = viajesRealizados
    method motivado() = motivado
    method aniosExperiencia() = aniosExperiencia
    method rol() = rol

    method cambiarRol(nuevoRol) {
        if (nuevoRol == "Guía" ||
            nuevoRol == "Asistente logístico" ||
            nuevoRol == "Acompañante") {
            rol = nuevoRol
        } else {
            throw new Exception(message = "Rol inválido")
        }
    }
    //coordinador 
    
    method estaAltamenteCalificado() {
        return viajesRealizados > 20 &&
            (
                (rol == "Guía" && motivado) ||
                (rol == "Asistente logístico" && aniosExperiencia >= 3) ||
                (rol == "Acompañante")
            )
    }

}
