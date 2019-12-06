def valid?(password)
  password = password.to_s.chars
  password.chunk_while { |a, b| a <= b }.to_a.size == 1 &&
    password.chunk_while { |a, b| a == b }.any? { |chunk| chunk.size == 2  }
end

p (272_091..815_432).select { |i| valid?(i) }.size
