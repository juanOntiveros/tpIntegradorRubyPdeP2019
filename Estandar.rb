require './DeLujo'

module Estandar

    def self.extra
        10
    end

    def self.aumentar_visitas!
    end
    
    def self.evolucionar!(escenario)
        escenario.categoria=(DeLujo.new)
    end

end