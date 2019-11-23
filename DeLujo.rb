require './excepciones/CategoriaNoPuedeEvolucionarError'

class DeLujo

    attr_accessor :visitas

    def initialize
        @visitas = 0
    end

    def extra 
        @visitas
    end

    def aumentar_visitas!
        @visitas+=1
    end

    def evolucionar!(escenario)
        raise CategoriaNoPuedeEvolucionarError, "Esta categoria no puede evolucionar"
    end

end