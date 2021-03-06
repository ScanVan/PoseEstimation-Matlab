%function [ sv_u, sv_v, sv_w ] = estimation_rayons(p3d_1, p3d_2, p3d_3, sv_r, sv_t)
function [ sv_u_liste, sv_e_liste ] = estimation_rayons(p3d_liste, sv_u_liste, sv_r_liste, sv_t_liste)
% Author: Marcelo Kaihara

nb_sph = length(p3d_liste);
nb_pts = length(p3d_liste{1});

center_liste = centers_determination (sv_r_liste, sv_t_liste);

sv_e_liste = cell (1, nb_sph-1);
for i=1:nb_sph-1
    sv_e_liste{i} = 0;
end

for j=1:nb_pts
    azim_liste = {};
    for i=1:nb_sph
        azim_liste{i} = p3d_liste{i}(j,:);
    end
    azim_liste = azim_determination (azim_liste, sv_r_liste, sv_t_liste);
    try
        rayons = intersection (center_liste, azim_liste);
        for i=1:nb_sph
            sv_u_liste{i}(j) = rayons{i};
        end
    catch
        rayons = {};
        for i=1:nb_sph
            rayons{i} = sv_u_liste{i}(j);
        end
    end
    
    inter_liste = {};
    for i=1:nb_sph
        inter_liste{i} = center_liste{i} + azim_liste{i} * rayons{i};
    end
    for i=1:nb_sph-1
        sv_e_liste{i} = max ([sv_e_liste{i}, norm(inter_liste{i} - inter_liste{i+1})]);
    end
    
end


% longueur = size(p3d_1,1);
% 
% sv_r_12 = sv_r(1:3,1:3);
% sv_r_23 = sv_r(1:3,4:6);
% sv_r_31 = sv_r(1:3,7:9);
% 
% sv_t_12 = sv_t(1:3);
% sv_t_23 = sv_t(4:6);
% 
% c1 = zeros(1,3);
% c2 = c1 + sv_t_12;
% c3 = sv_t_12 + (sv_r_12 * sv_t_23')';
% 
% sv_u = zeros(longueur,1);
% sv_v = zeros(longueur,1);
% sv_w = zeros(longueur,1);
% 
% azim1m = p3d_1;
% azim2m = (p3d_2 * sv_r_23) * sv_r_31;
% azim3m = p3d_3 * sv_r_31;
% 
% for i=1:longueur
%     azim1 = azim1m(i,:);
%     azim2 = azim2m(i,:);
%     azim3 = azim3m(i,:);
%     
%     inter = intersection([c1; c2; c3],[azim1; azim2; azim3]);
%     
%     inter1 = c1 + (((inter-c1)*azim1') / dot(azim1,azim1) )*azim1;
%     inter2 = c2 + (((inter-c2)*azim2') / dot(azim2,azim2) )*azim2;
%     inter3 = c3 + (((inter-c3)*azim3') / dot(azim3,azim3) )*azim3;
%     
%     sv_u(i) = norm(inter1 - c1);
%     sv_v(i) = norm(inter2 - c2);
%     sv_w(i) = norm(inter3 - c3);
% end

end

