function received_vector = MSC(encoded_vector, radix, Pe)
    if radix < 2
        error('NJU:argChk', 'radix must be >= 2.');
    end
    if Pe < 0 || Pe > 1
        error('NJU:argChk', 'Pe must be in [0, 1].');
    end
    if ~isrow(encoded_vector)
        error('NJU:argChk', 'encoded_vector must be a row vector.');
    end
    if any(encoded_vector < 0) || any(encoded_vector >= radix)
        error('NJU:argChk', 'All symbols in encoded_vector must be in [0, radix-1].');
    end

    received_vector = encoded_vector;
    n = length(encoded_vector);

    error_mask = rand(1, n) < Pe;
    error_indices = find(error_mask);

    for i = error_indices
        correct_val = encoded_vector(i);
        possible_vals = setdiff(0:radix-1, correct_val);
        received_vector(i) = possible_vals(randi(radix - 1));
    end
end
