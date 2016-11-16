module Simplex
  class Simplex

    def initialize(funcao, restricoes, tipo)
      @funcao = funcao
      @restricoes = get_retricoes(restricoes)
    end

    def get_retricoes(res)
      rest = {}
      res.each do |r|
        if (r[1]['b'].to_i > 0)

        end
        
      end
    end

  end

end