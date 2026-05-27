function decoded_vector = Decoder(received_vector, radix, rows, columns)
    if radix < 2
        error('NJU:argChk', 'radix must be >= 2.');
    end
    if rows < 2
        error('NJU:argChk', 'rows must be >= 2.');
    end
    if columns < 2
        error('NJU:argChk', 'columns must be >= 2.');
    end
    if ~isrow(received_vector)
        error('NJU:argChk', 'received_vector must be a row vector.');
    end
    expected_len = rows * columns;
    if length(received_vector) ~= expected_len
        error('NJU:argChk', 'received_vector length must equal rows*columns.');
    end
    if any(received_vector < 0) || any(received_vector >= radix)
        error('NJU:argChk', 'All symbols in received_vector must be in [0, radix-1].');
    end

    E = zeros(rows, columns);
    idx = 1;
    for c = 1:columns
        for r = 1:rows
            E(r, c) = received_vector(idx);
            idx = idx + 1;
        end
    end

    msg_rows = rows - 1;
    msg_cols = columns - 1;
    max_iterations = rows * columns;

    for iter = 1:max_iterations
        row_syndrome = mod(sum(E, 2), radix)';
        col_syndrome = mod(sum(E, 1), radix);

        corrected = false;

        for r = 1:rows
            if row_syndrome(r) == 0
                continue;
            end
            for c = 1:columns
                if col_syndrome(c) == 0
                    continue;
                end
                if row_syndrome(r) == col_syndrome(c)
                    E(r, c) = mod(E(r, c) - row_syndrome(r), radix);
                    corrected = true;
                    break;
                end
            end
            if corrected
                break;
            end
        end

        if ~corrected
            for r = 1:msg_rows
                if row_syndrome(r) == 0
                    continue;
                end
                col_candidates = find(col_syndrome(1:msg_cols) ~= 0);
                if length(col_candidates) == 1
                    c = col_candidates(1);
                    E(r, c) = mod(E(r, c) - row_syndrome(r), radix);
                    corrected = true;
                    break;
                end
            end
        end

        if ~corrected
            for c = 1:msg_cols
                if col_syndrome(c) == 0
                    continue;
                end
                row_candidates = find(row_syndrome(1:msg_rows) ~= 0);
                if length(row_candidates) == 1
                    r = row_candidates(1);
                    E(r, c) = mod(E(r, c) - col_syndrome(c), radix);
                    corrected = true;
                    break;
                end
            end
        end

        if ~corrected
            break;
        end
    end

    decoded_vector = zeros(1, msg_rows * msg_cols);
    idx = 1;
    for c = 1:msg_cols
        for r = 1:msg_rows
            decoded_vector(idx) = E(r, c);
            idx = idx + 1;
        end
    end
end
