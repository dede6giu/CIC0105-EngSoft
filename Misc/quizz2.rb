# QUIZZ 2
# Expanda o programa do quizz 1 usando yield para permitir a 
# ordenação do resultado por nome ou matrícula.

def chamada
    File.open("engsoft.txt", "r", encoding: 'ISO-8859-1:UTF-8') do |f|
        f.each_line do |line|
            line =~ /(\d{2}\/\d{7})\s*(.+)\n$/
            if $1 != nil && $2 != nil
                matr = $1.strip
                nome = $2.strip
                yield matr, nome
            end
        end
    end
end

alunos = []
chamada {|matr, name| alunos.append([matr, name])}

ordem = 1 # 0 para matricula, 1 para nome 
alunos.sort!{|a, b| a[ordem] <=> b[ordem]} 
alunos.each{|el| puts "#{el[0]}    #{el[1]}"}