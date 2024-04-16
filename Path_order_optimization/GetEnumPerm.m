function p = GetEnumPerm(k, n)
% Get a permutation from enumerate number k
p = zeros(1,n);
i = 1:n;
f = factorial(n-1);
for j=n:-1:1
    r = ceil(k/f);
    k = mod(k-1, f)+1;
    p(i(r)) = n-j+1;
    i = i([1:r-1 r+1:n r]);
    f = f/(j-1);
end
end