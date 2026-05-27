function main()
%实现对二维奇偶校验码的蒙特卡洛仿真(二进制3*3)

    addpath('../practice1', '../practice2', '../practice3'); %添加编码器、解码器和信道模拟函数的路径

    radix = 2;%基数
    rows = 3;%编码矩阵的行数
    columns = 3;%编码矩阵的列数
    msg_len = (rows - 1) * (columns - 1);

    Pe_values = logspace(-3, -0.3, 10);%符号错误率范围，生成对数均匀分布的P_e值

    ser_results = zeros(size(Pe_values));

    min_errors = 100;
    max_errors = 1000;

    %对于每个P_e值,进行蒙特卡洛仿真,直到收集到足够的错误事件以估计解码后的符号错误率(SER)。在每次仿真中,随机生成一批消息向量,通过编码器得到编码向量,然后通过信道模拟函数注入错误得到接收向量,最后通过解码器得到解码向量。统计原始消息向量和解码向量之间的符号错误数量,并累积总的符号数量和错误数量。当累计的错误数量达到预设的最小或最大阈值时,计算SER并保存结果。
    for p_idx = 1:length(Pe_values)
        Pe = Pe_values(p_idx);
        total_symbols = 0;
        total_errors = 0;
        batch_size = 1000;

        while total_errors < min_errors
            message_vectors = randi(radix, batch_size, msg_len) - 1;
            decoded_vectors = zeros(size(message_vectors));

            for v = 1:batch_size
                encoded = Encoder(message_vectors(v, :), radix, rows, columns);
                received = MSC(encoded, radix, Pe);
                decoded_vectors(v, :) = Decoder(received, radix, rows, columns);
            end

            total_symbols = total_symbols + batch_size * msg_len;
            total_errors = total_errors + sum(sum(message_vectors ~= decoded_vectors));

            if total_errors >= max_errors
                break;
            end
        end

        ser_results(p_idx) = total_errors / total_symbols;

        fprintf('Pe = %.4f, SER = %.6e, errors = %d, symbols = %d\n', ...
            Pe, ser_results(p_idx), total_errors, total_symbols);

        save('simulation_results.mat', 'Pe_values', 'ser_results');
    end

    %绘制仿真结果,使用对数坐标系展示P_e和解码后SER之间的关系,并与未编码情况下的SER=P_e进行比较。
    %误码率通常符合幂律关系，在双对数坐标体系中呈现为近似线性关系。通过比较编码后的SER和未编码的SER，可以直观地展示编码带来的性能提升。
    figure;
    loglog(Pe_values, ser_results, 'b-o', 'LineWidth', 1.5, 'MarkerSize', 6);
    hold on;
    loglog(Pe_values, Pe_values, 'r--', 'LineWidth', 1);
    hold off;

    xlabel('Symbol Error Probability (Pe)');
    ylabel('Symbol Error Rate (SER) after Decoding');
    title(['Monte Carlo Simulation: ', num2str(radix), '-ary, ', ...
        num2str(rows), 'x', num2str(columns), ' 2D Parity Code']);
    legend('Decoded SER', 'Uncoded SER (Pe)', 'Location', 'northwest');
    xlim([min(Pe_values), max(Pe_values)]);
    ylim([min(ser_results(ser_results>0)) * 0.5, 1]);
    box on;
    grid on;

    savefig('simulation_results.fig');
    print('-dpng', 'simulation_results.png');

    disp('Simulation complete. Results saved.');
end

%{
预期结果
对于 $(R-1) \times (C-1)$ 的二维奇欧码：
- **单个错误可完全纠正** → 在低 $P_e$ 区域，$\text{SER} \propto P_e^2$（需要编码向量中至少 2 个符号同时出错才可能无法纠正）。
- **随着 $P_e$ 增大**，解码器纠正多重错误的能力下降，SER 曲线逐渐靠近未编码参考线。
}%