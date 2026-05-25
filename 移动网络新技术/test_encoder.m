disp('===================================================================');
disp('Test 1');
radix = 2
rows = 0
columns = 4
message_vector = [0 1 1 0]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
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
message_vector = [0 1 1 0]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
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
message_vector = [0 1; 1 0]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
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
message_vector = [0 2 1 0]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
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
message_vector = [0 1 1 0]
correct_encoded_vector = [0 1 1 1 0 1 1 1 0]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
    if isequal(encoded_vector, correct_encoded_vector)
        disp('PASSED');
    else
        disp('FAILED: encoded_vector does not match correct_encoded_vector');
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
message_vector = [0 1 1 0]
correct_encoded_vector = [0 0 1 1 1 1 0 0 0 0]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
    if isequal(encoded_vector, correct_encoded_vector)
        disp('PASSED');
    else
        disp('FAILED: encoded_vector does not match correct_encoded_vector');
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
message_vector = [1 3 2 4 1 3]
correct_encoded_vector = [1 3 6 2 4 4 1 3 6 6 0 4]
try
    encoded_vector = Encoder(message_vector, radix, rows, columns)
    
    if isequal(encoded_vector, correct_encoded_vector)
        disp('PASSED');
    else
        disp('FAILED: encoded_vector does not match correct_encoded_vector');
    end
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






disp('===================================================================');
disp('Test 8');
rng(0); % Seed the random number generator
radix = 10
rows = 5000
columns = 5000
message_vector = randi(radix,1,(rows-1)*(columns-1))-1; % Generate a big set of random uncoded symbols
try
    tic;
    encoded_vector = Encoder(message_vector, radix, rows, columns);
    toc; % Measure the efficiency of the function
    disp('PASSED');
catch err
    disp('FAILED: the following error message was generated');
    disp(err.message);
end






