%HW6
%Walter Frank Lenoir

%GB comments
1a 95 no axis labels
1b 95 no axis labels
1c 95 no axis labels
1d 95 no axis labels. 
1e 95 no axis lables
2a 95
2b 95
2c 95
Overall: 95


% Problem 1. Curve fitting. 
%Walter Frank Lenoir

% Part 1. Take 10 x values on the interval 0 < x <= 10 and then create y
% values from the x values by plugging the x values into a third order
% polynomial of your choice. Add random noise to the data by choosing a random number
% in the interval [-D, D]. Start with D = 1. Plot your data in the x-y plane.

x = (1 + (10-1)*rand(10,1));
x = sort(x);
y = 2*(x.^3) - (x.^2) - 20*x -15 + (-1 + (1-(-1))*rand(1,1));

figure;
plot(x,y);

% Part 2. Fit your data with polynomials from order 1 to 9. Plot the fitted
% polynomials together with the data. 

figure;
for i = 1:9
    [coeff,s] = polyfit(x,y,i);
    hold on;
    plot(x,polyval(coeff,x));
end
hold off;

% Part 3. On a separate plot, plot the R^2 and adjusted R^2 as a function
% of the order of the polynomial. 

order = (1:9);

for i = 1:9
poly = strcat('poly',num2str(i));
[fit_out, fit_out2] = fit(x,y,poly);
radjust(i) = fit_out2.adjrsquare;
rsquare(i) = fit_out2.rsquare;
end

figure;
plot(order,rsquare);
hold on;
plot(order,radjust);
hold off;

% Part 4. Repeat parts 1 - 3 for D = 10 and D = 1000. Comment on the
% results. 

%10
figure;
x = (1 + (10-1)*rand(10,1));
x = sort(x);
y = 2*(x.^3) - (x.^2) - 20*x -15 + (-10 + (10-(-10))*rand(1,1));

plot(x,y);

figure;
for i = 1:9
    [coeff,s] = polyfit(x,y,i);
    hold on;
    plot(x,polyval(coeff,x));
end
hold off;

order = (1:9);

for i = 1:9
poly = strcat('poly',num2str(i));
[fit_out, fit_out2] = fit(x,y,poly);
radjust(i) = fit_out2.adjrsquare;
rsquare(i) = fit_out2.rsquare;
end

figure;
plot(order,rsquare);
hold on;
plot(order,radjust);
hold off;

% 1000
figure;
x = (1 + (10-1)*rand(10,1));
x = sort(x);
y = 2*(x.^3) - (x.^2) - 20*x -15 + (-1000 + (1000-(-1000))*rand(1,1));

plot(x,y);

figure;
for i = 1:9
    [coeff,s] = polyfit(x,y,i);
    hold on;
    plot(x,polyval(coeff,x));
end
hold off;

order = (1:9);

for i = 1:9
poly = strcat('poly',num2str(i));
[fit_out, fit_out2] = fit(x,y,poly);
radjust(i) = fit_out2.adjrsquare;
rsquare(i) = fit_out2.rsquare;
end

figure;
plot(order,rsquare);
hold on;
plot(order,radjust);
hold off;

% Higher order models were able to model the polynomial better as evident
% by the rsquared and radjust graphs (higher R = model is better fit,
% variability explained by the model). With noise increasing, the first and
% second polynomials were not able to capture the variance as well as the
% third and beyond order polynomials. 

% Part 5. Now repeat parts 1-3 but take 100 x values on the interval 0 < x <=
% 10. Comment on the results.

x = (1 + (10-1)*rand(100,1));
x = sort(x);
y = 2*(x.^3) - (x.^2) - 20*x -15 + (-1 + (1-(-1))*rand(1,1));

figure;
plot(x,y);

figure;
for i = 1:9
    [coeff,s] = polyfit(x,y,i);
    hold on;
    plot(x,polyval(coeff,x));
end
hold off;

order = (1:9);

for i = 1:9
poly = strcat('poly',num2str(i));
[fit_out, fit_out2] = fit(x,y,poly);
radjust(i) = fit_out2.adjrsquare;
rsquare(i) = fit_out2.rsquare;
end

figure;
plot(order,rsquare);
hold on;
plot(order,radjust);
hold off;

%With 100 points, the curve is much smoother compared to the prior distributions.
%R square for 1st and 2nd polynomials are yield similiar results. 

% Problem 2. Basic statistics. 
% Walter Frank Lenoir
% Part 1. Consider two different distributions - Gaussian numbers with a mean of
% 0 and variance 1 and Gaussian numbers with a mean of 1 and variance 1.
% (1) Make a plot of the average p-value for the t-test comparing N random
% numbers chosen from each of these two distributions as a function of N.

clear all;
avepval = 1;
num = (1:100);
for n = 1:100

dist1 = randn(n,1);
dist2 = 1 + randn(n,1);

[is_sig,pval] = ttest2(dist1,dist2);
    if isnan(pval)
        avepval = 1;
    else
        avepval = avepval + pval;
    end
pvals(n) = avepval/n;
end
figure;
plot(num,pvals);

% Part 2. Now keep the first distribution the same, but vary the mean of
% the second distribution between 0 and 10 with the same variance and
% repeat part one. Make a plot of all of these different curves on the same
% set of axes. What is special about the case where the mean of the second
% distribution is 0? 
avepval = 1;
num = (1:100);
figure;
for d = 0:10
    for n = 1:100
    dist1 = randn(n,1);
    dist2 = d + randn(n,1);
    [is_sig,pval] = ttest2(dist1,dist2);
        if isnan(pval)
            avepval = 1;
        else
            avepval = avepval + pval;
        end
    pvals(n) = avepval/n;
    end
    plot(num,pvals);
    hold on;
end
hold off;

%The second distribution for d = 0 is different and higher than the rest because
%it is coming from the same distribution. Specifically, it should come from
%the same distribution as the first one, so the pvalue should be relatively
%high (no difference in means). 


% Part 3. Now keep the means of the two distributions at 0 and 1 as in part
% 1, but vary the variance of both distributions simultaneiously between 0.1 and 10 and plot the 
% p-values vs the number of numbers drawn as before. Comment on your results. 
avepval = 1;
num = (1:100);
figure;
for d = 0.1:10
    for n = 1:100
    dist1 = d*randn(n,1);
    dist2 = 1 + d*randn(n,1);
    [is_sig,pval] = ttest2(dist1,dist2);
        if isnan(pval)
            avepval = 1;
        else
            avepval = avepval + pval;
        end
    pvals(n) = avepval/n;
    end
    plot(num,pvals);
    hold on;
end
hold off;

% There is a lot more variation with results, and the pvalues are much
% higher compared to before. The t-test results were higher overall
% compared to part 2. 
