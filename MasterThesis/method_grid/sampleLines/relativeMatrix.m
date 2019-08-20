function A_relative = relativeMatrix(A)


MIN = min(min(A));
MAX = max(max(A));

A_zero = A - MIN;
MAX_zero = MAX - MIN;

A_relative = A_zero.*(100/MAX_zero);