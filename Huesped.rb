require './Personaje'

class Huesped < Personaje

    attr_accessor :minutos_restantes, :amigos

    def initialize(una_energia,unos_minutos)
        @energia = una_energia
        @minutos_restantes = unos_minutos
        @amigos = []
    end

    def agregar_amigo!(personaje)
        @amigos.push(personaje)
    end

    def felicidad
        @minutos_restantes * felicidad_amigos
    end

    def felicidad_amigos
        @amigos.sum{ |amigo| amigo.felicidad}
    end

    def consecuencias_de_conocer_escenario!(escenario)
        @minutos_restantes -= 10
    end

    def interactuar!(personaje)
        super(personaje)
        @minutos_restantes -= 10
    end

    def morir
        super
        @minutos_restantes = 0
    end

end