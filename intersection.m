function [ rayons ] = intersection( liste_p, liste_azim )
% Author: Marcelo Kaihara

nb_pts = length(liste_p);
sum_v = zeros(3,3);
sum_vp = zeros(1,3);

for i=1:nb_pts
    v11 = 1.0 - liste_azim{i}(1)^2;
    v22 = 1.0 - liste_azim{i}(2)^2;
    v33 = 1.0 - liste_azim{i}(3)^2;
    v12 = -liste_azim{i}(1)*liste_azim{i}(2);
    v13 = -liste_azim{i}(1)*liste_azim{i}(3);
    v23 = -liste_azim{i}(2)*liste_azim{i}(3);
    sum_v(1,1) = sum_v(1,1) + v11;
    sum_v(1,2) = sum_v(1,2) + v12;
    sum_v(1,3) = sum_v(1,3) + v13;
    sum_v(2,1) = sum_v(2,1) + v12;
    sum_v(2,2) = sum_v(2,2) + v22;
    sum_v(2,3) = sum_v(2,3) + v23;
    sum_v(3,1) = sum_v(3,1) + v13;
    sum_v(3,2) = sum_v(3,2) + v23;
    sum_v(3,3) = sum_v(3,3) + v33;
    p1 = liste_p{i}(1);
    p2 = liste_p{i}(2);
    p3 = liste_p{i}(3);
    sum_vp(1,1) = sum_vp(1,1) + p1*v11 + p2*v12 + p3*v13;
    sum_vp(1,2) = sum_vp(1,2) + p1*v12 + p2*v22 + p3*v23;
    sum_vp(1,3) = sum_vp(1,3) + p1*v13 + p2*v23 + p3*v33;
end

%inter = (inv(sum_v) * sum_vp')';
inter = (sum_v \ sum_vp')';
rayons = cell(1,nb_pts);
for i=1:nb_pts
    centre = liste_p{i};
    azim = liste_azim{i};
    inter_proj = azim * (dot(inter - centre, azim) / dot(azim, azim));
    direction = dot(inter_proj, azim);
    if (direction < 0)
        rayons{i} = (-norm(inter_proj));
    else
        rayons{i} = norm(inter_proj);
    end
end

% v=zeros(3,3,3);
% vp=zeros(3,1,3);
% 
% for i=1:3
%     v(:,:,i) = eye(3)-liste_azim(i,:)'*liste_azim(i,:);
%     vp(:,:,i) = v(:,:,i) * liste_p(i,:)';
% end
% 
% sum_v = sum(v,3);
% sum_vp = sum(vp,3);
% 
% inter = (mldivide(sum_v,sum_vp))';

end

