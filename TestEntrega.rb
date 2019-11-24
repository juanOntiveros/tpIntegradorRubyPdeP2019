require 'minitest/autorun'
require './Anfitrion.rb'
require './Huesped.rb'
require './Escenario.rb'
require './BajoCoste.rb'
require './Estandar.rb'
require './DeLujo.rb'
require './Trama.rb'

class TestEntrega < Minitest::Test

    def setup
        @lucio = Anfitrion.new(150, 20)
        @pedro = Anfitrion.new(10, 200)

        @tomas = Huesped.new(150,20)
        @maria = Huesped.new(1000,50)

        @personajes = [@pedro,@tomas]

        @bar = Escenario.new("Bar", BajoCoste.new("West"))
        @nave = Escenario.new("Nave", DeLujo.new)

        @partida_de_pool = Recuerdo.new("Partida de Pool", @bar)

        @trama_bar = Trama.new([@lucio, @pedro],@bar)
        @trama_nave = Trama.new([@tomas,@maria],@nave)
    end

    def test_al_consultar_la_felicidad_de_lucio_me_da_7_5
        assert_equal 7.5, @lucio.felicidad
    end

    def test_al_consultar_la_felicidad_de_pedro_me_da_0_05
        assert_equal 0.05, @pedro.felicidad
    end

    def test_al_consultar_la_felicidad_de_tomas_sin_amigos_me_da_0
        assert_equal 0, @tomas.felicidad
    end

    def test_al_consultar_la_felicidad_de_maria_sin_amigos_me_da_0
        assert_equal 0, @maria.felicidad
    end

    def test_al_agregar_a_lucio_y_pedro_como_amigos_tomas_tiene_felicidad_igual_a_151
        @tomas.agregar_amigo!(@lucio)
        @tomas.agregar_amigo!(@pedro)
        assert_equal 151, @tomas.felicidad
    end

    def test_al_agregar_a_lucio_y_pedro_como_amigos_maria_tiene_felicidad_igual_a_377_5
        @maria.agregar_amigo!(@lucio)
        @maria.agregar_amigo!(@pedro)
        assert_equal 377.5, @maria.felicidad
    end
    
    def test_lucio_no_es_rebelde
        refute @lucio.es_rebelde?
    end

    def test_pedro_es_rebelde
        assert @pedro.es_rebelde?
    end

    def test_al_iteractuar_con_pedro_lucio_pierde_la_mitad_de_su_energia
        @lucio.interactuar!(@pedro)
        assert_equal 75, @lucio.energia
    end

    def test_al_interactuar_con_pedro_lucio_pierde_la_mitad_de_su_velocidad_procesamiento
        @lucio.interactuar!(@pedro)
        assert_equal 10, @lucio.velocidad_procesamiento
    end

    def test_al_iteractuar_con_tomas_maria_pierde_la_mitad_de_su_energia
        @maria.interactuar!(@tomas)
        assert_equal 500, @maria.energia
    end

    def test_al_interactuar_con_tomas_maria_pierde_10_minutos_en_el_parque
        @maria.interactuar!(@tomas)
        assert_equal 40, @maria.minutos_restantes
    end

    def test_al_iteractuar_con_dos_personajes_lucio_queda_con_energia_igual_a_37
        @lucio.interactuar_con_muchos!(@personajes)
        assert_equal 37, @lucio.energia
    end

    def test_al_iteractuar_con_dos_personajes_lucio_queda_velocidad_procesamiento_igual_a_5
        @lucio.interactuar_con_muchos!(@personajes)
        assert_equal 5, @lucio.velocidad_procesamiento
    end

    def test_al_iteractuar_con_dos_personajes_maria_queda_con_energia_igual_a_250
        @maria.interactuar_con_muchos!(@personajes)
        assert_equal 250, @maria.energia
    end

    def test_al_iteractuar_con_dos_personajes_maria_queda_con_30_mintuos_restantes
        @maria.interactuar_con_muchos!(@personajes)
        assert_equal 30, @maria.minutos_restantes
    end

    def test_al_morir_pedro_esta_muerto_efectivamente
        @pedro.morir
        assert @pedro.esta_muerto?
    end

    def test_al_morir_pedro_tiene_una_velocidad_procesamiento_igual_a_0
        @pedro.morir
        assert_equal 0, @pedro.velocidad_procesamiento
    end

    def test_al_morir_maria_esta_muerta_efectivamente
        @maria.morir
        assert @maria.esta_muerto?
    end 

    def test_al_morir_maria_tiene_0_minutos_restantes_en_el_parque
        @maria.morir
        assert_equal 0, @maria.minutos_restantes
    end

    def test_al_conocer_el_bar_lucio_le_queda_46_de_energia
        @lucio.conocer_escenario!(@bar)
        assert_equal 46, @lucio.energia
    end

    def test_al_conocer_el_bar_lucio_tiene_un_recuerdo
        @lucio.conocer_escenario!(@bar)
        refute_empty @lucio.recuerdos
    end

    def test_al_conocer_el_bar_maria_le_queda_896_de_energia
        @maria.conocer_escenario!(@bar)
        assert_equal 896, @maria.energia
    end

    def test_al_conocer_el_bar_maria_le_quedan_40_minutos_restantes
        @maria.conocer_escenario!(@bar)
        assert_equal 40, @maria.minutos_restantes
    end

    def test_sin_evolucionar_bar_su_categoria_es_BajoCoste
        assert @bar.categoria.instance_of? BajoCoste
    end

    def test_sin_evolucionar_bar_tiene_una_fama_de_104
        assert_equal 104, @bar.fama
    end

    def test_sin_evolucionar_bar_y_ser_visitado_tiene_una_fama_de_104
        @bar.aumentar_visitas!
        assert_equal 104, @bar.fama
    end

    def test_al_evolucionar_una_vez_bar_su_categoria_es_Estandar
        @bar.evolucionar!
        assert_equal Estandar, @bar.categoria
    end

    def test_al_evolucionar_una_vez_bar_tiene_una_fama_de_110
        @bar.evolucionar!
        assert_equal 110, @bar.fama
    end

    def test_al_evolucionar_una_vez_y_ser_visitado_bar_tiene_una_fama_de_110
        @bar.evolucionar!
        @bar.aumentar_visitas!
        assert_equal 110, @bar.fama
    end

    def test_al_evolucionar_dos_veces_bar_su_categoria_es_DeLujo
        @bar.evolucionar!
        @bar.evolucionar!
        assert @bar.categoria.instance_of? DeLujo
    end

    def test_al_evolucionar_dos_veces_bar_tiene_una_fama_de_100_ya_que_no_tiene_visitas
        @bar.evolucionar!
        @bar.evolucionar!
        assert_equal 100, @bar.fama
    end

    def test_al_evolucionar_dos_veces_bar_y_ser_visitado_una_vez_tiene_una_fama_de_101
        @bar.evolucionar!
        @bar.evolucionar!
        @bar.aumentar_visitas!
        assert_equal 101, @bar.fama
    end

    def test_al_evolucionar_tres_veces_bar_lanza_CategoriaNoPuedeEvolucionarError
        @bar.evolucionar!
        @bar.evolucionar!
        assert_raises CategoriaNoPuedeEvolucionarError do 
            @bar.evolucionar!
        end
    end

    def test_la_emotividad_de_partida_de_pool_es_de_1560
        assert_equal 1560, @partida_de_pool.emotividad
    end

    def test_felicidad_personajes_de_trama_bar_es_igual_a_7_55
        assert_equal 7.55, @trama_bar.felicidad_personajes
    end

    def test_felicidad_personajes_de_trama_nave_es_igual_a_0
        assert_equal 0, @trama_nave.felicidad_personajes
    end

    def test_complejidad_de_trama_bar_es_igual_a_13_77
        assert_equal 13.77, @trama_bar.complejidad.truncate(2)
    end

    def test_matar_y_filtrar_rebeldes_de_la_trama_bar_hace_que_quede_un_personaje
        assert_equal 1, @trama_bar.matar_y_filtrar_rebeldes.size
    end

    def test_renovar_trama_bar_hace_que_el_escenario_cambie_de_categoria_a_Estandar
        @trama_bar.renovar!
        assert_equal Estandar, @trama_bar.escenario.categoria
    end

    def test_cruzar_trama_nave_con_trama_bar_hace_que_maria_tenga_energia_396
        @trama_nave.cruzar!(@trama_nave)
        assert_equal 224, @maria.energia
    end

    def test_cruzar_trama_nave_con_trama_bar_hace_que_maria_tenga_20_minutos_restantes
        @trama_nave.cruzar!(@trama_nave)
        assert_equal 20, @maria.minutos_restantes
    end

    def test_cruzar_trama_nave_con_trama_bar_hace_que_tomas_tenga_energia_12
        @trama_nave.cruzar!(@trama_nave)
        assert_equal 12, @tomas.energia
    end

    def test_cruzar_trama_nave_con_trama_bar_hace_que_tomas_no_tenga_minutos_restantes
        @trama_nave.cruzar!(@trama_nave)
        assert @tomas.minutos_restantes < 0
    end

    def test_trama_bar_no_es_aburrida
        refute @trama_bar.es_aburrida?
    end

end