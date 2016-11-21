class SimplexController < ApplicationController
  require 'simplex'
  layout "simplex"

  def first_step
    
  end

  def second_step
    @var_qtd = params['var-qtd'].to_i
    @res_qtd = params['res-qtd'].to_i
    session[:tipo] = params['tipo']
  end

  def results
    simplex = Simplex::Simplex.new(params['func'], params['x'], params['tb'], params['b'], session[:tipo])
    @tabelas = []
    aux = false
    while aux == false
      res = simplex.gerar_resultado
      @tabelas << res.dup
      aux = simplex.verifica_parada
    end
  end


end
