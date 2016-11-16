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
    simplex = Simplex::Simplex.new(params['func'], params['r'], session[:tipo])
  end

end
