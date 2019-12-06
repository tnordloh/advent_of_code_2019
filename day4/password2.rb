def valid?(password)
  pairs = password.to_s.chars[0..-2].zip(password.to_s.chars[1..-1])
  pairs.all? { |pair| pair.first <= pair.last } &&
    pairs.one? { |pair| pair.first == pair.last }
end

p (272_091..815_432).select { |i| valid?(i) }.size
