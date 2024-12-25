function v = vcalc(vmax,vmin,vnom,w,b)
    l = vmax;
    k = (vmin - vmax) / b;
    j = (6/b^2) * (2*vnom - vmax - vmin);
    i = -(6/b^3) * (2*vnom - vmax - vmin);

    v = i * w^3 + j * w^2 + k * w + l;
end

b = Battery("Melasta 14ah", 1, 108);

x = linspace(0, b.MaxCharge, 100);
y = linspace(0,0,100);
for in = 0:1:99
    val = (in/100)*b.MaxCharge;
    v = vcalc(b.MaxVoltage, b.MinVoltage, b.NomVoltage, val, b.MaxCharge);
    I = min((-v + sqrt(v^2 - (4 * b.Resistance * 80000))) / (-2 * b.Resistance), b.MaxCurrent);
    y(in+1) = (v - (I * b.Resistance)) * I;
end

plot(x,y);
 