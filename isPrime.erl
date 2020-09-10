-module(isPrime).
-export([checkPrime/1]).

checkPrime(0)-> false; % zero is not prime
checkPrime(1)-> false; % one is not prime
checkPrime(2)-> true; % 2 is prime


checkPrime(Num) ->   % ist call
  checkPrime(Num,2).   %starting from 2

checkPrime(Num,Num) -> true;  %Every Numumber is divisible by itself


checkPrime(Num,I)->
        ChPrime = Num rem I,
  if 
    ChPrime == 0 -> false;    %if remainer is 0 ,number is not prime
    true -> checkPrime(Num,I+1)  %otherwise call recusively
end.
