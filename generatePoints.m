% It generates the points for testing
% Author: Marcelo Kaihara

% % Creates a sphere
% [x,y,z]=sphere;
% 
% % Translates the sphere
% newPoints=translatePoints ([x(:), y(:), z(:)], 2, [2, 6, 0]);
% 
% x_s=newPoints(:,1);
% y_s=newPoints(:,2);
% z_s=newPoints(:,3);
% 
% newPoints=translatePoints ([x(:), y(:), z(:)], 2, [2, -6, 0]);
% 
% x_s=[x_s; newPoints(:,1)];
% y_s=[y_s; newPoints(:,2)];
% z_s=[z_s; newPoints(:,3)];
% 
% newPoints=translatePoints ([x(:), y(:), z(:)], 2, [10, 10, 0]);
% 
% x_s=[x_s; newPoints(:,1)];
% y_s=[y_s; newPoints(:,2)];
% z_s=[z_s; newPoints(:,3)];
% 
% figure(1);
% plot3(x_s,y_s,z_s,'b.');
% grid;
% 
% newPoints = [x_s, y_s, z_s];
% 
% % Project the points to spheres
% p3d_1=projectPoints(newPoints, [0, 0, 0]);
% p3d_2=projectPoints(newPoints, [2, 0, 0]);
% p3d_3=projectPoints(newPoints, [4, 0, 0]);

data;

% Plot the projected
figure(2);
clf(2);
plot3(p3d_1(:,1),p3d_1(:,2),p3d_1(:,3),'r.');
hold on
plot3(p3d_2(:,1),p3d_2(:,2),p3d_2(:,3),'g.');
hold on
plot3(p3d_3(:,1),p3d_3(:,2),p3d_3(:,3),'b.');
grid;

p3d_liste = {p3d_1, p3d_2, p3d_3};

% Reconstruct the scene
[positions, sv_scene] = pose_estimation( p3d_liste, 1e-8 );
figure;
plot3(sv_scene(:,1), sv_scene(:,2), sv_scene(:,3),'b.');
axis('equal');
grid;

