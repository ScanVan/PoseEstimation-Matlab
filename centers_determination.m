function [ center_liste ] = centers_determination(sv_r_liste, sv_t_liste)

nb_sph = length(sv_r_liste) + 1;

center_liste = cell (1, nb_sph);
for i=0:(nb_sph-1)
    center = [0 0 0];
    for j=0:(i-1)
        k=i-j;        
        center = (sv_r_liste{k}' * (center - sv_t_liste{k})')';
    end
    center_liste{i+1} = center;
end

end