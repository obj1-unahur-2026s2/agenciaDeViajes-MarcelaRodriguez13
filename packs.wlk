
abstract class Pack {
    var duracion
    var precioBase
    const beneficios
    var coordinador

    method duracion() = duracion
    method precioBase() = precioBase
    method beneficios() = beneficios
    method coordinador() = coordinador

    // Suma solamente los beneficios vigentes, filter selecciona vigentes  y luego los suma
    method costoBeneficiosVigentes() {
        return beneficios
            .filter({ beneficio => beneficio.vigente() })
            .sum({ beneficio => beneficio.costo() })
    } 

    // Precio base más los beneficios vigentes
    method precioFinal() {
        return precioBase + self.costoBeneficiosVigentes()
    }

    // Cada tipo de pack decidirá si es premium
    method esPremium()
}


class PackNacional inherits Pack {
    var provinciaDestino
    const actividades

    method provinciaDestino() = provinciaDestino
    method actividades() = actividades

    override method esPremium() {
        return self.duracion() > 10 &&
            self.coordinador().estaAltamenteCalificado()
    }
}


class PackInternacional inherits Pack {
    var paisDestino
    var cantidadEscalas
    var lugarDeInteres

    method paisDestino() = paisDestino
    method cantidadEscalas() = cantidadEscalas
    method lugarDeInteres() = lugarDeInteres

    override method esPremium() {
        return self.lugarDeInteres() &&
            self.duracion() > 20 &&
            self.cantidadEscalas() == 0
    }

    
    
    override method precioFinal() {
        return (self.precioBase() + self.costoBeneficiosVigentes()) * 1.20
    }
}

//pack provicial 

class PackProvincial inherits PackNacional {
    const ciudadesAVisitar //cantidad de ciudades que va a visitar

    method cantidadCiudades() = ciudadesAVisitar

    override method esPremium() {
        return self.actividades().size() >= 4 &&
            self.cantidadCiudades() > 5 &&
            self.beneficios().filter({ beneficio =>
                beneficio.vigente()
            }).size() >= 3
    }

    override method precioFinal() {
        if (self.esPremium()) {
            return (self.precioBase() + self.costoBeneficiosVigentes()) * 1.05
        } else {
            return self.precioBase() + self.costoBeneficiosVigentes()
        }
    }
}



