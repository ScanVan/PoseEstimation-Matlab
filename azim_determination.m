function [ azim_liste ] = azim_determination(azim_liste, sv_r_liste, sv_t_liste)

nb_sph = length(azim_liste);

for i=0:(nb_sph-1)
    for j=0:i-1
        k=i-j;
        azim_liste{i+1} = (sv_r_liste{k}' * azim_liste{i+1}')';
    end
end

end