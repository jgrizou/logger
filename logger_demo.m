% this files examplify the use of the Logger() class in a typical experiment

%% a first experiment
% create a logger
rec1 = Logger();

for i = 1:50 % here you run something for 50 iteration
  % you code does something
  a = exp(-i*100) + rand(); % an integer
  b = rand(10,1); % a "vertical" array or column vector
  c = rand(1,10); % a "horizontal" array or line vector
  d = rand(10,10); % a matrix
  e = {}; % anything else
  % you want to track the evolution of these variable
  % different ways to do the same thing
  rec1.logit(a) % this record the variable "a" iteratively, in a ix1 array, stored as "rec.a"
  rec1.log_field('b', b) % this record the variable "b" iteratively, in a nxi matrix, stored as "rec.b"
  rec1.log_field('variableC', c) % this record the variable "c" iteratively, in a ixn matrix, stored as "rec.variableC"
  rec1.logit(d) % this record the variable "d" iteratively, in a nxnxi, stored as "rec.d"
  rec1.logit(e) % this record the variable "e" iteratively, in a ix1 cell array, stored as "rec.e"
end

% explore the rec variable now
rec % it looks like a structure, you access field as rec.a for example.
rec.a % observe that the value for each iteration are stacked
figure(); plot(rec.a) % you can directly plot the results

%% let's run a similar exepriment a second time
rec2 = Logger();
for i = 1:50
  a = exp(-i*100) + rand(); rec2.logit(a)
  b = rand(10,1); rec2.logit(b)
  c = rand(1,10); rec2.logit(c)
  d = rand(10,10); rec2.logit(d)
  e = {}; rec2.logit(e)
end

%% save the results of both experiment
rec1.save('rec1.mat') % save the full class, it will recovered as a Logger() at load time
rec1.save('rec2.mat') % save the full class, it will recovered as a Logger() at load time
% the above save function save the obj, it means you need to have the class in your path to load it properly
% if you want to keep you save generic, you have the following save function
% you can also save all fields directly, i.e. when you load it, it loads all field as variable in the workspcae, try it out
rec1.save_all_fields('rec1_all_field.mat')
rec2.save_all_fields('rec2_all_field.mat')
% you can also save a se of fields only, again try to load it to see the content
rec1.save_fields('rec1_a_field', {'a'})
rec2.save_fields('rec2_a_field', {'a'})

%% you can reload Logger() to analyse them later
clear all
load('rec1.mat')
load('rec2.mat')

%% to analyse results from different run of the same experiment, you can log a field from another Logger(). See example below:
analysisLog = Logger();
analysisLog.log_from_logger(rec1, 'a');
analysisLog.log_from_logger(rec2, 'a');

plot(analysisLog.a)

%% now feel free to use the logger class in creative ways, it is also very convenient to pass to other classes or function so as to log what is going on inside you program. Or have different hierachy of loggers. If you look for examples of practical usages, please refer to the following repositories: https://github.com/jgrizou/lfui and https://github.com/jgrizou/adhoc_com
