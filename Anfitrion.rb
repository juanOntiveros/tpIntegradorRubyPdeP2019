require './Personaje'
require './Recuerdo'

class Anfitrion < Personaje

    attr_accessor :velocidad_procesamiento, :recuerdos

    def initialize(una_energia,una_velocidad_procesamiento)
        @energia = una_energia
        @velocidad_procesamiento = una_velocidad_procesamiento
        @recuerdos = []
    end

    def felicidad
        @energia.to_f / @velocidad_procesamiento
    end

    def consecuencias_de_conocer_escenario!(escenario)
        recuerdos.push(Recuerdo.new("Conoci un escenario", escenario))
    end

    def interactuar!(personaje)
        super(personaje)
        @velocidad_procesamiento /= 2
    end

    def morir
        super
        @velocidad_procesamiento = 0 
    end

end
