% This files examplify the use of the Logger() class
clear all 

%% A first experiment

rec1 = Logger(); % Create a logger

for i = 1:10 % here you run something for 50 iteration
  % your code does something
  a = exp(-i)*10 + rand(); % an integer
  b = rand(10,1); % a "vertical" array or column vector
  c = rand(1,10); % a "horizontal" array or line vector
  d = rand(10,10); % a matrix
  e = datestr(now,'HH_MM_SS_FFF_dd_mmmm_yyyy'); % anything else will be logged in a cell array
  % Now you want to track the evolution of these variable at each iteration
  % Logger() provides different ways to do this very conveniently
  rec1.logit(a) % this record the variable "a" iteratively, in a ix1 array, stored as "rec.a"
  rec1.log_field('b', b) % this record the variable "b" iteratively, in a nxi matrix, stored as "rec.b"
  rec1.log_field('variableC', c) % this record the variable "c" iteratively, in a ixn matrix, stored as "rec.variableC"
  rec1.logit(d) % this record the variable "d" iteratively, in a nxnxi, stored as "rec.d"
  rec1.logit(e) % this record the variable "e" iteratively, in a ix1 cell array, stored as "rec.e"
end

% Explore the rec variable now
rec1 % It looks like a structure, you access field as rec.a for example.
rec1.a % Observe that the value for each iteration are stacked
figure(); plot(rec1.a) % You can directly plot the results

%% Let's run a similar experiment a second time
rec2 = Logger();
for i = 1:10
  a = exp(-i)*10 + rand(); rec2.logit(a)
  b = rand(10,1); rec2.logit(b)
  c = rand(1,10); rec2.logit(c)
  d = rand(10,10); rec2.logit(d)
  e = datestr(now,'HH_MM_SS_FFF_dd_mmmm_yyyy'); rec2.logit(e)
end

%% Save the results
% The below save function save the Logger object
% It means you need to have the class in your path to load it properly
rec1.save('rec1.mat') % save the full class, it will recovered as a Logger() at load time
rec2.save('rec2.mat') % save the full class, it will recovered as a Logger() at load time

% If you want to keep you save generic, you have the following save function
% You can also save all fields directly
rec1.save_all_fields('rec1_all_field.mat')
rec2.save_all_fields('rec2_all_field.mat')
% Loading this file will load all field as variable in the workspcae, try it out

% You can also save a set of fields only, again try to load it to see the content
rec1.save_fields('rec1_ae_fields', {'a', 'e'})
rec2.save_fields('rec2_ab_fields', {'a', 'b'})

%% Load
% You can reload a logger to analyse it later
clear all
load('rec1.mat')
load('rec2.mat')

%% 
% To analyse results from different run of the same experiment, 
% you can log a field from another Logger(). 
analysisLog = Logger();
analysisLog.log_from_logger(rec1, 'a');
analysisLog.log_from_logger(rec2, 'a');

analysisLog
analysisLog.a
figure(); plot(analysisLog.a)

%% 
% You can also copy a logger
recCopy = copy(rec1);
% It makes a deep copy, meaning changind recCopy will not affect rec1.
recCopy.log_field('f', 12);
% Check the results

%% 
% Now feel free to use the logger class in creative ways.
% It is very convenient to pass in parameters of classes or function
% to log what is going on inside you program. 
% If you look for examples of practical usages, please refer to the following repositories:
% - https://github.com/jgrizou/lfui
% - https://github.com/jgrizou/adhoc_com

% Feel free to add functionalities and issue pull request!
