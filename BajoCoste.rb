require './Estandar'

class BajoCoste

    attr_accessor :zona

    def initialize(una_zona)
        @zona = una_zona
    end

    def extra
        @zona.size
    end

    def aumentar_visitas!
    end

    def evolucionar!(escenario)
        escenario.categoria=(Estandar)
    end

end