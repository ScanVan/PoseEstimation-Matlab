function [ sv_scene, center_liste ] = pose_scene( p3d_liste, sv_u_liste, sv_r_liste, sv_t_liste)
% Author: Marcelo Kaihara

nb_sph = length (p3d_liste);
nb_pts = length (p3d_liste{1});
center_liste = centers_determination(sv_r_liste, sv_t_liste);
sv_scene = [];

for j=1:nb_pts
    azim_liste = {};
    for i=1:nb_sph
        azim_liste{i} = p3d_liste{i}(j,:);
    end
    azim_liste = azim_determination(azim_liste, sv_r_liste, sv_t_liste);
    try 
        rayons = intersection (center_liste, azim_liste);
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
    inter = sum (cell2mat(inter_liste'),1)/length(inter_liste);
    sv_scene(j,:) = inter;
end

end

% longueur = size(p3d_1,1);
% sv_r_12 = sv_r(1:3,1:3);
% sv_r_23 = sv_r(1:3,4:6);
% sv_r_31 = sv_r(1:3,7:9);
% sv_t_12 = sv_t(1:3);
% sv_t_23 = sv_t(4:6);
% 
% c1 = zeros(1,3);
% c2 = c1 + sv_t_12;
% c3 = sv_t_12 + (sv_r_12 *sv_t_23')';
% 
% sv_scene = zeros(longueur,3);
% 
% azim1m = p3d_1;
% azim2m = (p3d_2 * sv_r_23) * sv_r_31;
% azim3m = p3d_3 * sv_r_31;
% 
% for i=1:longueur    
%     inter = intersection ([c1;c2;c3],[azim1m(i,:);azim2m(i,:);azim3m(i,:)]);
%     sv_scene(i,:)=inter;    
% end
% 
