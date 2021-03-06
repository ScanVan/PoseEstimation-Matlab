% Show the points of the calibration images
I1=imread('img0.bmp');
Ig1 = rgb2gray(I1);

P1 = [601 1478;
    596 1394;
    591 1309;
    586 1222;
    580 1136;
    575 1053;
    570 972;
    563 895;
    556 823;
    680 1481;
    677 1396;
    674 1307;
    670 1217;
    668 1128;
    664 1041;
    660 957;
    656 878;
    652 804;
    764 1487;
    763 1398;
    762 1307;
    761 1214;
    760 1122;
    759 1033;
    757 946;
    756 865;
    754 790;
    852 1491;
    853 1401;
    855 1308;
    856 1213;
    858 1120;
    860 1029;
    862 941;
    864 858;
    866 782;
    944 1497;
    947 1406;
    951 1312;
    955 1215;
    960 1121;
    964 1029;
    969 940;
    975 858;
    980 780;
    1036 1502;
    1042 1411;
    1049 1317;
    1056 1221;
    1063 1126;
    1071 1035;
    1079 946;
    1088 863;
    1096 786];

figure; 
imshow (I1);
hold on;
plot (P1(:,1),P1(:,2),'-r');
plot (P1(:,1),P1(:,2),'xg');
plot (P1(1,1),P1(1,2),'og');  

I2 = imread('img1.bmp');
Ig2 = rgb2gray(I2);

P2 = [934 788;
    1035 697;
    1160 614;
    1305 545;
    1468 491;
    1643 456;
    1817 435;
    1982 429;
    2129 431;
    1054 862;
    1161 776;
    1279 700;
    1415 635;
    1559 585;
    1707 550;
    1857 528;
    1993 518;
    2118 516;
    1158 940;
    1262 860;
    1375 790;
    1496 728;
    1624 681;
    1752 645;
    1881 620;
    1999 606;
    2108 598;
    1247 1018;
    1346 945;
    1452 879;
    1562 822;
    1674 774;
    1788 737;
    1899 710;
    2002 692;
    2098 680;
    1324 1094;
    1418 1028;
    1515 966;
    1615 910;
    1714 864;
    1814 826;
    1913 796;    
    2004 773;
    2090 757;
    1389 1167;
    1477 1106;
    1566 1047;
    1657 994;
    1747 948;
    1837 909;
    1923 877;
    2006 851;
    2084 832];

figure; 
imshow (I2);
hold on;
plot (P2(:,1),P2(:,2),'-r');
plot (P2(:,1),P2(:,2),'xg');
plot (P2(1,1),P2(1,2),'og');  

I3 = imread('img2.bmp');
Ig3 = rgb2gray(I3);

P3 = [2424 659;
    2486 776;
    2532 891;
    2569 999;
    2598 1097;
    2621 1185;
    2640 1262;
    2657 1330;
    2671 1390;
    2252 713;
    2334 828;
    2398 940;
    2449 1047;
    2489 1143;
    2524 1230;
    2552 1306;
    2576 1372;
    2596 1430;
    2095 782;
    2191 892;
    2268 1000;
    2331 1102;
    2381 1193;
    2425 1277;
    2462 1352;
    2493 1415;
    2520 1471;
    1959 866;
    2061 966;
    2147 1068;
    2219 1162;
    2277 1248;
    2329 1326;
    2372 1397;
    2409 1457;
    2442 1510;
    1844 954;
    1946 1047;
    2036 1139;
    2113 1226;
    2179 1305;
    2235 1378;
    2285 1444;
    2327 1499;
    2365 1549;
    1747 1044;
    1846 1128;
    1937 1211;
    2016 1289;
    2086 1362;
    2147 1429;
    2201 1488;
    2248 1540;
    2290 1586];

figure; 
imshow (I3);
hold on;
plot (P3(:,1),P3(:,2),'-r');  
plot (P3(:,1),P3(:,2),'xg');  
plot (P3(1,1),P3(1,2),'og');  

%------------------------------------
w = 3008;
h = 3008;
Knew = [ w/pi 0 w/2;
    0 h/pi 0
    0 0 1];
Pinv = Knew^-1;

Pp1 = zeros(size(P1));
for i=1:size(P1,1)
    x = P1(i,1);
    y = P1(i,2);
    A = Pinv * [x y 1]';
    theta = A(1,1);
    phi = A(2,1);
    Pp1(i,:) = [theta phi];
end
    
Pp2 = zeros(size(P2));
for i=1:size(P2,1)
    x = P2(i,1);
    y = P2(i,2);
    A = Pinv * [x y 1]';
    theta = A(1,1);
    phi = A(2,1);
    Pp2(i,:) = [theta phi];
end
    
Pp3 = zeros(size(P3));
for i=1:size(P3,1)
    x = P3(i,1);
    y = P3(i,2);
    A = Pinv * [x y 1]';
    theta = A(1,1);
    phi = A(2,1);
    Pp3(i,:) = [theta phi];
end

figure;
plot(Pp1(:,1),Pp1(:,2),'r.');
hold on
plot(Pp1(:,1),Pp1(:,2),'-b');
plot(Pp1(1,1),Pp1(1,2),'og');
xlabel('theta');
ylabel('phi');
plot(Pp2(:,1),Pp2(:,2),'r.');
plot(Pp2(:,1),Pp2(:,2),'-b');
plot(Pp2(1,1),Pp2(1,2),'og');
plot(Pp3(:,1),Pp3(:,2),'r.');
plot(Pp3(:,1),Pp3(:,2),'-b');
plot(Pp3(1,1),Pp3(1,2),'og');
axis([-pi/2 pi/2 0 pi]);
    
%-------------------------------

p3d_1 = zeros(size(Pp1,1),3);
for i=1:size(Pp1,1)
    theta = Pp1(i,1);
    phi = Pp1(i,2);
    xs = sin(theta)*sin(phi);
    ys = cos(phi);
    zs = cos(theta)*sin(phi);
    p3d_1(i,:) = [xs ys zs];
end

p3d_2 = zeros(size(Pp2,1),3);
for i=1:size(Pp2,1)
    theta = Pp2(i,1);
    phi = Pp2(i,2);
    xs = sin(theta)*sin(phi);
    ys = cos(phi);
    zs = cos(theta)*sin(phi);
    p3d_2(i,:) = [xs ys zs];
end

p3d_3 = zeros(size(Pp3,1),3);
for i=1:size(Pp3,1)
    theta = Pp3(i,1);
    phi = Pp3(i,2);
    xs = sin(theta)*sin(phi);
    ys = cos(phi);
    zs = cos(theta)*sin(phi);
    p3d_3(i,:) = [xs ys zs];
end

% Plot the projected
figure;
plot3(p3d_1(:,1),p3d_1(:,2),p3d_1(:,3),'r.');
xlabel('x');
ylabel('y');
zlabel('z');
hold on
plot3(p3d_1(:,1),p3d_1(:,2),p3d_1(:,3),'-b');
plot3(p3d_1(1,1),p3d_1(1,2),p3d_1(1,3),'og');

plot3(p3d_2(:,1),p3d_2(:,2),p3d_2(:,3),'g.');
plot3(p3d_2(:,1),p3d_2(:,2),p3d_2(:,3),'-b');
plot3(p3d_2(1,1),p3d_2(1,2),p3d_2(1,3),'og');

plot3(p3d_3(:,1),p3d_3(:,2),p3d_3(:,3),'b.');
plot3(p3d_3(:,1),p3d_3(:,2),p3d_3(:,3),'-b');
plot3(p3d_3(1,1),p3d_3(1,2),p3d_3(1,3),'og');
axis([-1 1 -1 1 -1 1]);
grid;

    
% Reconstruct the scene
[sv_scene, sv_r, sv_t] = pose_estimation( p3d_1, p3d_2, p3d_3, 50 );
figure;
plot3(sv_scene(:,1), sv_scene(:,2), sv_scene(:,3),'b.');
grid;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    