function r = correlation_new(X,Y)


N = size(X,1);
r = (N*sum(X.*Y) - sum(X)*sum(Y))/sqrt((N*sum(X.*X)-(sum(X)*sum(X)))*(N*sum(Y.*Y)-(sum(Y)*sum(Y))));
