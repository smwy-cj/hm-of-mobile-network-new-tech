disp('===================================================================');
disp('Test 1');
radix = 2
Pe = 1.1
encoded_vector = [0 1 1 0]
try
    received_vector = MSC(encoded_vector, radix, Pe)
    
    disp('FAILED: an error message should be generated for these invalid function parameters');
catch err
    if isequal(err.identifier,'NJU:argChk')
        disp('PASSED: the following error message was generated');
        disp(err.message);
    else
        disp('FAILED: the following error message was generated');
        disp(err.message);
    end
end





disp('===================================================================');
disp('Test 2');
radix = 1
Pe = 0.25
encoded_vector = [0 1 1 0]
try
    received_vector = MSC(encoded_vector, radix, Pe)
    
    disp('FAILED: an error message should be generated for these invalid function parameters');
catch err
    if isequal(err.identifier,'NJU:argChk')
        disp('PASSED: the following error message was generated');
        disp(err.message);
    else
        disp('FAILED: the following error message was generated');
        disp(err.message);
    end
end





disp('===================================================================');
disp('Test 3');
radix = 2
Pe = 0.25
encoded_vector = [0 1; 1 0]
try
    received_vector = MSC(encoded_vector, radix, Pe)
    
    disp('FAILED: an error message should be generated for these invalid function parameters');
catch err
    if isequal(err.identifier,'NJU:argChk')
        disp('PASSED: the following error message was generated');
        disp(err.message);
    else
        disp('FAILED: the following error message was generated');
        disp(err.message);
    end
end





disp('===================================================================');
disp('Test 4');
radix = 2
Pe = 0.25
encoded_vector = [0 2 1 0]
try
    received_vector = MSC(encoded_vector, radix, Pe)
    
    disp('FAILED: an error message should be generated for these invalid function parameters');
catch err
    if isequal(err.identifier,'NJU:argChk')
        disp('PASSED: the following error message was generated');
        disp(err.message);
    else
        disp('FAILED: the following error message was generated');
        disp(err.message);
    end
end





disp('===================================================================');
disp('Test 5');
radix = 2
Pe = 1/2
vector_length = 499
vector_count = 20000
encoded_vectors = randi(radix, vector_count, vector_length)-1;  % Generate a big set of random encoded vectors
received_vectors = zeros(size(encoded_vectors)); % Allocate memory for the received vectors
try
    tic;
    for vector_index = 1:vector_count
        received_vectors(vector_index,:) = MSC(encoded_vectors(vector_index,:), radix, Pe);
    end
    toc; % Measure the efficiency of the function
    
    encoded_vectors = reshape(encoded_vectors,1,numel(encoded_vectors)); % Convert the encoded vectors into a single vector
    received_vectors = reshape(received_vectors,1,numel(received_vectors)); % Convert the received vectors into a single vector
    
    
    if min(received_vectors) < 0
         disp('FAILED: min(received_vectors) < 0');
    elseif max(received_vectors) >= radix
         disp('FAILED: max(received_vectors) >= radix');
    else
        stats = hist(radix*encoded_vectors(received_vectors ~= encoded_vectors)+received_vectors(received_vectors ~= encoded_vectors),0:radix^2-1)/length(encoded_vectors); % Measure some statistics for the errors in the receieved vectors
        stats = stats(stats>0) % Remove the statistics for the error free symbols
        if length(stats) ~= radix*(radix-1) % Check that all types of symbol error can occur
            disp('FAILED: length(stats) ~= radix*(radix-1)');
        elseif abs(sum(stats)-Pe) > 0.001 % Check that the symbol error probability is met
            disp('FAILED: abs(sum(stats)-Pe) > 0.001');
        elseif max(stats)-min(stats) > 0.001 % Check that all types of symbol error have equal probability of occurrence
            disp('FAILED: max(stats)-min(stats) > 0.001');
        else
            disp('PASSED');           
        end
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end





disp('===================================================================');
disp('Test 6');
radix = 4
Pe = 1/2
vector_length = 499
vector_count = 10000
encoded_vectors = randi(radix, vector_count, vector_length)-1;  % Generate a big set of random encoded vectors
received_vectors = zeros(size(encoded_vectors)); % Allocate memory for the received vectors
try
    tic;
    for vector_index = 1:vector_count
        received_vectors(vector_index,:) = MSC(encoded_vectors(vector_index,:), radix, Pe);
    end
    toc; % Measure the efficiency of the function
    
    encoded_vectors = reshape(encoded_vectors,1,numel(encoded_vectors)); % Convert the encoded vectors into a single vector
    received_vectors = reshape(received_vectors,1,numel(received_vectors)); % Convert the received vectors into a single vector
    
    
    if min(received_vectors) < 0
         disp('FAILED: min(received_vectors) < 0');
    elseif max(received_vectors) >= radix
         disp('FAILED: max(received_vectors) >= radix');
    else
        stats = hist(radix*encoded_vectors(received_vectors ~= encoded_vectors)+received_vectors(received_vectors ~= encoded_vectors),0:radix^2-1)/length(encoded_vectors); % Measure some statistics for the errors in the receieved vectors
        stats = stats(stats>0) % Remove the statistics for the error free symbols
        if length(stats) ~= radix*(radix-1) % Check that all types of symbol error can occur
            disp('FAILED: length(stats) ~= radix*(radix-1)');
        elseif abs(sum(stats)-Pe) > 0.001 % Check that the symbol error probability is met
            disp('FAILED: abs(sum(stats)-Pe) > 0.001');
        elseif max(stats)-min(stats) > 0.001 % Check that all types of symbol error have equal probability of occurrence
            disp('FAILED: max(stats)-min(stats) > 0.001');
        else
            disp('PASSED');           
        end
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end