function encoded_vector = Encoder(message_vector, radix, rows, columns)
%实现二维奇偶校验编码器

%排除异常输入
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

%构建初始消息矩阵M和编码矩阵E
    msg_rows = rows - 1;%消息矩阵的行数
    msg_cols = columns - 1;%消息矩阵的列数

    M = zeros(msg_rows, msg_cols);
    idx = 1;
    %按列优先将消息向量填充到消息矩阵M中
    for c = 1:msg_cols
        for r = 1:msg_rows
            M(r, c) = message_vector(idx);
            idx = idx + 1;
        end
    end

    E = zeros(rows, columns);
    E(1:msg_rows, 1:msg_cols) = M;
    %按照行列和为基数radix倍数的规则计算校验符号并填充到编码矩阵E的最后一行和最后一列中
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
%将编码矩阵E按列优先展开成编码向量encoded_vector
    encoded_vector = zeros(1, rows * columns);
    idx = 1;
    for c = 1:columns
        for r = 1:rows
            encoded_vector(idx) = E(r, c);
            idx = idx + 1;
        end
    end
end
