class Trama

    attr_accessor :personajes, :escenario

    def initialize(unos_personajes, un_escenario)
        @personajes = unos_personajes
        @escenario = un_escenario
    end

    def felicidad_personajes
        @personajes.sum{ |personaje| personaje.felicidad }
    end

    def complejidad
        @escenario.fama / felicidad_personajes
    end

    def filtrar_rebeldes_muertos
        matar_a_todos_los_rebeldes.filter{|personaje| personaje.esta_muerto?}
    end

    def matar_rebelde(personaje)
        if personaje.es_rebelde?
            personaje.morir
        end
    end

    def matar_a_todos_los_rebeldes
        @personajes.each{|personaje| matar_rebelde(personaje)}
    end

    def renovar!
        @escenario.evolucionar
        @personajes = filtrar_rebeldes_muertos
    end

    def cruzar!(otraTrama)
        personajes_conocen_escenario(otraTrama.escenario)
        cruzar_personajes!(otraTrama.personajes)
    end

    def personajes_conocen_escenario!(un_escenario)
        @personajes.each{|personaje| personaje.conocer_escenario!(un_escenario)}
    end

    def cruzar_personajes!(otros_personajes)
        @personajes.each{|personaje| personaje.interactuar_con_muchos!(otros_personajes)}
    end

    def es_aburrida?
        complejidad < 10
    end

end