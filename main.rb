require_relative 'lib/cloth_collection'

temp = 0
loop do
  puts 'Введите температуру (можно с плюсом или минусом спереди):'
  input = gets
  if input.match?(/\A[+-]?\d+\Z/)
    temp = input.to_i
    break
  end
  puts 'Неправильно введена температура. Введите ещё раз.'
end

data_files = Dir[File.join('data', '*.txt')]
collection = ClothCollection.from_files(data_files)
cloth_set = collection.cloth_set_for_temp(temp)

if cloth_set.empty?
  puts 'Нет вещей для такой температуры.'
else
  puts 'Сегодня можно надеть:'
  puts cloth_set
end
