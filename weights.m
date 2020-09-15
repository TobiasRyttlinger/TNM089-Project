function weight = weights(z)

zmax = 256;
zmin = 1;

if z <= (zmin + zmax)/2
    weight = z-zmin +1;
else
    weight = zmax-z +1;
end

end

