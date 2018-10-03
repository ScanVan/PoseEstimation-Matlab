function [ positions, sv_scene] = pose_estimation( p3d_liste, error_max )
%pose_estimation Estimates the pose of the scene from the points on the sphere
%Author: Marcelo Kaihara

nb_sph = length(p3d_liste);
nb_pts = length(p3d_liste{1});

sv_u_liste =cell(1,nb_sph);
for i=1:nb_sph
    sv_u_liste{i} = ones (nb_pts, 1);
end
sv_e_old = 0;
sv_e_norm = 1;
count = 0;

while (abs(sv_e_norm-sv_e_old)>error_max)
    [sv_r_liste, sv_t_liste]=estimation_rot_trans(p3d_liste, sv_u_liste);
    [sv_u_liste, sv_e_liste]=estimation_rayons(p3d_liste, sv_u_liste, sv_r_liste, sv_t_liste);
    count = count + 1;
    sv_t_norm = 0.0;
    for i=1:length(sv_t_liste)
        sv_t_norm = sv_t_norm + norm(sv_t_liste{i});
    end
    sv_e_norm = length(sv_e_liste)*max(cell2mat(sv_e_liste)) / sv_t_norm;
end

[sv_scene, positions]=pose_scene(p3d_liste, sv_u_liste, sv_r_liste, sv_t_liste);

end

