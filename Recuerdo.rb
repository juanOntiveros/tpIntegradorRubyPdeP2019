class Recuerdo

    attr_accessor :descripcion, :escenario

    def initialize(una_descripcion, un_escenario)
        @descripcion = una_descripcion
        @escenario = un_escenario
    end

    def emotividad
        @descripcion.size * @escenario.fama
    end

end