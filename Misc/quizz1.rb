# QUIZZ 1
# Faça um programa que parse um arquivo texto para encontrar os alunos
# que estavam presente na aula. O formato será matrícula, nome, newline:
# 12/3456789    CICRANO FULANO DA SILVA\n

File.open("engsoft.txt", "r", encoding: 'ISO-8859-1:UTF-8') do |f|
    f.each_line do |line|
        line =~ /(\d{2}\/\d{7})\s*(.+)\n$/
        if $1 != nil && $2 != nil
            puts ("#{$1}    #{$2}")
        end
    end
end