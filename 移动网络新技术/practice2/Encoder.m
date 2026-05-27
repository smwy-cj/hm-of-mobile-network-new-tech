function encoded_vector = Encoder(message_vector, radix, rows, columns)
    if radix < 2
        error('NJU:argChk', 'radix must be >= 2.');
    end
    if rows < 2
        error('NJU:argChk', 'rows must be >= 2.');
    end
    if columns < 2
        error('NJU:argChk', 'columns must be >= 2.');
    end
    if ~isrow(message_vector)
        error('NJU:argChk', 'message_vector must be a row vector.');
    end
    expected_len = (rows - 1) * (columns - 1);
    if length(message_vector) ~= expected_len
        error('NJU:argChk', 'message_vector length must equal (rows-1)*(columns-1).');
    end
    if any(message_vector < 0) || any(message_vector >= radix)
        error('NJU:argChk', 'All symbols in message_vector must be in [0, radix-1].');
    end

    msg_rows = rows - 1;
    msg_cols = columns - 1;

    M = zeros(msg_rows, msg_cols);
    idx = 1;
    for c = 1:msg_cols
        for r = 1:msg_rows
            M(r, c) = message_vector(idx);
            idx = idx + 1;
        end
    end

    E = zeros(rows, columns);
    E(1:msg_rows, 1:msg_cols) = M;

    for r = 1:msg_rows
        row_sum = sum(E(r, 1:msg_cols));
        E(r, columns) = mod(radix - mod(row_sum, radix), radix);
    end

    for c = 1:msg_cols
        col_sum = sum(E(1:msg_rows, c));
        E(rows, c) = mod(radix - mod(col_sum, radix), radix);
    end

    last_row_sum = sum(E(rows, 1:msg_cols));
    E(rows, columns) = mod(radix - mod(last_row_sum, radix), radix);

    encoded_vector = zeros(1, rows * columns);
    idx = 1;
    for c = 1:columns
        for r = 1:rows
            encoded_vector(idx) = E(r, c);
            idx = idx + 1;
        end
    end
end
