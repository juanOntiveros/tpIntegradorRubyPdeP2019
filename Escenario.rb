class Escenario

    attr_accessor :nombre, :categoria

    def initialize(un_nombre,una_categoria)
        @nombre = un_nombre
        @categoria = una_categoria
    end

    def fama
        100 + @categoria.extra
    end

    def aumentar_visitas!
        @categoria.aumentar_visitas!
    end

    def evolucionar!
        @categoria.evolucionar!(self)
    end

end