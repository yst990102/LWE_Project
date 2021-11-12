function LUT = GenerateLogLUT(q,fraction_length)
    LUT = [1:q];
    LUT = vpa(log2(LUT));
    LUT = double(LUT);
    LUT = round(LUT, fraction_length);
end

