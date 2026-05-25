disp('===================================================================');
disp('Test 1');
radix = 2
rows = 0
columns = 4
encoded_vector = [0 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
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
rows = 3
columns = 3
encoded_vector = [0 1 1 1 0 1 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
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
rows = 3
columns = 3
encoded_vector = [0 1 1; 1 0 1; 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
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
rows = 3
columns = 3
encoded_vector = [0 2 1 1 0 1 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
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
rows = 3
columns = 3
encoded_vector = [0 1 1 1 0 1 1 1 0]
correct_decoded_vector = [0 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 6');
radix = 2
rows = 2
columns = 5
encoded_vector = [0 0 1 1 1 1 0 0 0 0]
correct_decoded_vector = [0 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 7');
radix = 10
rows = 3
columns = 4
encoded_vector = [1 3 6 2 4 4 1 3 6 6 0 4]
correct_decoded_vector = [1 3 2 4 1 3]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 8');
radix = 2
rows = 3
columns = 3
encoded_vector = [0 1 1 0 0 1 1 1 0]
correct_decoded_vector = [0 1 1 0]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 9');
radix = 4
rows = 3
columns = 3
encoded_vector = [1 1 3 2 2 3 2 0 2]
correct_decoded_vector = [0 1 2 3]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 10');
radix = 4
rows = 3
columns = 3
encoded_vector = [1 1 3 2 1 3 2 0 1]
correct_decoded_vector = [0 1 2 3]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 11');
radix = 4
rows = 3
columns = 3
encoded_vector = [0 1 3 3 1 3 2 0 2]
correct_decoded_vector = [0 1 2 3]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 12');
radix = 4
rows = 3
columns = 3
encoded_vector = [1 2 3 2 3 3 2 0 2]
correct_decoded_vector = [0 1 2 3]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 13');
radix = 10
rows = 3
columns = 3
encoded_vector = [2 4 0 3 4 3 6 4 0]
correct_decoded_vector = [1 2 3 4]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 14');
radix = 10
rows = 3
columns = 3
encoded_vector = [1 2 7 4 5 6 6 4 0]
correct_decoded_vector = [1 2 3 4]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 15');
radix = 10
rows = 3
columns = 3
encoded_vector = [1 5 7 3 7 3 6 7 0]
correct_decoded_vector = [1 2 3 4]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 16');
radix = 10
rows = 3
columns = 3
encoded_vector = [1 9 7 3 8 3 9 4 0]
correct_decoded_vector = [1 2 3 4]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 17');
radix = 10
rows = 3
columns = 3
encoded_vector = [1 8 3 6 4 3 6 4 0]
correct_decoded_vector = [1 2 3 4]
try
    decoded_vector = Decoder(encoded_vector, radix, rows, columns)
    
    if isequal(decoded_vector, correct_decoded_vector)
        disp('PASSED');
    else
        disp('FAILED: decoded_vector does not match correct_decoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 18');
rng(0);
radix = 10
rows = 3
columns = 3
vector_count = 10000
errors_per_vector = 1

message_vectors = randi(radix,vector_count,(rows-1)*(columns-1))-1; % Generate a big set of random message vectors
decoded_vectors = zeros(size(message_vectors)); % Allocate memory for the decoded vectors
try
    tic;
    for vector_index = 1:vector_count
        encoded_vector = Encoder(message_vectors(vector_index,:), radix, rows, columns);
        error_indices = randperm(length(encoded_vector)); % Generate some random locations for the symbol errors
        received_vector = encoded_vector; % Start with no errors
        received_vector(error_indices(1:errors_per_vector)) = mod(received_vector(error_indices(1:errors_per_vector)) + randi(radix-1,1,errors_per_vector),radix); % Introduce errors_per_vector number of symbol errors 
        decoded_vectors(vector_index,:) = Decoder(received_vector, radix, rows, columns);
    end
    toc; % Measure the efficiency of the functions
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end
error_counter = sum(sum(message_vectors ~= decoded_vectors)); % Count how many symbol errors remain in the decoded vectors
disp([num2str(error_counter),' errors could not be mitigated'])





disp('===================================================================');
disp('Test 19');
rng(0);
radix = 10
rows = 3
columns = 3
vector_count = 10000
errors_per_vector = 2

message_vectors = randi(radix,vector_count,(rows-1)*(columns-1))-1; % Generate a big set of random message vectors
decoded_vectors = zeros(size(message_vectors)); % Allocate memory for the decoded vectors
try
    tic;
    for vector_index = 1:vector_count
        encoded_vector = Encoder(message_vectors(vector_index,:), radix, rows, columns);
        error_indices = randperm(length(encoded_vector)); % Generate some random locations for the symbol errors
        received_vector = encoded_vector; % Start with no errors
        received_vector(error_indices(1:errors_per_vector)) = mod(received_vector(error_indices(1:errors_per_vector)) + randi(radix-1,1,errors_per_vector),radix); % Introduce errors_per_vector number of symbol errors 
        decoded_vectors(vector_index,:) = Decoder(received_vector, radix, rows, columns);
    end
    toc; % Measure the efficiency of the functions
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end
error_counter = sum(sum(message_vectors ~= decoded_vectors)); % Count how many symbol errors remain in the decoded vectors
disp([num2str(error_counter),' errors could not be mitigated'])





disp('===================================================================');
disp('Test 20');
rng(0);
radix = 10
rows = 3
columns = 3
vector_count = 10000
errors_per_vector = 3

message_vectors = randi(radix,vector_count,(rows-1)*(columns-1))-1; % Generate a big set of random message vectors
decoded_vectors = zeros(size(message_vectors)); % Allocate memory for the decoded vectors
try
    tic;
    for vector_index = 1:vector_count
        encoded_vector = Encoder(message_vectors(vector_index,:), radix, rows, columns);
        error_indices = randperm(length(encoded_vector)); % Generate some random locations for the symbol errors
        received_vector = encoded_vector; % Start with no errors
        received_vector(error_indices(1:errors_per_vector)) = mod(received_vector(error_indices(1:errors_per_vector)) + randi(radix-1,1,errors_per_vector),radix); % Introduce errors_per_vector number of symbol errors 
        decoded_vectors(vector_index,:) = Decoder(received_vector, radix, rows, columns);
    end
    toc; % Measure the efficiency of the functions
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end
error_counter = sum(sum(message_vectors ~= decoded_vectors)); % Count how many symbol errors remain in the decoded vectors
disp([num2str(error_counter),' errors could not be mitigated'])
