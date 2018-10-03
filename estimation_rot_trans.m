function [ sv_r_liste, sv_t_liste ] = estimation_rot_trans( p3d_liste, sv_u_liste)
% Estimation of the rotation and translation of the cameras
% Based on the paper "Least-Squares Rigid Motion Using SVD" from O.
% Sorkine-Hornung and M. Rabinovich.
% The method below computes the optimal translation t and rotation R that
% minimizes \sum_{i=1}^{n} norm(R*p_i+t)-q_i)^2
% Author: Marcelo Kaihara

nb_sph = length(p3d_liste);
nb_pts = length(p3d_liste{1});

p3d_liste_exp = cell (1, nb_sph);
for i=1:nb_sph
    p3d_exp = sv_u_liste{i}.*p3d_liste{i};
    p3d_liste_exp{i} = p3d_exp;
end
    
% p3d_1_exp = sv_u.*p3d_1;
% p3d_2_exp = sv_v.*p3d_2;
% p3d_3_exp = sv_w.*p3d_3;

% Compute the centroids of the point sets
sv_cent_liste = cell (1, nb_sph);
for i=1:nb_sph
    sv_cent_liste{i} = mean(p3d_liste_exp{i},1);
end

% sv_cent_1 = mean(p3d_1_exp,1);
% sv_cent_2 = mean(p3d_2_exp,1);
% sv_cent_3 = mean(p3d_3_exp,1);

% Compute the centered vectors
sv_diff_liste = cell (1, nb_sph-1);
for i=1:nb_sph
    sv_diff_liste{i} = p3d_liste_exp{i} - repmat(sv_cent_liste{i}, length(p3d_liste_exp{i}), 1);
end

%sv_diff_1 = p3d_1_exp - repmat(sv_cent_1, size(p3d_1_exp, 1), 1);
%sv_diff_2 = p3d_2_exp - repmat(sv_cent_2, size(p3d_2_exp, 1), 1);
%sv_diff_3 = p3d_3_exp - repmat(sv_cent_3, size(p3d_3_exp, 1), 1);

%Compute the covariance matrices
sv_corr_liste = cell (1, nb_sph-1);
for i=1:(nb_sph-1)
    sv_corr_liste{i} = sv_diff_liste{i}' * sv_diff_liste{i+1};
end

% sv_corr_12 = sv_diff_1' * sv_diff_2;
% sv_corr_23 = sv_diff_2' * sv_diff_3;
% sv_corr_31 = sv_diff_3' * sv_diff_1;

% Compute the singular value decompositions.
sv_r_liste = cell (1, nb_sph-1);
sv_t_liste = cell (1, nb_sph-1);
for i=1:(nb_sph-1)
   [svd_U, ~, svd_V] = svd(sv_corr_liste{i});
   sv_r = svd_rotation(svd_V, svd_U');
   sv_t = sv_cent_liste{i+1} - (sv_r * sv_cent_liste{i}')';
   sv_r_liste{i} = sv_r;
   sv_t_liste{i} = sv_t;
end
   
% [svd_U_12, ~, svd_V_12] = svd(sv_corr_12);
% [svd_U_23, ~, svd_V_23] = svd(sv_corr_23);
% [svd_U_31, ~, svd_V_31] = svd(sv_corr_31);
% 
% sv_r_12 = svd_rotation(svd_V_12, svd_U_12');
% sv_r_23 = svd_rotation(svd_V_23, svd_U_23');
% sv_r_31 = svd_rotation(svd_V_31, svd_U_31');
% 
% sv_t_12 = sv_cent_2 - (sv_r_12 * sv_cent_1')';
% sv_t_23 = sv_cent_3 - (sv_r_23 * sv_cent_2')';
% sv_t_31 = sv_cent_1 - (sv_r_31 * sv_cent_3')';
% 
% % Output the rotation and translation matrices
% sv_r=[sv_r_12, sv_r_23, sv_r_31];
% sv_t=[sv_t_12, sv_t_23, sv_t_31];

end


    
    

