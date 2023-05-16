function root = cubicroots(a,b,c,d)
    
    if abs(a) < eps
        error('this is a quadratic')
    end
    
    count = length(a);
    
    % Divide through by a to simplify things
    b = b./a; c = c./a; d = d./a;
    bOn3 = b/3;
    
    q = (3*c - b.^2)/9;
    r = (9*b.*c - 27*d - 2*b.^3)/54;
    discriminant = q.^3 + r.^2;
    
    if discriminant >= 0        % We have 1 real root and 2 imaginary
        s = realcuberoot(r + sqrt(discriminant));   
        t = realcuberoot(r - sqrt(discriminant));
    
        root = s + t - bOn3;    % Just calculate the real root
        
    else                        % We have 3 real roots

        % In this case (r + sqrt(discriminate)) is complex so the following
        % code constructs the cube root of this complex quantity
        
        rho = sqrt(r.^2 - discriminant); 
        cubeRootrho = realcuberoot(rho); % Cube root of complex magnitude
        thetaOn3 = acos(r./rho)/3;        % Complex angle/3
        
        crRhoCosThetaOn3 = cubeRootrho.*cos(thetaOn3);
        crRhoSinThetaOn3 = cubeRootrho.*sin(thetaOn3);   

        root = zeros(count,3);
        root(:,1) = 2*crRhoCosThetaOn3 - bOn3;
        root(:,2) =  -crRhoCosThetaOn3 - bOn3 - sqrt(3)*crRhoSinThetaOn3;
        root(:,3) =  -crRhoCosThetaOn3 - bOn3 + sqrt(3)*crRhoSinThetaOn3;
    end    
    
    %-----------------------------------------------------------------------------
% REALCUBEROOT - computes real-valued cube root
%
% Usage:   y = realcuberoot(x)
%
% In general there will be 3 solutions for the cube root of a number. Two
% will be complex and one will be real valued.  When you raise a negative
% number to the power 1/3 in MATLAB you will not, by default, get the real
% valued solution. This function ensures you get the real one

function y = realcuberoot(x)
    
    y = sign(x).*abs(x).^(1/3);
