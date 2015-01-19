# Logger class for Matlab
A very usefull matlab class to organize, log, and save any variables from your experiments
```
rec = Logger();
for i = 1:50
    a = rand(); rec.logit(a)
end
plot(rec.a)
rec.save('here.mat')
```

An extended list of examples can be found and tested in the [logger_demo.m](logger_demo.m) file.

Feel free to open issues, fork, or send pull requests.
Have fun!
