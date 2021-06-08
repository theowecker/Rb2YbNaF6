%% 
clear, clc, close all
set(findall(gca,'-property','FontSize'),'FontSize',28)

RbYb = importdata('Rb2YbNaF6_2p4mg_pk3029_HC_26Aug20_headersremoved.DAT'); %low temp datafile
RbYbHigh = importdata('Rb2YbNaF6_2p4mg_pk3029_HC_26Aug20_1_high_headersremoved.DAT'); %high temp data file
RbYbFull = [RbYb;RbYbHigh]; %appending high temperature data to low

T = RbYbFull(:,8); % K, taking the 8th column of the datafile as a vector
Cp = RbYbFull(:,10)/(1e6*4.99e-6); %J/K.molYb3+, taking the 10th column of the datafile as a vector

[T,idx] = sort(T); %sort the temperature vector from low to high and make an index vector to match to specific heat
Cp = Cp(idx); %sort the specific heat by the same way that temperature was sorted

figure(1)
plot(T,Cp, 'o-', 'LineWidth', 1.25)
xlabel('Temperature (K)')
ylabel('Cp (J/K/mol Yb)')

set(findall(gca,'-property','FontSize'),'FontSize',20)

S = cumtrapz(T,Cp./T); %calculate the entropy using cumtrapz... the entropy should plateau at 5.76 R*ln(2)

figure(2)
plot(T,S, 'o-', 'LineWidth', 1.25)
xlabel('Temperature (K)')
ylabel('S (J/K/mol Yb)')

set(findall(gca,'-property','FontSize'),'FontSize',20)