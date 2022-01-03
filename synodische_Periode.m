dT = 1
ac = 2
            %[30690,60190,90500]    %[88,225,365,687]
T = [87,365];

Z = zeros(1,length(T));
deltaT = zeros(1,length(T));
accuracy = zeros(1,length(T));

deltaT(:,:) = dT;
accuracy(:,:) = ac;

for n = 1:10^9
    
    Z = Z+deltaT./T - floor(Z+deltaT./T);
    
    a = zeros(1,length(T)-1);
    
    for i = 1:length(T)-1
        if (Z(i+1) + (accuracy(i+1)/T(i+1)) < Z(i) + (accuracy(i)/T(i))) && (Z(i+1) > Z(i)) 
            a(i) = 1;
        else
            a(i) = 0;
        end
    end
    
    if a == 1
        break
    else
        continue
    end
end

disp(['Position: ', num2str(Z)])
disp(['Days: ' , num2str(n * deltaT(1))])
disp(['Years: ' , num2str(n * deltaT(1)/365)])
disp(['DeltaPhi: ' , num2str(accuracy./T*360)])