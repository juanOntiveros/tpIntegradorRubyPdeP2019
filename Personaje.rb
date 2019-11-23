class Personaje

    attr_accessor :energia

    def felicidad
    end

    def rebeldia
        1 / felicidad
    end

    def consecuencias_de_conocer_escenario!(escenario)
    end

    def conocer_escenario!(escenario)
        @energia -= escenario.fama 
        consecuencias_de_conocer_escenario!(escenario)
        escenario.aumentar_visitas!
    end

    def es_rebelde?
        rebeldia > 10
    end

    def interactuar!(personaje)
        @energia /= 2
    end

    def interactuar_con_muchos!(personajes)
        personajes.each{ |personaje| interactuar!(personaje) }
    end

    def morir
        @energia = 0
    end

    def esta_muerto?
        @energia <= 0
    end

end
