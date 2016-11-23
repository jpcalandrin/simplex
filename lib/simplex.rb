module Simplex
  class Simplex
  
    def initialize(funcao, x, tb, b, tipo)
      @funcao = get_funcao(funcao, tipo)
      folga = get_folga(x.keys.count, b)
      @tabela = montar_tabela(funcao, x, tb, b, folga)
    end

    def get_funcao(funcao, tipo)
      if tipo == "1"
        funcao.each do |k,v|
          funcao[k] = v.to_i * (-1)
        end
      end
      funcao
    end

    def get_folga(n, b)
      n2 = n
      f = []
      n.times do |r|
        a = []
        n2.times do |r2|
          if r == r2 && b[r.to_i].to_i > 0
            a << 1
          elsif r == r2 && b[r.to_i].to_i < 0
            a << -1
          else
            a << 0
          end
        end
        f << a
      end
      f
    end

    def montar_tabela(func, x, tb, b, folga)
      tab = []
      hd = ['Base']
      func.each do |k,v|
        hd << "x#{k.to_i}"
      end
      folga.each_with_index do |f,i|
        hd << "f#{i}"
      end
      hd << 'b'
      tab << hd
      num = folga.count
      (0..num-1).each do |idx|
        row = []
        row << "f#{idx}"
        x[idx.to_s].each do |v|
          if v.to_i > 0
            row << v.to_i != '' ? v.to_i : 0
          else
            row << v.to_i != '' ? v.to_i * (-1) : 0
          end
        end
        row = row + folga[idx]
        if b[idx].to_i > 0
          row << b[idx].to_i
        else
          row << b[idx].to_i * (-1)
        end
        tab << row
      end
      row = []
      row << 'Z'
      func.each do |k,v|
        row << v.to_i
      end
      row = row + Array.new(num + 1, 0)
      tab << row
    end

    def get_tabela
      @tabela
    end

    def gerar_resultado
      res = []

      header = @tabela.shift
      idx_menor = get_menor(@tabela.last)
      col1 = @tabela.map {|row| row[idx_menor]}
      col2 = @tabela.map {|row| row.last}
      s_menor = {}
      col2.each_with_index do |v,i|
        if(col1[i] > 0 && v / col1[i] > 0)
          s_menor.merge!(i => v / col1[i])
        end
      end
      col_idx_menor = s_menor.min_by{|k, v| v}.first
      ent = s_menor.keys
      ent << col1.count - 1
      ent.delete(col_idx_menor)
      @tabela[col_idx_menor][0] = "x#{idx_menor - 1}"
      pivo = col1[col_idx_menor]
      line_sub = @tabela[col_idx_menor].dup
      var = line_sub.shift
      line_sub.each_with_index do |v, idx|
        if v != 0
          line_sub[idx] = v.to_f / pivo
        end
      end
      @tabela[col_idx_menor] = line_sub.dup
      @tabela[col_idx_menor].unshift(var)

      ent.each_with_index do |e, i|
        next_line = @tabela[e].dup
        pivo_linha = next_line.shift
        n_inv = next_line[idx_menor - 1] * (-1)
        next_line.each_with_index do |v, idx|
          next_line[idx] = line_sub[idx] * n_inv + v
        end
        @tabela[e] = next_line.dup
        @tabela[e].unshift(pivo_linha)
      end
      @tabela.unshift(header)
      return @tabela
    end

    def get_menor(row)
      row2 = row.dup
      row2.shift
      row2.min
      row2.rindex(row2.min) + 1
    end

    def verifica_parada
      parada = true
      rows = []
      @funcao.each do |k,v|
        rows << @tabela.map {|row| row[k.to_i+1]}
      end
      rows.each do |r|
        if r.last != 0
          parada = false
        end
      end
      return parada
    end

  end

end