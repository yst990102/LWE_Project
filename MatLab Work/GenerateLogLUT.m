function [LUT_int, LUT_fra] = GenerateLogLUT(q,fraction_length)
    LUT = [1:q];
    LUT = vpa(log2(LUT));
    LUT = double(LUT);
    LUT = round(LUT, fraction_length);
    
    LUT_fra = mod(LUT,1);
    LUT_int = LUT - LUT_fra;
end

